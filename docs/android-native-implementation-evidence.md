# Android native implementation — 2026-10-26

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Three real BF components now generate a source-dependent AArch64 guest, NativeActivity creation callback and Android shared library. Their native CPU and byte-level checks pass. Two externally debug-signed APK candidates pass signature, alignment, manifest and native-identity checks. **Android installation, Bionic loading, actual liblog delivery and lifecycle acceptance remain NOT RUN. Stage A–E are not complete.**

## Implemented behavior

[android_guest_entry.bf](../src/android_guest_entry.bf) emits the real cock_guest_run_v1 entry: null/alignment checks on caller pointers, 40/56-byte context/result header validation, one inline wrapping byte, source-ordered arithmetic, command accounting, invocation-specific hexadecimal tag, NUL-terminated printable message, imported log call and checked return. Log return must equal one; other returns report status 9 and the supplied original-dot offset. Invalid context reports 14 before effects; invalid result headers return 14 without altering them. Native mapped-pointer provenance and fresh-ID ownership remain caller obligations.

[android_activity_callback.bf](../src/android_activity_callback.bf) emits 204 bytes of actual callback code at library offset 0x800. It allocates aligned invocation-owned headers, makes one exclusive guard-claim attempt, checks monotonic ID overflow, calls the guest at 0x1000, copies all 56 result bytes into observable state and releases the guard. Busy rejection preserves the live guard and records status 14 separately. Exhaustion preserves the last ID and records 10. It never retains the platform activity or saved-state pointers.

[android_library_elf.bf](../src/android_library_elf.bf) emits an actual ET_DYN container. Both entries are exported; liblog.so supplies __android_log_write through a BF-emitted AArch64 GLOB_DAT relocation. RX size, text size and aligned RW file offset derive from the supplied native size. The library has separate RX/RW mappings, 16-KiB load alignment, nonexecuting stack, immediate binding, RELRO, writable invocation BSS and complete section metadata. The selected component native-byte budget is u16, not a platform-wide source limit.

The backend requires already admitted complete normalized arithmetic source and an authentic original-offset ledger. The ELF component requires authentic BF native producers and physical byte-count/closure authority. Neither implements the untrusted-source frontend, opcode validator, framed artifact finalizer or complete production build graph. An incomplete or forged dependency must never be published merely because the external process exited zero.

## Actual checks

| Check | Result |
| --- | --- |
| Current source admission | 5/5 BF files accepted |
| Native guest CPU vectors | 17/17 exact complete outputs |
| Post-freeze held-out program | Passed source-order/wrap/count carry: 289 commands |
| Two-call NativeActivity CPU vectors | 5/5 exact output/state records |
| Actual BF-in-BF component execution | Guest, callback and complete ELF builder all matched |
| BF byte comparisons | 26/26 equal, one deliberate inequality rejected |
| Existing compiler artifacts | All six original/compact outputs unchanged |
| Real source-generated libraries | Space, bang and held-out candidates inspected |
| Container size boundaries | 16,384- and 65,535-byte inert payloads inspected |
| Missing/bad final guard | Both leave only incomplete 16,384-byte prefixes |
| Embedded native identity | Callback/guest bytes extracted and matched for four layout vectors |
| Debug APKs | Space and bang: signature, 16-KiB ZIP alignment, metadata and extracted library identity passed |
| Android device | No connected ADB target; host has no KVM |
| Full mandatory identical-interpreter nested compiler | Prior proof remains unpassed; not rerun unchanged |

The 17 guest cases include context version/size/flags/handle/zero ID/reserved, immutable bad result version/size, defensive nonprintable bytes, mixed source order, byte wrapping, a nontrivial 64-bit invocation ID, and negative/zero/non-one-positive sink returns. The callback cases cover successive IDs, sink failures, busy rejection, exhausted ID and exactly one maximum-ID invocation before wrap rejection. Actual scheduler contention, unmapped pointers and platform lifecycle are not exercised.

CPU tests use two BF-authored ELF wrappers with hand-authored Linux syscall encodings. The exact production callback and guest bytes are copied into them; an independent diagnostic sink records the tag/message and supplies the chosen return. Linux CPU emulation is not Bionic or Android execution. LLVM independently decoded the native instructions and inspected final ELF structures. Inspection-only objcopy objects never supplied production bytes. No conventional assembler or linker generated these libraries.

The external evaluator is Tritium 1.2.73, SHA256 0ac670ed3128db52bfa73347d6f81eccd864ebd91f8a7d450d8efb2278178a5b. It remains an external standards-only bootstrap with known qualification limits; its conventional host execution backend does not author the native output. Unmodified Debian QEMU AArch64 10.0.13 was installed outside the checkout. Debian InRelease was verified with sqv and the installed Debian keyring; the Packages.xz SHA256 matched that authenticated release; the package SHA256 matched that index. Package and executable hashes are recorded in JSON. No package-signature, checksum or TLS check was bypassed.

## Draft checkpoints and repairs

All first-pass source, fixtures and plans were frozen before each batch. Read-only archives remain under /workspace/test-results/android-native-guest-20261026:

| Archive | SHA256 |
| --- | --- |
| pretest.tar | e2bb808f4a7021c4cbe81ae403a42bd4baa8c5feb808f1b29f236166176e2d7f |
| callback/pretest.tar | 70e950b27863ffeef54fddba49024b894210869f929aa278cf5c038a7959bcbf |
| library/pretest.tar | 7924a39505c148c6d37c668010af249f5c6bc0ed3695e41be4dc15ab6e3baf11 |

The guest CPU wrapper initially emitted 7f454e46 instead of ELF magic 7f454c46; initial load failures are retained. One-byte repair made all native CPU cases pass. Guest and callback native producers required no post-freeze source repairs.

The ELF batch required three coordinated repairs: separate literal scratch from retained native counters and correct text carry/permission handling; reset the printer between section-name dot and first letter; clear metadata scratch before the wide guest-copy loop. The maximum-count vector exposed the last bug: 255 guest bytes and the 256-byte dynamic area were absent. All valid layout vectors now have exact expected lengths and no LLVM warnings. Failures remain alongside final outputs; they were not reclassified as passes. A first BF-in-BF launch used unavailable /usr/bin/time and exited 127 before execution; the corrected shell timing invocation passed.

No project optimization batch was performed. One-layer BF-in-BF measured wall times, including evaluator startup, were 6.235 seconds for the guest producer, 1.977 seconds for the callback producer and 227.297 seconds for the complete library producer. These are host diagnostics, not Android startup or a production build-latency claim.

## Reproduction and artifacts

Run from /workspace/COCK. Root component flags are:

~~~text
/workspace/tools/bin/tritium -r -c -b -z -B -O3 -fno-negtape
~~~

Guest input is eight little-endian raw-dot-offset bytes followed by the admitted normalized program. Callback producer input is empty. Library input is u16 guest size, 204 BF callback bytes, exact guest bytes and A5. CPU wrapper input is u16 guest size followed by guest bytes; the callback CPU wrapper additionally receives 204 callback bytes immediately after that count. Runtime fixture input differs: see the respective literal JSON files.

The retained concrete inputs and complete expected outputs can be replayed with:

~~~sh
/workspace/tools/bin/tritium -r -c -b -z -B -O3 -fno-negtape src/android_guest_entry.bf < /workspace/test-results/android-native-guest-20261026/space/backend.input > /tmp/cock-guest.raw
/workspace/tools/bin/tritium -r -c -b -z -B -O3 -fno-negtape src/android_activity_callback.bf > /tmp/cock-callback.raw
/workspace/tools/bin/tritium -r -c -b -z -B -O3 -fno-negtape src/android_library_elf.bf < /workspace/test-results/android-native-guest-20261026/library/space/input > /tmp/libcockstagea.so
cmp artifacts/android-native-candidate/space.so /tmp/libcockstagea.so
/workspace/tools/qemu/usr/bin/qemu-aarch64 /workspace/test-results/android-native-guest-20261026/callback/callback.elf < /workspace/test-results/android-native-guest-20261026/callback/two_success/input > /tmp/cock-callback-output
cmp /workspace/test-results/android-native-guest-20261026/callback/two_success/expected /tmp/cock-callback-output
~~~

For BF-in-BF, tests/wide_request.bf constructs the counted request from the normalized source, u32 fuel ffffffff, u16 tape capacity 128 and exact input byte count. The root runs src/source_pc_dynamic_tape.bf with the above flags plus **-mem 2097152 as two arguments**. Each complete output matched the direct component bytes followed by the interpreter's provisional zero status. Physical process/pipe closure remains independently required. This is one interpretation layer; the missing same-interpreter two-layer compiler proof remains mandatory.

Tracked candidates are artifacts/android-native-candidate/{space,bang,heldout}.so, each 16,640 bytes. APKs remain outside the checkout at /workspace/test-results/android-native-guest-20261026/apks/{space,bang}/debug.apk. External aapt2/zip/zipalign/apksigner provide only the documented debug metadata/container/signature exception. Both verify with APK Signature Scheme v3. The exact BF-native library is the only app-specific executable in each APK; there is no app DEX. Reused disposable debug signing material remains protected outside the checkout and was neither printed nor committed.

The reusable environment draft now saves the tested QEMU installation and updated startup instructions, preserving SDK setup and existing network settings. Saving does not publish the environment: review/save it in environment settings and publish to use the updated snapshot.

Remaining work includes complete annotated-original-source admission/offset ledger, authoritative producer/host-I/O framing and build graph, mandatory full nested execution, actual Android target acceptance, full eight-command AOT/runtime, BF-native signing and the event/UI platform. These candidate components do not close A01–A14 or B–E.
