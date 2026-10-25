# Stage A debug build, target and usage draft

**Prospective workflow, NOT EXECUTED.** No BF-produced Android ELF or APK exists, the BF build driver is absent, the full Stage A source draft is incomplete, mandatory nesting has timed out and Android services were unstable. These instructions specify what A09–A14 must eventually demonstrate; they are not a working CLI claim.

## Readable-source build boundary

The user selects `examples/tiny_app_a.bf` or `examples/tiny_app_b.bf` and a fresh output root. The BF-owned toolchain reads an independently sealed exact source invocation, performs full annotated and subset admission with original offsets, generates native/ELF bytes and emits the one-file artifact session described in [the source contract](stage-a-source-draft.md). Normal compiler execution must go through the BF-in-BF interpreter. The BF build driver must actually implement stage composition: original BF has no include, function-call, filesystem or subprocess command. A documented pipeline of external commands cannot stand in for missing BF orchestration.

If modular BF source is used, define shared tape handoffs and a BF-authored source-composition mechanism in the implementation inventory before writing it. Do not silently concatenate independent zero-initialized modules, invent an include opcode, insert a conventional linker, or make an external build script the semantic planner. A single integrated BF implementation is acceptable if it reduces this complexity; update the inventory and source identities accordingly.

Validate the completed producer/session, exact staged ELF and independent process/write closure before debug packaging. The trusted mechanical host may persist the BF-selected `lib/arm64-v8a/libcockstagea.so`; the file's existence is not acceptance. Save source/compiler/interpreter/input/output hashes, source map, process status and selected budgets. An independent native inspector can veto output but cannot supply it.

The two apps keep the same package metadata and compiler identity. App A computes ASCII space (`20`) from 32 additions; app B computes exclamation (`21`) from 33 additions. Their app-specific native text must differ for the expected arithmetic reason. Different package labels, a host-created message or substituted prebuilt native code cannot provide the observation.

## Packaging ownership

`config/stage-a/AndroidManifest.xml` is proposed inert metadata with API 35 minimum/target, framework NativeActivity, `hasCode=false`, `debuggable=true`, no permissions, explicit launcher export and library metadata `cockstagea`. It contains no app-specific executable algorithm. External aapt2 may compile/link that metadata under the master's Stage A debug exception. No custom Java/Kotlin/activity/DEX, conventional native helper, opaque executable asset or runtime template may be added.

Use stored/uncompressed `.so` with `extractNativeLibs=false`. External `zipalign -P 16` provides ZIP entry alignment only; BF must generate valid ELF segment alignment. Package every app-specific executable byte from the independently checked BF producer unchanged. Inventory every DEX, library and executable asset, including any unexpected output introduced by packaging. Absence of an expected executable or presence of an undeclared one fails.

All actual packaging files, keys and outputs stay in a fresh run directory outside the checkout. The following command forms assume `/workspace/test-results/stage-a/run-a` has been populated with an independently accepted producer result at `lib/arm64-v8a/libcockstagea.so`. They are future external debug-tool invocations, not commands run during drafting. The current tool versions are in `cloud-android-tools.json`.

From `/workspace/test-results/stage-a/run-a`:

```text
/workspace/android-sdk/build-tools/35.0.0/aapt2 link -o metadata.apk --manifest /workspace/COCK/config/stage-a/AndroidManifest.xml -I /workspace/android-sdk/platforms/android-35/android.jar
zip -0 candidate-unsigned.apk lib/arm64-v8a/libcockstagea.so
```

Before the second command, mechanically copy the accepted `metadata.apk` to `candidate-unsigned.apk`; the command adds only the exact BF native library. Use a new file for each app, preserve all tool exits and inspect the complete entry list. Do not merge with an unrelated or previous APK. Then:

```text
/workspace/android-sdk/build-tools/35.0.0/zipalign -P 16 -f -v 4 candidate-unsigned.apk candidate-aligned.apk
```

Use only a fresh disposable debug key. Generate it interactively or through securely supplied environment-backed password options in the external keytool/apksigner; do not place passwords or key bytes in this repository, documentation, tool output or fixture data. Do not reuse a real release key. Preserve the certificate fingerprint as evidence and the key only for the local disposable debug workflow. A representative signing invocation uses an already-created disposable store:

```text
/workspace/android-sdk/build-tools/35.0.0/apksigner sign --ks /workspace/test-results/stage-a/disposable-debug.jks --ks-key-alias cock-stage-a-debug --ks-pass env:COCK_STAGE_A_DEBUG_PASSWORD --key-pass env:COCK_STAGE_A_DEBUG_PASSWORD --out candidate-debug.apk candidate-aligned.apk
/workspace/android-sdk/build-tools/35.0.0/apksigner verify --verbose --print-certs candidate-debug.apk
/workspace/android-sdk/build-tools/35.0.0/zipalign -c -P 16 -v 4 candidate-debug.apk
```

No missing key is a reason to borrow production credentials. Verify signer, minimum/target policy, alignment and package integrity independently. Do not modify a signed APK afterward. If `zipalign`/signature/entry inspection fails, retain failure evidence and rebuild a new candidate from the exact accepted inputs.

Extract `lib/arm64-v8a/libcockstagea.so` from the final signed APK into a new file. Compare its exact bytes and independent SHA-256 with the prepackage BF-generated ELF. Signature/container changes may affect APK bytes; native executable bytes must remain identical. Independently decode the final APK manifest and confirm activity/export/library/hasCode/SDK fields, not merely the input XML.

## Target readiness and launch

Select a specific ADB serial out of band; never operate on an arbitrary attached device. Verify API/ABI, actual page size and bridge applicability, completed stable boot, shell, package-manager, activity-manager, foreground and lifecycle readiness. Record exact device/build identity and connection state. A boot property or black PNG is not readiness. A fresh stable ARM64 target or a KVM-capable compatible host remains an external prerequisite; installation of SDK packages did not supply one.

The following are representative external invocations after selecting a serial; `SERIAL` is a literal placeholder to replace with the chosen device identity, not a default selector:

```text
/workspace/android-sdk/platform-tools/adb -s SERIAL install -r candidate-debug.apk
/workspace/android-sdk/platform-tools/adb -s SERIAL shell am force-stop org.cock.stagea.debug
/workspace/android-sdk/platform-tools/adb -s SERIAL shell am start -W -n org.cock.stagea.debug/android.app.NativeActivity
```

Keep package/certificate identity stable between app A and B, replacing only the selected build with recorded evidence. Do not uninstall or overwrite unrelated user apps. Capture logcat with time/process/tag context across the launch; record each emitted invocation tag and its exact byte, including a space-only message that default text trimming may hide. A capture losing that space is NOT VERIFIED. Bind the observation to the installed APK's actual code path/hash, PID/process start, launch interval and result; clear or isolate stale records instead of accepting an older matching tag.

Check loader/import failures, native crashes/tombstones, ANR/callback latency, return/status consistency, activity foreground/lifecycle and force-stop/relaunch behavior separately. A correct byte from a crashing/unresponsive callback is failure. Device logs are a development observation, not guaranteed binary stdout or rendering/UI proof. API 35 4-KiB success cannot certify API ranges, other ABIs, a 16-KiB device or Play distribution.

Run both apps and a fresh admitted held-out input selected after the actual all-source draft checkpoint. Do not use either historical held-out file as the fresh selection. Keep unsupported/malformed cases from reaching packaging, and independently verify a wrong manifest/native entry fails for the expected reason on an isolated negative candidate.

## Measurements and rollback

Only after correctness and required target gates pass, preserve the exact unoptimized source/native/APK baseline. Measure cold and warm runs separately with identical inputs, target, budgets, seed/backend and environment. State whether process/tool startup, BF source projection, preflight, BF-in-BF compilation, ELF writing, debug packaging/signing, install and launch are included. Attribute those components separately where measurable.

Record wall time, CPU time, peak RSS or explicitly unavailable memory data, emitted app-derived text/runtime/metadata/padding bytes, raw ELF bytes, APK total/stored/compressed entry sizes, and actual installed code/storage bytes when accessible. Use repeated comparable runs and report the individual observations and a declared aggregate; never infer stable throughput from one parallel diagnostic batch. Startup/ANR timing and power are independent dimensions. Unknown power/installed bytes remain NOT MEASURED.

Optional optimization starts only after A10–A12 and the unoptimized baseline pass. Preserve source, outputs, test data and exact prior checks. Select measured low-risk changes with semantic guards and rerun all relevant failure/source/nesting/device/identity tests, not only the output examples. Revert a regression to the verified baseline. An unoptimized accepted compiler may remain the default; optimization is not required to fabricate progress.

The final A14 usage guide must name one real BF-owned build/smoke entry point and demonstrate a readable new source producing an independently checked installable debug APK. Until that driver and all checks exist, this document is prospective usage, not a working command. Current candidate commits are review checkpoints; they do not replace main with a usable Android compiler.
