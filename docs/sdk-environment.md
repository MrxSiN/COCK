# Development environment and SDK installation evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


This document records observations in the current disposable development container.

## Available

- Linux x86_64 Debian 13 container and Java 21 runtime.
- LLVM Clang AArch64 assembler and LLVM disassembler usable for static instruction checks.
- Diagnostic Brainfuck executor installed at `/usr/local/bin/cock-bf-diagnostic` only in the current container outside this repository. It was compiled from temporary outside-repository C source solely for diagnostics. It is **not** an independent externally supplied certified root bootstrap and is **not** a compliant production dependency.

## Unavailable and attempted

- Official Android SDK command-line tools, Android Platform Tools, SDK platforms, NDK and Android Emulator: not installed. Official download is blocked because DNS/network egress is unavailable from this container (`curl: (6) Could not resolve host`). A package-manager attempt was also unsuccessful.
- Android emulator execution: no `/dev/kvm`; a future software-accelerated emulator attempt would still need installed emulator binaries and system image. No emulator was created or booted here.
- Android device installation and log observation: no attached Android device and no `adb`.

## Installation target when a networked Android capable host is provided

Use Google's published Linux SDK command-line tools and checksum from the official Android Studio download page. Extract into the normal SDK directory layout under `cmdline-tools/latest`, then use `sdkmanager` to install the selected `platform-tools`, Android platform, `build-tools`, NDK, emulator and an actual supported system image. Check the applicable Android license terms; only the account or host owner should accept them. Create an AVD with `avdmanager`, validate emulator acceleration or an explicitly working software mode, boot and verify it with `adb devices` and `getprop`. Choose a system image that actually supports the selected `arm64-v8a` target, and separately verify native library loading, SDK/API and page size.

No absent tool, device log, APK launch, or Android build is recorded as a success.

## Verified official download and installation commands for a suitable separate host

The following commands are **operator instructions**, not executable repository source, and were **not executed successfully here** due network isolation. Obtain and review the official Android SDK license before accepting it. Google publishes the Linux command-line archive `commandlinetools-linux-15859902_latest.zip` with SHA-256 `4e4c464f145a7512b57d088ac6c278c03c9eea610886b35a5e0804e74eedf583` as checked on 2026-10-24. The official Android page is https://developer.android.com/studio.

```text
export ANDROID_HOME="$HOME/Android/Sdk"
mkdir -p "$ANDROID_HOME/cmdline-tools/latest"
curl -fL https://dl.google.com/android/repository/commandlinetools-linux-15859902_latest.zip -o /tmp/android-cli.zip
printf '%s  %s\n' '4e4c464f145a7512b57d088ac6c278c03c9eea610886b35a5e0804e74eedf583' /tmp/android-cli.zip | sha256sum -c -
mkdir -p /tmp/android-cli-unpacked
unzip -q /tmp/android-cli.zip -d /tmp/android-cli-unpacked
cp -R /tmp/android-cli-unpacked/cmdline-tools/. "$ANDROID_HOME/cmdline-tools/latest/"
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" --version
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" --licenses
"$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_HOME" "platform-tools" "platforms;android-35" "build-tools;35.0.0" "ndk;28.2.13676358" "emulator"
"$ANDROID_HOME/emulator/emulator" -accel-check
"$ANDROID_HOME/platform-tools/adb" devices
```

Review `sdkmanager --list` to select an actual available API 35 image and actual device ABI; install the matching image and create an AVD only after checking CPU architecture. A Linux ARM64 hardware host with `arm64-v8a` image and appropriate virtualization, or an attached physical `arm64-v8a` Android device, is preferable for the Stage A proof. On the current x86-64 container, there is no `/dev/kvm`, and Google's documented VM acceleration matrix disallows VM acceleration of an ARM64 image on Intel or AMD hosts. Software emulation is not an assumed working substitute. Independently verify `adb shell getprop ro.product.cpu.abilist`, `getprop ro.build.version.sdk`, and `getconf PAGE_SIZE` after any actual boot or device connection.

There is no independently downloaded third-party Brainfuck host evaluator here. The locally built `cock-bf-diagnostic` is sufficient for component diagnostics only and must not be cited as the accepted root BF host. A compliant host needs an independently supplied evaluator/configuration meeting Part 3.8 and the separately implemented BF-authored source admission/closure contract.
