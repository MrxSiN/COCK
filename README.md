# COCK — Completely Overengineered Compiler Kit

COCK is a Brainfuck-authored Android compiler project. All repository-authored executable source is annotated eight-command `.bf`. **Stage A is incomplete; Stage B and later stages have not been accepted.**

On 2026-10-26, four BF-generated native candidates installed and ran on a physical Pixel 8 Pro, Android API 37 / `arm64-v8a`, producing space, `!`, space from mixed arithmetic, and `H` from a fresh held-out source. A real-device failure exposed a single-attempt exclusive-store bug in the NativeActivity callback. Its bounded sixteen-attempt repair passes six native callback regressions, including forced retry exhaustion. See [current evidence](docs/windows-device-evidence.md) and [machine-readable results](docs/windows-device-evidence.json).

The guest, callback and ELF producers also run through BF-in-BF and reproduce checked direct outputs. This is component self-hosting. The required second identical interpreter executing the complete compiler, integrated exact-source admission, authoritative artifact framing and a usable BF-owned build entry still block Stage A acceptance.

## Start here

- [Current status and next work](docs/status.md)
- [Stage A acceptance matrix](docs/acceptance.md) and [open issues](docs/stage-a-issues.md)
- [Device setup, reproduction commands and limitations](docs/windows-device-evidence.md)
- [Development roadmap](docs/development-roadmap.md) and [engineering principles](docs/engineering-principles.md)
- [All documentation, including historical evidence and prospective designs](docs/README.md)
- [Master engineering specification](docs/COCK_Master_Engineering_Prompt_Updated.md)

## Current implementation boundary

`src/android_guest_entry.bf` generates source-ordered wrapping arithmetic and a checked native context/result entry. `src/android_activity_callback.bf` creates bounded invocation state and calls that guest. `src/android_library_elf.bf` writes the Android shared object, exports and `liblog` relocation. `src/source_pc_dynamic_tape.bf` interprets real BF compiler modules. Source gates, request serializers and independent BF comparisons remain separately tested components.

The application subset is one zero-initialized byte, `+` and `-`, and exactly one final printable output. Input, pointer travel, loops, binary app stdout, UI and general Android services are unsupported by this native backend. Complete source admission must precede its use; calling the backend directly on arbitrary `.bf` input is unsafe and unsupported.

External Android SDK tools supply debug-only metadata, ZIP alignment and disposable signatures. APKs contain the BF-produced library unchanged and no app-specific DEX. These are **DEBUG-ONLY**, not BF-native production signing or a release. Keys, temporary tools and APKs stay outside the repository.

Historical documents retain their original results and environment paths. Read current status before using their commands. No later-stage promotion follows from this partial Stage A result.
