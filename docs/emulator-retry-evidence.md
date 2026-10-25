# Emulator and remaining-gate execution — 2026-10-25

**A01–A14 remains BLOCKED / NOT COMPLETE.** We ran the software emulator, attempted actual APK installations, implemented and packaged a BF-generated native-entry probe, and reran the nested compiler test with a different external execution configuration. Failed startup, installation and nesting results are not passes.

## Actual emulator run

Started the task-owned API 35 Google APIs AVD `COCK_API35`, serial `emulator-5554`, at approximately 19:38 Asia/Kuala_Lumpur (11:38 UTC). Changed the earlier two-core/2-GiB/full-resolution experiment to **one guest CPU, 4096 MiB requested RAM, 540×960 display**, retained userdata/cache, SwiftShader, no snapshot/window/audio/boot animation, and no cameras. The obsolete dpi option was ignored; the emulator reported density 420. Earlier emulator process entries were zombies, not competing active VMs.

The guest became ADB-connected, but **never reported completed boot**. Package services were transiently visible, and one query returned `/system/framework/framework-res.apk`; subsequent calls again could not find package/activity services. Settings launch failed with exit 20, `Can't find service: activity`. A valid 540×960 screenshot was captured and visually inspected: entirely black. This is screenshot transport success, not usable Android/UI evidence.

The image reported `x86_64,arm64-v8a` and `libndk_translation.so`. Those are advertised capabilities, not observed ARM64 library execution. The acceleration check returned exit 3: `KVM requires a CPU that supports vmx or svm`. `/dev/kvm` is absent. No host OOM kills occurred.

After **38 minutes 34 seconds** of active emulator time, the console acknowledged `emu kill`. The SDK process subsequently exited **139 (segmentation fault during shutdown)**. The process is gone and ADB lists no device. Shutdown failure is recorded separately from the Android package failures; it is not attributed to the BF library, which never launched. The stopped-state observation was recorded at 20:19 Asia/Kuala_Lumpur (12:19 UTC).

No Android verification, SELinux, watchdog or test assertion was disabled. We inspected the public Android 15 `Watchdog.java` contract to investigate supported timing controls, but the settings service was unavailable and a watchdog dump did not expose an effective value. **No watchdog override was written.** No unsupported ARM image or alternate ABI was silently substituted.

## New BF-native loader probe

`tests/android_native_entry_probe.bf` is a complete new annotated BF test generator. It emits a **1,232-byte AArch64 ET_DYN shared library** with a defined global `ANativeActivity_onCreate` at `0x300`. Its native body is exactly `C0 03 5F D6` (`ret`); the OS callback ignores its three arguments and returns with no state, imports, I/O, worker or guest computation.

This fixed test is **not a compiler**, does not receive app source, does not implement `cock_guest_run_v1`/context/result records or liblog, and cannot stand in for source-derived application behavior or the mandatory real-compiler nesting proof. Its purpose is to separate native loader/ABI feasibility from the missing full runtime. It is not promoted into the default compiler.

All three first-pass inventory files were complete before probe tests. The read-only pretest archive is `/workspace/test-results/emulator-retry-20261025/native-probe/pretest.tar`, SHA-256 `19675659797028d98ee40bc7e193b527b45a4402861248e479a7add768a81f62`. The BF source SHA-256 is `f0e6ebebd58297ab659bbb0f0aeced23852af182d6b39d78bc40c0d60a4acc06`; BF normalization produced 4,433 commands. No BF source repair/optimization occurred after freezing.

Completed probe checks:

- BF annotated-source admission accepted the full source.
- Direct external BF execution produced exactly 1,232 bytes.
- The same generator, as an actual COCK-kernel guest, produced the identical whole library plus one interpreter success byte.
- Three BF binary comparisons accepted the literal 64-byte header, literal return instruction and whole direct/guest equivalence; independent `cmp` agreed.
- Independent `readelf --wide` and NDK `llvm-objdump` confirmed ET_DYN/AArch64, three program headers, RX load alignment `0x4000`, a read-only dynamic table, non-executable GNU_STACK, SysV hash, SONAME `libcockstagea.so`, seven correct sections and the exact exported four-byte return function.

The actual library SHA-256 is `5d34580fb4f732aadcc2067b516eb97b750cbecf83b495a79da2c1d70814d118`. **Android loading and callback execution remain NOT VERIFIED because installation failed.** Structural correctness is not device acceptance or a general 16-KiB compatibility claim.

## Three real debug APKs and installation outcomes

External aapt2/zip/zipalign/apksigner generated only inert metadata/container/signature bytes under the documented DEBUG-ONLY exception. A fresh disposable PKCS12 key/password remained protected outside the checkout and was neither printed nor committed. No release key, app-specific DEX, Java/Kotlin/C helper or prebuilt native runtime was added.

All three final APKs passed independent signature verification (v3), 16-KiB native ZIP-alignment checks, decoded manifest and executable-inventory inspection. Manifest: API 35 min/target, `hasCode=false`, exported framework NativeActivity, library `cockstagea`. Extracted native entries matched the actual BF outputs byte-for-byte.

| Candidate | Purpose | Actual install result |
| --- | --- | --- |
| Missing library | Negative native-library lookup case | Exit 20: package service unavailable |
| Linux ELF as `.so` | Negative ET_EXEC/Android-loader case; BF bytes unchanged | Exit 255: `PackageManagerInternal.freeStorage` called on null during installation |
| BF native-entry probe | Intended positive native-loader/return test | Initial exit 255: `StorageManager.getVolumes` called on null; final retry exit 20: package service unavailable |

The first probe attempt used the standard `cmd -w package install` to wait for the service; reaching the installer still did not mean Android initialization was complete. A later retry followed an actual successful package-path query, not an unchanged blind loop. Pushing APK bytes succeeded, but installation did not. **Neither negative library-load case passed, and no probe callback/app was launched.** These are environment/startup failures before the intended loader tests.

| APK | SHA-256 |
| --- | --- |
| Missing-library negative | `199967015dcf962ef5f3c00f04a1fe116de0c0b00b59b3cfacb19a719db9ba86` |
| Linux-ELF negative | `2421a6e310f6cee1e0e9fc82bd20df58519973390c8588f8054c4a0d24f29fb9` |
| BF entry probe | `578a4b5360f2c5f5b05b89827e6d7580b06779ed7d71f1b9ac8429ae23242917` |

The signer initially exhausted a one-line password file when both store/key password options reused that file. Using PKCS12's shared password without the redundant key-password option corrected the invocation; all independent final checks then passed. A packaging command initially selected a not-yet-created working directory; it was rerun after creating the directory. Neither invocation repair changed BF source or weakened acceptance.

## Nested compiler retry

Tritium documents `-O3` as extra optimization in its **external C execution backend**. We changed that physical bootstrap configuration, not the repository BF kernel/compiler or original guest fuel semantics. The new configuration first passed **73/73 stored adapted regressions**, including all six frozen real compiler payloads and the previously documented wider depth-256 expectation.

The unchanged compact nested input was then executed with `-r -c -b -z -B -O3 -fno-negtape -mem 2097152`, unbuffered physical stdout, unchanged exact outer/inner kernel bytes and resource fields, and a new **900-second wall limit**. Start/end: 19:42:06–19:57:06 Asia/Kuala_Lumpur (11:42:06–11:57:06 UTC).

Actual: **900.014 seconds, exit 124, three bytes `00 00 80`**, versus the complete expected 18 bytes including both terminal statuses. Independent `cmp` rejected it and the BF comparator returned `01`. This is a sixth completed timed-out attempt for this dynamic-kernel candidate, not successful nesting, not a guest-fuel result and not a measured speed improvement. The short raw `+.` diagnostic remains outside the printable Android app policy.

## A01–A14 disposition

| Requirements | Current evidence / remaining gate |
| --- | --- |
| A01 | Real emulator attempt and BF ARM64 entry probe prepared; stable runtime/actual ARM64 loading still unverified |
| A02 | Existing full tool-interpreter component checks pass; nested real compiler and integrated app policy remain incomplete |
| A03, A06 | Exact-source/original-offset/frontend/closure authority implementation still missing; this no-input test does not replace it |
| A04, A05 | New bounded probe fully inventoried/drafted/tested structurally; whole-stage executable inventory still incomplete |
| A07, A08 | Real BF ET_DYN/OS-entry test now exists; source-derived app arithmetic, internal ABI/result/logging and full app ELF writer still missing |
| A09, A09a | External debug packaging/identity checks pass on three test candidates; no two source-derived working Android apps |
| A10 | New probe/component checks and root controls pass; mandatory nested output and Android install/launch do not |
| A11 | No distinct printable app behaviors observed on Android |
| A12 | Actual commands, identities, failures and limitations recorded here/JSON |
| A13 | No accepted baseline; no optional kernel optimization or Android performance claim |
| A14 | No usable BF-owned source-to-working-debug-app CLI yet |

A stable ADB-connected ARM64 API-35-or-newer target or a suitable KVM-enabled environment is needed for the remaining device tests. That missing target was requested while independent work completed; silence does not supply hardware or approval. Even with a target, the missing full compiler/runtime/authority implementations and failed nested proof must be resolved before accepting A01–A14. Tests cannot make absent code implemented.

## Retained evidence and reproduction

All raw files are under `/workspace/test-results/emulator-retry-20261025`; private debug signing files stay outside repository/evidence exports. Logs may contain platform key/token fields, so only filtered diagnostic excerpts are used. The screenshot hash is `1338b2238a03c16205c90c5045a6cee9d7b9e856ac145974206d26baa9e3f9a2`.

The probe plan/field expectations are in `docs/android-native-entry-probe-plan.md` and `fixtures/android_native_entry_probe/vectors.json`. Representative completed generation/check commands from `/workspace/COCK`:

```text
/workspace/tools/bin/tritium -r -b -z -B -O1 -fno-negtape tests/android_native_entry_probe.bf > /workspace/test-results/emulator-retry-20261025/native-probe/direct.so
readelf --wide -h -l -S -d -s /workspace/test-results/emulator-retry-20261025/native-probe/direct.so
/workspace/android-sdk/ndk/28.2.13676358/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-objdump -d /workspace/test-results/emulator-retry-20261025/native-probe/direct.so
```

Capture binary generator stdout to a file, not a terminal. Check physical exit/write/close separately. The actual signed loader-probe APK is `/workspace/test-results/emulator-retry-20261025/apks/probe/debug.apk`; it is a no-output target test, **not a completed COCK app**. No default promotion, release signing or production publication occurred.
