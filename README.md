# COCK — Completely Overengineered Compiler Kit

COCK is a Brainfuck-authored Android compiler project. All repository-authored executable source is annotated eight-command `.bf`. **Stage A is incomplete; Stage B and later stages have not been accepted.**

On 2026-10-26, the new `src/android_native_compiler.bf` generated admission-checked native callback, guest and ELF bytes in one BF program. Complete BF-in-BF outputs produced three debug APKs that installed and ran on the Pixel 8 Pro, Android API 37 / `arm64-v8a`, logging space, `!` and a fresh held-out `Q`. Installed APK identities, native instructions and six callback regressions pass. See [current evidence](docs/android-native-compiler-evidence.md) and [machine-readable results](docs/android-native-compiler-evidence.json).

The complete normalized-source native producer runs through BF-in-BF. Two identical reference interpreters also execute the real compact raw compiler with exact A/B outputs. Nesting the complete integrated Android compiler still times out after 600 seconds, including a 64-MiB-capacity attempt. Integrated original annotated-source admission/errors, artifact authority and a readable-source build entry also remain open.

## Start here

- [Current status and next work](docs/status.md)
- [Stage A acceptance matrix](docs/acceptance.md) and [open issues](docs/stage-a-issues.md)
- [Latest native compiler, device commands and limitations](docs/android-native-compiler-evidence.md)
- [Same-kernel nested compiler results](docs/same-kernel-evidence.md)
- [Earlier device setup and callback repair](docs/windows-device-evidence.md)
- [Development roadmap](docs/development-roadmap.md) and [engineering principles](docs/engineering-principles.md)
- [All documentation, including historical evidence and prospective designs](docs/README.md)
- [Master engineering specification](docs/COCK_Master_Engineering_Prompt_Updated.md)

## Current implementation boundary

`src/android_native_compiler.bf` atomically checks complete normalized printable arithmetic and directly generates the callback, guest and ELF. Its source chunks cross 255 commands; checked native-size overflow rejects before artifact output. The standalone `android_guest_entry.bf`, `android_activity_callback.bf` and `android_library_elf.bf` remain unchanged for comparison. `bf_in_bf_reference.bf` runs the integrated producer in the recorded trusted-tool experiment; the earlier dynamic interpreter remains a separately tested profile.

The application subset is one zero-initialized byte, `+` and `-`, and exactly one final printable output. Input, pointer travel, loops, binary app stdout, UI and general Android services are unsupported. The integrated producer still expects independently admitted normalized source and its original dot offset. It does not accept arbitrary annotated `.bf` files or supply complete source-error diagnostics.

External Android SDK tools supply debug-only metadata, ZIP alignment and disposable signatures. APKs contain the BF-produced library unchanged and no app-specific DEX. These are **DEBUG-ONLY**, not BF-native production signing or a release. Keys, temporary tools and APKs stay outside the repository.

Historical documents retain their original results and environment paths. Read current status before using their commands. No later-stage promotion follows from this partial Stage A result.
