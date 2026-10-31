# Integrated native compiler and current device evidence

2026-10-26, Asia/Kuala_Lumpur. **Stage A is incomplete.** The integrated normalized-source native producer is implemented and component-tested. It is not a complete annotated-source build entry, an accepted whole-stage baseline or a production release. [Exact results](android-native-compiler-evidence.json), [frozen slice plan](android-native-compiler-plan.md), [nested execution](same-kernel-evidence.md).

## Implemented result

`src/android_native_compiler.bf` combines whole-normalized-input admission, the bounded 220-byte NativeActivity callback, source-ordered guest generation and source-sized ELF emission in one annotated BF program. The host supplies no native instructions or calculated native size. Its 39,748 source bytes contain 29,542 executable commands. Existing standalone producers remain unchanged for regression and comparison.

The program buffers all normalized input before emitting an artifact. It accepts wrapping arithmetic and exactly one final printable output. Source spans repeated u8-counted chunks; the 255-byte chunk boundary is not a total source limit. Checked u16 command/native-size fields are component representation limits, not a universal application policy. Original annotated-source grammar, source identity, the supplied original dot offset and physical input closure remain caller preconditions.

The diagnostic input is `dot_offset:u64le | counted source chunks | 00 A5`. Accepted output is `01 | ELF_size:u32le | exact ELF | A5`; rejection is `00`. This is explicitly not BFIO or a complete source/status protocol. Both a complete record and independent successful producer/transport closure are required. The one-bit rejection does not implement the master's structured source/error diagnostics.

## Verified batch

| Check | Actual result |
| --- | --- |
| Independent repository annotation/alphabet/bracket audit | 81/81 BF files pass; no foreign executable source extension introduced |
| BF source gate | Integrated producer, new nested request driver and reference interpreter accepted; fresh Q source accepted |
| Existing annotated-source vectors | 18/18 pass, including NUL, unsafe comments, CRLF, unmatched brackets and UTF-8 rejection |
| New same-kernel request driver | 3/3 literal cases pass, including binary zero, bang and FF |
| Root/reference binary I/O | All 256 byte values and EOF-zero pass; expanded root repeats the same 257-byte control |
| Direct native positive packets | A, B, a 256-command case and fresh Q match separate BF producers exactly; BF comparisons return zero |
| Unsupported/malformed normalized source | All 13 frozen rejection cases emit only zero |
| Missing/bad trailer, truncated source, missing terminator | All four reject before native output |
| Native-size boundary | 16,270 commands generate 65,532 guest bytes and an 82,176-byte ELF; next native-size overflow rejects |
| Native callback regressions | Six complete state records pass, including two calls, sink failure, busy guard, exhausted IDs, maximum-ID wrap and forced exclusive-store exhaustion |
| Wrong Android entry | Isolated package crashes with `UnsatisfiedLinkError` for `COCK_missing_entry`; negative package removed |

The CPU regressions execute exact callback/guest bytes extracted from the integrated A library in BF-generated syscall ELF wrappers on the physical ARM64 kernel. They do not substitute for Bionic loading. The sink-failure fixture uses original offset 185, the supplied A source offset, rather than the historical normalized offset 32; the BF comparison checks its propagation.

## Real BF-in-BF and Android outputs

The unchanged, separately attributed `src/bf_in_bf_reference.bf` interprets the entire integrated producer as a BF guest. Complete outputs match direct generation. The external seed's compiled representation of that same reference accelerates its execution; no handwritten conventional interpreter or app algorithm is added.

| App | Arithmetic instructions independently decoded | Guest bytes | Complete packet bytes | BF-in-BF remote seconds | Observed Android byte |
| --- | --- | ---: | ---: | ---: | --- |
| A | 32 additions | 584 | 16,646 | 98.087024 | space `20` |
| B | 33 additions | 588 | 16,646 | 121.3391054 | bang `21` |
| Fresh Q | seven subtractions then 88 additions | 836 | 16,646 | 364.7462593 | Q `51` |

The fresh [Q source](../examples/heldout_stagea_q.bf) was selected after the native producer's draft snapshot. The independent BF arithmetic oracle emits `51`. Its normalized stream has 96 commands and its final dot is original byte offset 365. LLVM independently counts seven `sub w22, w22, #1` instructions and 88 corresponding additions.

All three 41,382-byte debug APKs install and launch on the selected Pixel 8 Pro, API 37, native `arm64-v8a`, 4096-byte pages. Each uses the same external package metadata and disposable certificate, includes the exact self-hosted BF-generated library, has no DEX, verifies with APK Signature Scheme v3 and passes 16-KiB ZIP alignment. Installed APKs were pulled back and matched to their local SHA-256. The fresh Q package remains installed and force-stopped; the older debug package was not overwritten.

Raw log capture preserves the space-only result. Correlation binds installed APK identity, fresh PID, launch interval and invocation tag. Cold activity-manager observations were 903, 554 and 495 ms; these are individual launch observations, not general latency guarantees or whole-build benchmarks.

A second Q launch independently verifies the actual Android callback result. Debug-UID mechanical reads of its own 96-byte invocation state match a literal expected record through BF comparison: guard zero, callback/native status zero, invocation ID one, 96 commands, one logical cell and one output byte. Its same-PID log contains Q. The process was force-stopped after inspection. No other app memory was inspected.

## Mandatory failure and remaining work

**Identical-interpreter nesting of this integrated compiler still fails.** A 600-second attempt with explicitly expanded 64-MiB root tape capacity exits 124 with zero output. An earlier 2-MiB attempt was deliberately cancelled (143) before the capacity repair and is not accepted as a result. Raw compact compiler nesting does pass for A and B, but cannot replace the required complete Android compiler proof. The callback-only nested attempt times out with one byte; the guest-only attempt also times out. See the complete [nested ledger](same-kernel-evidence.json).

Accordingly:

1. The full same-interpreter compiler chain is **BLOCKED** under the tested resource envelope. Larger root capacity alone did not resolve the timeout. Exact hotspots and a safe remedy remain unproved.
2. Complete original annotated-source admission, error precedence/offsets and immutable-source handoff are **NOT IMPLEMENTED as one build entry**. Boolean component checks and caller-provided offsets do not satisfy that gate.
3. BF-owned artifact authority, independent closure/session checks and a readable-source-to-debug-APK CLI remain **INCOMPLETE**. The narrow diagnostic producer record is not that implementation.

No Stage B promotion, optional COCK optimization, production signing or whole-stage integration is claimed. API 35 execution, a 16-KiB runtime, broad Android services, UI, general app BF commands and binary app stdout remain unsupported or untested as previously documented.

## Tools, identities and reproduction boundary

ADB is `C:/platform-tools/adb.exe`; the tested transport was explicitly selected with `-t 1`. SDK/NDK tools are under `C:/Android/Sdk`, build tools `37.0.0`, platform resources `android-37.0`, NDK `28.2.13676358`. Minimum/target SDK remain 35. The upstream Tritium device seed retains SHA-256 `ea3162818ae74c52d51b494784faa5d1a2426dae02ed1155d12e4533a4f43743` and the previously recorded upstream identity.

The pretest source snapshot is `C:/Android/cock-runs/20261026-stagea/integrated-native-draft.zip`, SHA-256 `314a6b6aa424cc1e8a888ca999067aeb3decb484d4e189bc84e38bc2997224cc`. Sources, closed requests/results, independent inspection, signatures and logs are preserved in that run directory. Tested literal native requests/expected packets are checked in under `fixtures/android_native_compiler`. Git metadata was absent in this checkout; no commit or recoverable Git baseline is invented.

For an existing admitted literal fixture, the direct diagnostic command is:

```text
C:/platform-tools/adb.exe -t 1 push src/android_native_compiler.bf fixtures/android_native_compiler/native-a.input.bin /data/local/tmp/cock-stagea/
C:/platform-tools/adb.exe -t 1 shell "/data/local/tmp/cock-tritium -r -b -z -B -O3 /data/local/tmp/cock-stagea/android_native_compiler.bf < /data/local/tmp/cock-stagea/native-a.input.bin > /data/local/tmp/cock-stagea/candidate.record; echo EXIT:$?"
```

That direct command is a control, not the self-hosting claim. The preserved one-layer recipe contains counted normalized producer source and the exact fixture. `tests/nested_reference_transport.bf` constructs `producer!input`; executing the reference root on it produces the checked complete packet. `tests/same_kernel_request.bf` constructs `reference!producer!input` for the mandatory nested test. All physical file counts and successful read/write/close outcomes remain independent preconditions. This is component reproduction, not the absent general build CLI.

External `aapt2` compiles inert debug metadata; the installed .NET ZIP API stores unchanged BF bytes; `zipalign` precedes disposable `keytool`/`apksigner` signing. These are **DEBUG-ONLY** services. Keys/passwords stay outside the checkout with restricted file access. Certificate SHA-256 is `898864a01110c81415572f88b86065f562a35dea5be0d4da16e1c608e340b0d5`. No release key was used.

Two harness errors were caught and repaired: an invalid expected-packet concatenation produced a BF comparison failure, and redundant password-file arguments caused the first signing attempt to hit EOF. Correct fixture encoding and signing invocation were rerun; final records compare and verify successfully. Neither repair changed BF compiler source or relaxed a test.

Platform feasibility follows the published [NativeActivity contract](https://developer.android.com/ndk/reference/group/native-activity), [Android logging contract](https://developer.android.com/ndk/reference/group/logging) and [ZIP alignment ordering](https://developer.android.com/tools/zipalign). The reference remains [Daniel B Cristofani's BF interpreter](https://brainfuck.org/dbfi.b), with its existing [attribution and license](self-host-reference-credits.md).
