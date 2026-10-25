# Physical-device verification and callback repair

Date: 2026-10-26, Asia/Kuala_Lumpur. **The bounded callback/device slice is tested. Stage A remains incomplete; Stage B and later stages are not accepted.** [Exact results and identities](windows-device-evidence.json), [plan/checkpoints](windows-device-plan.md), [acceptance](acceptance.md) and [open issues](stage-a-issues.md).

## Observed result

Four BF-generated native-only debug APKs install and run on the explicitly selected Pixel 8 Pro (`husky`), Android API 37, native `arm64-v8a`, 4096-byte pages. Their logs contain the expected source-derived bytes: space, exclamation, space from the prior mixed/wrapping fixture, and H from a fresh held-out source. The second connected device was not modified. Full serial is omitted from public evidence; its hash and the selected transport are recorded in JSON.

All final APKs verify with Signature Scheme v3 and 16-KiB ZIP alignment. Each contains the exact BF-generated library, Android metadata/resources and signature entries, with no DEX or other app-specific executable. Each installed positive APK was pulled back and matched to its local SHA-256. Independently decoded manifest fields retain minimum/target SDK 35, `hasCode=false`, framework NativeActivity and `cockstagea`. Resources were compiled using installed API 36 tools; API 37 execution does not prove API 35 runtime compatibility.

| Candidate | Native guest bytes | ELF bytes | Debug APK bytes | Observed byte |
| --- | ---: | ---: | ---: | --- |
| space | 584 | 16640 | 41382 | `20` |
| bang | 588 | 16640 | 41382 | `21` |
| previous mixed held-out | 1608 | 16640 | 41382 | `20` |
| fresh H | 768 | 16640 | 41382 | `48` |

The fresh [source](../examples/heldout_device_h.bf) was chosen after the repair implementation checkpoint. Three subtractions and seventy five additions compute H with byte wrapping. Its final dot is original byte offset 284. Its native result reports status zero, 79 commands and one output; guard and callback returned status are zero. The complete 96-byte state is recorded in JSON.

Exact fresh log: `10-26 06:15:54.001 31524 31524 I COCK_STAGE_A_0000000000000001: H`. Space logs were captured without trimming: raw capture ends in `20 0a`, after logcat's buffer header. Correlation uses installed APK identity, fresh PID, launch interval and invocation tag together; ID one can repeat in a new process.

## Failure and smallest repair

The original APK installed, Bionic loaded `libcockstagea.so`, and NativeActivity returned, but no expected byte appeared. Debug-UID memory inspection showed next invocation ID zero, guard zero and rejection status 14. The callback attempted LDAXR/STLXR only once and treated a failed exclusive store as final busy admission. Exclusive stores can fail when the reservation is lost; a retry must restart the exclusive sequence. See Arm's [exclusive-access rules](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/IHI0022H_amba_axi_protocol_spec.pdf), section D9.2.3.

`src/android_activity_callback.bf` now permits at most sixteen acquisition attempts. A nonzero guard is still rejected immediately; retry exhaustion returns the same rejection without guest work or an unbounded main-thread spin. Successful acquisition retains the original ID/overflow, invocation-owned context/result, call, result-copy and release behavior.

The callback grows from 204 to 220 bytes. Its guest call displacement, ELF symbol size, copy counts and padding in the library producer and native CPU wrapper were updated together. Callback remains at `0x800`, guest at `0x1000`, state at `0x104000`; public ABI and three prior guest instruction regions are unchanged. Repaired libraries are tracked under [native candidates](../artifacts/android-native-candidate/README.md); originals are recoverable from baseline commit `69b163d4b236cdabeb34fe3851280cbed1cca868`.

Six native callback regressions pass with independent BF byte comparisons: successive successful IDs, sink rejection, an already-owned guard, exhausted ID, maximum-ID then wrap rejection, and forced store-exclusive failure. The BF-only [failure adapter](../tests/android_callback_exclusive_failure.bf) replaces the acquisition LDAXR with a regular load in a test-only callback. Stores then lack a reservation; the bounded loop terminates with zero guard, no guest effects and status 14. These diagnostic bytes never enter an APK. BF-generated syscall ELF wrappers execute the exact callback/guest on the physical Android ARM64 kernel; the separate APK tests establish Bionic loading.

## Self-hosting and source checks

The real producers execute as guests of unchanged `src/source_pc_dynamic_tape.bf`. Complete outputs match direct BF generation, including the interpreter's trailing provisional zero status:

| Producer | Complete output bytes | Measured remote-call seconds |
| --- | ---: | ---: |
| repaired callback | 221 | 0.9784459 |
| space guest | 585 | 3.7214936 |
| space library | 16641 | 168.4341493 |

Bang and fresh H guest generation also match through BF-in-BF (589 and 769 bytes including status). The BF normalizer and counted request serializer construct these diagnostic requests. Source admission and independent closed physical files remain caller preconditions. This component pipeline is not a completed BF-owned build graph.

All 78 repository BF files pass independent static annotation/alphabet/bracket inspection. The five changed/new BF files also pass the existing BF source-record serializer and annotated-source gate. Thirty literal interpreter controls and five frozen interpreter/compiler/tape fixtures pass with the external accelerated seed. These results do not establish complete production source or bootstrap authority.

**Mandatory nesting failed again.** The exact existing `fixtures/dynamic_kernel/nested/compact.input.bin` ran on the physical device through the external C backend of the unchanged BF interpreter. After 900 seconds it timed out with exit 124 and only `00 00 80`, versus the required 18 bytes including both statuses. No complete nested compiler result exists. Partial native prefixes are failure, not a milestone pass. This gate and the integrated frontend/build authority prevent Stage A acceptance and Stage B promotion.

## External tools and reproducibility

The unmodified upstream [Tritium](https://github.com/rdebath/Brainfuck), commit `525d346c006ea30dfc847ae3b32ed44d44fa9925`, was built outside the repository using NDK r28c `aarch64-linux-android35-clang`, `-std=gnu11 -O3 -fwrapv` and the upstream `tritium/*.c` files. The Android seed passes all 256 binary byte values and EOF-to-zero. Windows builds were rejected because text-mode stdio changed newline and treated `1a` as EOF; none of their generated bytes was packaged.

For acceleration, upstream `-c` generated the C representation of the unchanged BF interpreter outside the checkout. NDK compiled that output with `-include stdlib.h -O3 -fwrapv`; the include supplies the upstream backend's missing `exit` declaration. No handwritten conventional interpreter/compiler or app algorithm was added. The seed/backend hashes, source identity and controls are in JSON. Full COCK guest/host authority qualification remains incomplete.

Raw local inputs, outputs, readelf/disassembly results, signatures, extracted APK contents, selected-process logs and checkpoints remain at `D:/Android/cock-runs/20261026-device`. Upstream tools are in `D:/Android/cock-tools`. The local disposable key and password remain outside Git in the restricted run directory; no release key was used.

These component reproduction commands use the tested flags and require the explicitly selected device serial and installed external seed. They operate on trusted component fixtures, not an unrestricted source-to-APK CLI:

```text
D:/Android/platform-tools/adb.exe -s SERIAL push src/android_activity_callback.bf /data/local/tmp/cock-callback.bf
D:/Android/platform-tools/adb.exe -s SERIAL shell "/data/local/tmp/cock-tritium -r -b -z -B -O3 -fno-negtape -mem 2097152 /data/local/tmp/cock-callback.bf > /data/local/tmp/cock-callback.raw; echo EXIT:$?"
D:/Android/platform-tools/adb.exe -s SERIAL pull /data/local/tmp/cock-callback.raw D:/Android/cock-runs/20261026-device/callback.raw
```

Native guest input is eight little-endian original-dot-offset bytes followed by complete admitted normalized arithmetic source. Library input is u16 guest size, exactly 220 callback bytes, exact guest bytes and A5. The wrapper consumes u16 guest size, callback and guest. `tests/wide_request.bf` consumes u16 source count, u32 fuel, u16 capacity, u16 input count, normalized tool source and exact tool input. Runs use fuel `ffffffff`, capacity 128 and separately closed physical input/output files.

External `aapt2 link` compiled the inert manifest with `platforms/android-36/android.jar`. The standard ZIP API stored the unchanged BF library; `zipalign -P 16 -f 4` ran before `apksigner sign`. Signature verification, `zipalign -c -P 16 -v 4`, extracted-native comparison, `aapt dump badging`, LLVM ELF/disassembly inspection and installed-APK comparison followed. This ordering follows [official zipalign guidance](https://developer.android.com/tools/zipalign). The fresh disposable RSA-2048 certificate has SHA-256 `2082b1aaf00599e20aae908806a52f0071c8d667eff61f6bef4aa275c3a901b9`.

An isolated `org.cock.stagea.negative` APK requested nonexistent `COCK_missing_entry` using NativeActivity metadata. It installed but failed with `UnsatisfiedLinkError: undefined symbol: COCK_missing_entry`; this expected failure was recorded and the negative package removed. The positive debug package remains installed and force-stopped.

## Limits and retained failures

Foreground/background/back transitions and force-stop/relaunch were exercised; no positive-process native crash or ANR was observed in the captured intervals. Back navigation did not recreate the activity, so those observations do not prove same-process recreation; the CPU fixture independently checks two callback invocations. No general UI, lifecycle concurrency or bounded Android logging latency is certified.

The first post-install launch encountered Android's transient package-update activity. The corrected batch backgrounds the app before replacement and waits for package update completion. An initial packaging draft used the wrong working directory and was rebuilt before verification/install. A debugger attach did not yield usable evidence and was cleaned up. An automation error read an invalid state address; that capture was rejected and replaced by a checked 96-byte result. None was counted as a pass.

Timings above are single component observations with a concurrent nested run, not a stable performance comparison or whole-build baseline. Peak memory, power, installed storage, API 35 execution, 16-KiB device execution and production signing are NOT MEASURED / NOT RUN. No project optimization was performed.

The supplied specification originally matched the repository byte-for-byte at SHA-256 `5524bd878b66d5aea43b477ed696b8a802e9168b6b388abb5b47a5c4beb3d7fd`. The repository copy now adds current-status navigation only. Its requirements remain distinct from actual implementation evidence; no unchecked stage is declared complete.
