# Engineering status

Updated 2026-10-26, Asia/Kuala_Lumpur. **Stage A remains incomplete. Stage B–F are not accepted.** The [documentation index](README.md) distinguishes current guidance, historical evidence and prospective designs.

[Physical-device evidence](windows-device-evidence.md) records the Pixel 8 Pro run, identities, failures, commands and limits. Four native-only debug APKs produced expected source-derived bytes, including a fresh `H` application. Signatures, alignment, executable inventory and installed APK identity were checked. An isolated invalid-entry package failed with the expected missing-symbol error and was removed.

The callback previously rejected uncontended startup after one failed exclusive store. It now permits at most sixteen attempts. Six exact native state regressions pass, including forced retry exhaustion. The callback is 220 bytes; ELF symbol size, copy counts and padding agree. Guest entry remains at `0x1000`; existing guest instructions are preserved.

| Capability | Current evidence | Acceptance limit |
| --- | --- | --- |
| Physical target | Pixel 8 Pro, API 37, native ARM64, 4096-byte pages | API 35 runtime, other devices and 16-KiB execution not certified |
| Native guest / callback / ELF | Bionic loading, source-derived logs and native state checks | Complete frontend and publication authority absent |
| One-layer compiler self-hosting | Guest, repaired callback and ELF reproduce under BF-in-BF | Mandatory complete nested compiler chain unpassed |
| Source validation | BF component checks and independent repository annotation audit | Integrated original offsets, closure and atomic build handoff incomplete |
| Debug packaging | External SDK tools; exact native identity, no DEX | DEBUG-ONLY; not Stage D or release |
| Stage B | Isolated arithmetic components and designs | Full Android eight-command compiler/runtime incomplete |
| Stage C | Interpreter components and differential fixtures | Full profile/source-map/resource conformance incomplete |
| Stage D | CRC-32 and stored-ZIP components | BF-native APK/signing and custody gates incomplete |
| Stage E | Binary/text/frame components | Android event/state/UI platform incomplete |
| Stage F | Component timings | No whole-stage optimization or performance claim |

## Next work, in order

1. Resolve complete same-interpreter nested compiler execution without accepting a direct-root substitute or partial output.
2. Finish BF-owned exact annotated-source admission, original offsets, capability errors, physical closure integration and artifact authority.
3. Complete the BF build entry and independent whole-stage oracle/session checks; run A01–A14 together and preserve a usable baseline.
4. Begin Stage B against that accepted baseline, then advance C–F through separate gates.

The [acceptance matrix](acceptance.md), [issue register](stage-a-issues.md) and [roadmap](development-roadmap.md) define remaining work. Earlier component results apply to their recorded hashes; this update does not retroactively pass missing or failed checks.
