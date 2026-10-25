# Stage A Android, native ABI and ELF draft

**Complete design contract; native/runtime/ELF BF source is NOT IMPLEMENTED.** The existing raw return-value payload is a compiler component, not a loadable app, valid context/result ABI implementation or OS callback. This draft does not supply a prebuilt executable template or claim native instructions have been generated.

## Platform contracts and target gate

Select API 35, minimum/target SDK 35, AArch64 `arm64-v8a`, framework `android.app.NativeActivity`, and a native-only debug APK. The proposed manifest is `config/stage-a/AndroidManifest.xml`. API 35 is a direct-install development target; no Play eligibility is claimed.

Primary contracts are [NativeActivity](https://developer.android.com/reference/android/app/NativeActivity), [native activity NDK ABI](https://developer.android.com/ndk/reference/group/native-activity), [NDK logging](https://developer.android.com/ndk/reference/group/logging), [application attributes](https://developer.android.com/guide/topics/manifest/application-element), [16 KiB pages](https://developer.android.com/guide/practices/page-sizes), and [zipalign](https://developer.android.com/tools/zipalign). Static local references read for this design are NDK r28c `android/native_activity.h` and `android/log.h` under the installed sysroot; no network retrieval or new target validation is claimed.

The installed header declares `ANativeActivity_createFunc(ANativeActivity*, void*, size_t)` and default `ANativeActivity_onCreate`. It documents saved-state lifetime ending after callback return. The logging header declares `int __android_log_write(int, const char*, const char*)` and return 1 on written message, or negative EPERM when not loggable. Use INFO priority 4. Do not infer successful log delivery from a nonnegative guessed return convention.

Required target facts: serial, device/image build, API, actual ABI list, active bridge where applicable, page size, stable completed boot, shell, package/activity services, install and foreground lifecycle. A property advertising ARM64 translation is insufficient. ATD x86_64-only cannot validate this ABI. A stable actual ARM64 device or a proved bridge-capable target is still required. Existing failed software runs remain failures; do not relabel them readiness.

## Callback and invocation ownership

Export BF-generated `ANativeActivity_onCreate` with the exact platform signature; package metadata selects library `cockstagea`. Keep `android.app.func_name` absent so the default symbol is used. The callback must not use the internal two-pointer guest signature directly.

The callback allocates aligned, lifetime-valid context/result storage, initializes every required field, chooses a nonzero per-process monotonic invocation identity, and calls the separately generated guest entry under AAPCS64. IDs must not wrap or be reused during the process. Maintain BF-generated native state for the next ID and a reentrancy guard; reject overflow, stale/repeated identity and recursive entry before guest effects. No conventional helper chooses or executes the app behavior. Include an observable error record for setup/ABI/guest/log failure, with platform log delivery separately assessed.

Context/result are invocation-owned and not stored past their lifetime. The no-service subset has runtime_handle zero, no heap/tape service, one inline cell and no saved app state. Do not retain savedState or activity pointers after their allowed lifetime. Concurrent/reentrant invocation is unsupported in this first profile and must be rejected by the generated guard; it is not silently serialized through an unsafe shared cell. No managed app-specific classes or DEX are supplied.

App arithmetic has a selected finite command budget; generated app code is loop-free and input-free. There is no source reading, build pipe wait or unbounded guest work on the callback thread. One bounded printable message uses the platform logging service. Measure callback return and responsiveness independently of log success. If target evidence shows synchronous logging cannot satisfy the callback contract, stop this path and draft a lifecycle-safe BF-generated worker route before changing the model. Do not claim a host kill timeout proves main-thread safety.

## Frozen internal ABI

`COCK-NATIVE-ENTRY-v1` follows Part 7.4 exactly. At entry x0 is an aligned valid mapped context pointer and x1 an aligned valid mapped writable result pointer; normal return w0 equals result status. Caller establishes pointer provenance and lifetime; alignment checks cannot prove an arbitrary address is mapped. Preserve AAPCS64 callee-saved registers, 16-byte stack alignment, caller return address and stack lifetime across platform calls. Avoid reserved x18. Do not reuse caller-saved guest state across a liblog call without preserving it.

| Context offset | Type | Required value/ownership |
| --- | --- | --- |
| 0 | u32 | ABI version 1 |
| 4 | u32 | Struct size 40 |
| 8 | u64 | Flags zero |
| 16 | u64 | Runtime handle zero for this no-service subset |
| 24 | u64 | Nonzero fresh invocation ID |
| 32 | u64 | Reserved zero |

| Result offset | Type | Meaning |
| --- | --- | --- |
| 0 | u32 | ABI version 1 |
| 4 | u32 | Struct size 56 |
| 8 | u32 | Final status, written only after its observed outcome |
| 12 | u32 | Reserved zero |
| 16 | u64 | Original source offset; all ones when not applicable |
| 24 | u64 | Executed original guest commands |
| 32 | u64 | Consumed guest input bytes, zero here |
| 40 | u64 | Logical cell count, one for an initialized invocation |
| 48 | u64 | Guest output bytes successfully emitted through the declared diagnostic sink |

The caller initializes both header versions/sizes before entry. Reject context version/size/flags/reserved/handle/identity and result version/size mismatches as ABI_VIOLATION before app arithmetic or output. Do not dereference an invalid result pointer merely to report its invalidity; use the declared platform error channel/return boundary. Normal success has non-applicable source offset, command count equal to all admitted arithmetic commands plus dot, zero consumed input, one logical cell and one output byte. The expected byte is computed by emitted instructions, not loaded from a source-name table.

Before arithmetic no guest command is counted. At final dot, validate the generated/computed result is printable, build a two-byte NUL-terminated message, and pass that message to liblog. The invocation-specific tag contains a fixed `COCK_STAGE_A_` prefix plus the invocation ID encoded by BF-generated native instructions, with checked bounded buffer capacity and NUL termination. IDs correlate native start/result observations; they do not authenticate an APK by themselves. Bind logs to the recorded installed APK hash, PID/process start and launch interval in the independent ledger.

Require `__android_log_write` return 1 for successful emission. On rejection/failure, set HOST_WRITE_FAILURE (9), source offset at the original dot and output count zero; executed commands include dot. Independently capture the matching device log before claiming the observable app behavior. A result header claiming success with absent/filtered/ambiguous logs is not device acceptance. NUL/FF/binary stdout, input EOF, generic fuel/tape services and UI are unsupported on this target profile even though tool-interpreter tests cover them.

## Native instruction generation

One BF implementation owns opcode selection, immediates, branch/call displacements, labels, address calculations and relocations. Every admitted plus/minus command emits source-dependent arithmetic in source order; preserve modulo-256 semantics. The preserved original compiler's low-byte mask per operation and the compact compiler's final mask have separate recorded identities. The default full Android compiler must document which proven arithmetic path it uses, without silently inheriting an optional optimization.

The known raw words remain independent test anchors: initialize `00008052`, addition `00040011`, subtraction `00040051`, low-byte truncate `001c0053`, return `c0035fd6`, each shown in file-byte order. These anchors are not a full ABI entry, callback or ELF. Emit prologue/epilogue, context validation, checked counters, result stores, invocation-tag encoding, byte output check, liblog call and error branches as real BF-generated instructions, with exact test expectations before accepting them. Derive source maps and source-dependent regions from the admitted offset ledger.

No host assembler/linker/compiler may generate production instructions or relocate the final executable. Existing LLVM tools may independently decode or veto BF output. A manually fabricated binary fixture, copied whole native executable or inspection-only `llvm-objcopy` object cannot supply the production runtime.

## ELF construction and loading

Produce an ELF64 little-endian ET_DYN object, machine EM_AARCH64 183, ELF version 1, appropriate native program headers and a zero unused executable entry. Check all u64 addition/multiplication/align-up operations before writing. Layout is input-sized under the selected native-byte budget; do not encode a permanent app-size limit by assuming all source always fits one fixed page.

The minimum complete ELF inventory is:

| Structure | Required BF-owned content and independent check |
| --- | --- |
| ELF/program headers | Correct sizes/counts/offsets; program-header table included in a readable load mapping |
| RX load mapping | Header/metadata where valid and generated executable text; no writable executable page |
| RW mapping | Only required writable invocation state, relocated import slots and dynamic structures; no overlapping permission aliases |
| Dynamic metadata | Correct dynamic table, bounded string/symbol/hash tables and terminators, linked addresses and entry sizes |
| Exports | Defined global callable `ANativeActivity_onCreate` and `cock_guest_run_v1` at actual BF-generated entries |
| Imports | Declared `liblog.so` and `__android_log_write`, plus only separately documented real platform dependencies |
| Relocations | Correct AArch64 relocation type, symbol index, addend, target/address and bounds; no text relocations |
| Hardening/lifetime | Non-executable stack; separate final permissions; RELRO where emitted dynamic/GOT layout requires it; state remains writable |
| Sections when emitted | Valid section/string/symbol indices, offsets, sizes, alignments and no contradictory duplicate metadata |
| Native map | Exact source-derived text regions, callback/guest code, runtime helpers, data and padding accounted separately |

Use AArch64 dynamic linking supported by the selected Android API. Resolve liblog through valid BF-generated import/relocation machinery; do not patch addresses with a host linker or substitute raw host function pointers. Check load segment file/memory sizes, congruent p_offset/p_vaddr, alignment, nonoverlap, read/write/execute permissions, relocation destinations and all symbol/string ranges. Reject malformed/oversized native output as INVALID_BINARY_ARTIFACT before packaging.

The proposed compatibility profile sets PT_LOAD alignment to 16 KiB, and the debug packager stores the library uncompressed with 16-KiB ZIP alignment. ELF and APK alignment are different checks. Independently verify actual 4-KiB and 16-KiB target loading only where available; the current host's observed 4-KiB image says nothing about 16-KiB execution. No Play policy or multi-device claim follows from direct sideload success.

## Failure and teardown

Check explicit failures for invalid ABI records, stale/reentrant invocation, counter/offset overflow, invalid library/import/manifest symbol, relocation corruption, nonprintable app source, log rejection, activity recreation and shutdown. Any emitted helper must restore ABI state on every normal-return path. No pending worker, retained activity pointer, writable executable mapping or borrowed savedState may survive teardown. Test repeated activity creation/rotation and fresh process starts without reusing stale observation records.

The target is limited log-observed debug behavior. Window rendering, input queue handling, accessibility, arbitrary permissions/services, persistent state and general event handling are unsupported until their own generated runtime and target evidence exist. NativeActivity's framework implementation is a permitted platform component; a custom conventional app shim is not.
