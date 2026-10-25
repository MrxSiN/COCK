# Cloud Android test environment — 2026-10-25

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


2026-10-26 update: independently installed QEMU AArch64 10.0.13 now runs the [real BF-generated guest and callback CPU tests](android-native-implementation-evidence.md). Actual source-generated shared libraries and two verified debug APK candidates exist. This supersedes the older “no ELF/APK exists” observations below. No connected Android target or KVM is available, so device/runtime readiness remains unresolved. The saved installation/startup draft now includes QEMU; publication remains a separate environment-settings action.

**Tools installed; Android runtime is not ready on this host.** SDK/evaluator setup and repeat installation succeeded. Android software-emulation tests exposed boot timeouts and framework restarts; UI readiness is not established. No COCK application was installed or launched.

This report supersedes archived machine observations in `sdk-environment.md` and `docker-android-feasibility.md`. Older evidence describes the uploaded workspace's previous host.

## Installed and verified

All SDK licenses were explicitly authorized by the owner in this conversation. The complete installer succeeded and passed its repeat run. Exact revisions and successful version-command outcomes are in `cloud-android-tools.json`.

| Component | Installed revision/location |
| --- | --- |
| Java | OpenJDK 21 |
| SDK command-line tools | 19.0, `/workspace/android-sdk/cmdline-tools/19.0` |
| Platform tools | 37.0.1; ADB 1.0.41 |
| Android platform | API 35 |
| Build tools | 35.0.0; aapt2, apksigner and D8 version checks passed |
| NDK | 28.2.13676358 / r28c; Clang 19.0.1 version check passed |
| Emulator | 37.2.12 |
| Google APIs system image | API 35 x86_64 revision 9; AVD `COCK_API35`, port 5554 |
| AOSP Automated Test Device image | API 35 x86_64 revision 1; AVD `COCK_ATD35`, port 5556 |
| Independent BF evaluator | Pinned upstream Tritium, `/workspace/tools/bin/tritium` |

SDK tools, evaluator sources/binaries, inspection harnesses and AVDs remain outside the checkout. No conventional executable source or SDK binaries were added to the project. The SDK CLI archive was independently checksum-verified; its provenance and the evaluator hash remain in `cloud-environment-evidence.json`. Use SDK Manager 19.0; the separately retained 22.0 legacy `sdkmanager` does not perform the old package-list operation.

## Android runtime outcomes

The x86_64 host has no `/dev/kvm`; the emulator acceleration probe reports no VMX/SVM support. Both AVDs were attempted using software CPU emulation and SwiftShader. Each used two guest cores and 2048 MiB RAM; ATD used a 540 by 960 display. Container memory events recorded zero OOM kills.

| Check | Actual outcome |
| --- | --- |
| Google APIs initial boot wait | Failed after 914.78 seconds |
| Google APIs extended wait | Failed after another 903.28 seconds; framework restart also observed |
| ATD initial boot wait | Failed after 900.79 seconds |
| ATD subsequent run | Boot property briefly reached 1; six shell/property probes passed |
| ATD package-manager lookup | Failed: broken pipe calling package service |
| ATD Settings launch | Failed: activity service unavailable |
| ATD foreground activity | Failed: activity service unavailable |
| ATD PNG transport | Valid PNG bytes, but independent visual inspection found a black frame |
| COCK APK/native integration | NOT RUN: no ELF library or APK exists in this project |

The complete ATD driver exited **1**. Its raw result is `cloud-atd-smoke.json`; boot failures and framework summary are in `cloud-*-boot.json` and `cloud-android-runtime-summary.json`. A completed boot property alone did not establish stable services. The black frame is retained as `cloud-atd-blank-frame.png`, not as proof of a working Settings screen.

Google APIs shell probes reported API 35, 4096-byte pages, `x86_64,arm64-v8a`, and `libndk_translation.so`. This advertises native bridging; it does not prove COCK native loading. ATD reported API 35, 4096-byte pages, x86_64 only and no native bridge. These are different target capabilities.

## Diagnosis and corrections attempted

- ADB required its standard `/home/agent/.android` directory; narrow filesystem initialization and local emulator-console authentication setup restored ADB access. Authentication contents were never printed or committed.
- A detached emulator exited with SIGKILL without a recorded container OOM. Managed foreground execution kept the emulator observable and running. Confirmed stale locks were removed only after the earlier process had terminated.
- Framework traces and logs showed ongoing Settings/database initialization and expensive ART bytecode verification. Chrome alone took approximately 187 seconds of dex verification. The ATD image reduced bundled applications but did not yield a stable runtime.
- ATD watchdog diagnostics were followed by zygote/framework restarts at approximately 851 and 1158 guest seconds. A supported global `watchdog_timeout_millis=600000` setting was stored and read back, but its runtime effect was not confirmed and stable UI checks still failed. After stopping both emulators, the task-created ATD was deleted and recreated from the official image to remove the diagnostic override and failed userdata. The Google APIs AVD and its compiled cache are retained. No test assertions, package checksums, TLS verification or application source were weakened.

Both test emulators were stopped gracefully. The remaining practical prerequisite is a KVM-capable host or an actual ADB-accessible Android device. Rerun completed boot, shell, package-manager, activity-launch, foreground and screenshot checks there. The evidence does not establish a specific Android image defect or guarantee that acceleration alone fixes every failure. COCK additionally needs BF-produced ELF/APK integration before any application acceptance test can run.

## Existing BF diagnostics

The prior independently replayed batch passed **73/73** stored `source_pc_16bit_eight_cell_loops` fixture pairs, including six real original/compact mini-compiler outputs, and **50/50** BF files passed the static annotation/command/bracket audit. Those results are retained in `cloud-bf-fixtures.json`; SDK installation did not change project executable source or fixtures, and this continuation did not rerun that batch.

The tested host invocation is `tritium -r -b -z -B -O1 -fno-negtape src/source_pc_16bit_eight_cell_loops.bf` from `/workspace/COCK`, with each stored input on stdin and exact stdout compared to its paired expected bytes. Independent conventional checkers only invoke tools and compare outputs; they do not implement production transformations.

Tritium is not a fully qualified COCK bootstrap. Its malformed-bracket and left-boundary probes did not enforce the locked COCK contract, and its interactive output probe buffered until completion. Its tape uses a large finite lazy-backed reservation. Separate BF-owned admission, closure, pointer/fuel controls and framing remain necessary. Full same-interpreter nested self-hosting is unverified.

## Reusable configuration

Saved complete `install_script`, `start_skill`, and suggested `ANDROID_HOME`, `ANDROID_USER_HOME`, `ANDROID_AVD_HOME` variables in the environment draft. Installation reproduces the official CLI, pinned evaluator, licensed SDK packages, both system images and both AVD definitions. It preserves existing AVDs. Runtime startup and readiness commands are saved separately; live processes must restart after publication. No worktree is needed: use the existing checkout in each isolated task.

Review and save the draft in environment settings before publishing. Draft persistence does not publish or validate a new task. This host supports the installed toolchain and existing BF component workflow, but Android UI/runtime readiness remains unresolved.
