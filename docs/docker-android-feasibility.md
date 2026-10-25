# HQarroum docker Android feasibility for COCK Stage A

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date checked: 2026-10-24. Status: BLOCKED / NOT RUN. Nothing from the Docker project has been vendored or installed into the COCK repository.

## Public repository interface

Repository URL: https://github.com/HQarroum/docker-android

Public README documents an Android emulator Docker container exposed over port 5555, started by `docker compose up android-emulator`, or built with `docker build -t android-emulator .` then run with `/dev/kvm`. Its documented API 33 operating envelope recommends at least 4 GB memory and 8 GB disk. The inspected upstream Dockerfile defaults to Android API 33, system image architecture `x86_64`, and a configurable `ARCHITECTURE` argument. The default **x86_64** virtual Android target is not proof that an `arm64-v8a` only COCK native library can load. A real `arm64-v8a` compatible target or independently verified ABI translation must be obtained for the intended Stage A guest before device acceptance; do not infer it from ADB connectivity.

## Observed in this execution container

- `uname -m` reported `x86_64`.
- `docker` command: missing.
- `podman` command: missing.
- `/dev/kvm` device: missing.
- `curl -IL --max-time 8 https://github.com/HQarroum/docker-android`: failed with `Could not resolve host: github.com`.
- Android `adb` command: missing.
- No BF-generated Android ELF, OS callback, signed debug APK or installable application was available to run even if an emulator existed.

## Decision

Docker emulator installation or boot cannot be demonstrated in this restricted host. This is a **host capability blocker**, not a negative result about the upstream project. Continue host-side pure Brainfuck implementation and leave Android installation and launch NOT RUN. For a later suitable networked/virtualization-capable host, first check emulator ABI and page size against COCK's `arm64-v8a` target, then perform toolchain/debug-APK/device checks separately.

No application launch, native callback, device log, APK install or Android compatibility conclusion was established here.
