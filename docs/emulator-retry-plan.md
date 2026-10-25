# Emulator retry and remaining-gate test plan

The user explicitly requested emulator testing and continued A01–A14 diagnosis. This batch uses existing complete BF components and inert manifest metadata; it does not invent the absent positive Android compiler/runtime. No BF implementation is edited or optimized while mandatory gates fail.

## Changed emulator experiment

Retry only the task-owned `COCK_API35`, serial `emulator-5554`, with retained userdata/compiled caches, software CPU emulation, one guest core instead of two, 4096 MiB RAM instead of 2048, and 540 by 960 instead of 1080 by 1920. Keep API 35 Google APIs image, SwiftShader, normal watchdog/security checks, no snapshot and no boot animation. Camera/audio are disabled as unused peripherals. The emulator reports the requested display and ignores the obsolete dpi flag; do not claim density changed. Earlier emulator entries in the process list were confirmed zombies, not competing active emulators.

Observe current boot, ADB shell, package/activity services, launcher/foreground, exact ABI/native-bridge/page-size facts and screenshot. Boot-completed alone is insufficient. Stop or diagnose the new attempt at a recorded bounded wall deadline; do not hide service timeouts, disable Android verification/SELinux/watchdog, accept a black frame or fabricate positive readiness.

## Debug-only negative APK fixtures

Two existing A10 negative cases are made concrete using external debug packaging. Both use the existing native-only manifest, package `org.cock.stagea.debug`, and a fresh disposable debug certificate outside the checkout. No real release key, app-specific foreign code or DEX is used.

1. `missing-native-debug.apk`: manifest/library declaration exists but `libcockstagea.so` is absent. Expected target outcome is library-load failure, not an app success.
2. `linux-elf-debug.apk`: the actual previously BF-produced and independently matched `tiny_app_a` Linux ET_EXEC bytes are stored unchanged as `lib/arm64-v8a/libcockstagea.so`. This is intentionally invalid Android native-library test data, never a claimed Android producer. Expected target outcome is native library rejection; a foreign-ABI bridge limitation is reported separately rather than misidentified as a tested ET_DYN rule.

Build with external aapt2, zip, zipalign and apksigner under the allowed DEBUG-ONLY exception. Verify final signature/ZIP alignment, native-only manifest and executable inventory, and exact extracted ELF identity before install. A successfully signed negative candidate does not satisfy A08/A09 positive implementation. Test only on the explicitly selected task-owned emulator when package/activity services are ready. No stable target means install/launch NOT RUN.

## Nested compiler retry

The root BF evaluator documents `-O3` as extra optimization in its external C execution backend. This changes the physical bootstrap configuration; it does not modify/optimize the repository BF kernel, compiler or guest fuel semantics. Before relying on it, replay all 73 previously adapted independent stored expectations including six frozen native payloads, binary/EOF, invalid-source, loops/fuel and pointer checks. Retain the earlier documented depth-256 wider-kernel expectation.

Only on a passing control batch, run the unchanged exact compact nested request with the same interpreter source/inner source, full four-byte fuel and 16,384 outer logical cells using the new external `-r -c -O3` backend and an explicitly recorded 900-second wall limit. This differs from the prior O1 600-second attempt. Require the entire 18-byte result and both interpreter statuses, process/physical completion and BF comparator equality. A prefix, timeout or direct-root compiler run is failure. This short `+.` raw compiler control remains outside the printable Android app profile and cannot alone accept A01–A14.

## Evidence and boundaries

An additional independently inventoried native-entry probe was drafted under `docs/android-native-entry-probe-plan.md` before any of its own source/byte/generation tests. Its complete BF source and literal structure expectations were frozen separately. It adds a third test APK intended to establish native loading only, without pretending that a fixed no-op entry is the missing real compiler/runtime.

Record all actual results in `docs/emulator-retry-evidence.md` and JSON, plus updated `docs/status.md`/README pointers. Test output, logs, prepared APKs, screenshots and secret debug key/password files remain outside the checkout under `/workspace/test-results/emulator-retry-20261025`; never print or commit credential material. Emulator logs can include ADB public-key/token fields, so use filtered diagnostic excerpts rather than dumping them into reports.

The physical emulator may be fixed independently of the absent BF frontend/native ABI/Android ET_DYN/artifact/build/test implementations. Those real code gaps cannot be cleared merely by rerunning tests. Only real passing source, nested, APK, target/lifecycle and authority evidence can close the full-stage gate. No default integration or release is performed.
