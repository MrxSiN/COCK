# Engineering status

Updated 2026-10-26, Asia/Kuala_Lumpur. **Stage A remains incomplete. Stage B–F are not accepted.** The [documentation index](README.md) distinguishes current guidance, historical evidence and prospective designs.

Latest: [the integrated native compiler batch](android-native-compiler-evidence.md) supplies one BF program for normalized admission, callback, guest and ELF generation. A, B and fresh Q reproduce through BF-in-BF, install and log their distinct bytes on the Pixel. Installed hashes, six native callback regressions and Q's actual 96-byte Android result state pass. [Same-kernel results](same-kernel-evidence.md) now include exact compact A/B raw outputs, but the entire integrated compiler still times out with zero bytes after 600 seconds with a 64-MiB root. This is a tested component checkpoint, not Stage A completion.

[Physical-device evidence](windows-device-evidence.md) records the Pixel 8 Pro run, identities, failures, commands and limits. Four native-only debug APKs produced expected source-derived bytes, including a fresh `H` application. Signatures, alignment, executable inventory and installed APK identity were checked. An isolated invalid-entry package failed with the expected missing-symbol error and was removed.

The callback previously rejected uncontended startup after one failed exclusive store. It now permits at most sixteen attempts. Six exact native state regressions pass, including forced retry exhaustion. The callback is 220 bytes; ELF symbol size, copy counts and padding agree. Guest entry remains at `0x1000`; existing guest instructions are preserved.

| Capability | Current evidence | Acceptance limit |
| --- | --- | --- |
| Physical target | Pixel 8 Pro, API 37, native ARM64, 4096-byte pages | API 35 runtime, other devices and 16-KiB execution not certified |
| Native guest / callback / ELF | One integrated normalized-input BF producer, Bionic loading, A/B/Q logs and native state checks | Original-source frontend and publication authority absent |
| One-layer compiler self-hosting | Entire integrated producer reproduces for A/B/Q under the reference | Mandatory complete nested compiler chain still times out |
| Source validation | 81-file independent annotation audit, BF gates and 18 source vectors | Integrated original errors/offsets, closure and raw-source handoff incomplete |
| Debug packaging | External SDK tools; three installed APK identities, exact BF native bytes, no DEX | DEBUG-ONLY; not Stage D or release |
| Stage B | Isolated arithmetic components and designs | Full Android eight-command compiler/runtime incomplete |
| Stage C | Interpreter components and differential fixtures | Full profile/source-map/resource conformance incomplete |
| Stage D | CRC-32 and stored-ZIP components | BF-native APK/signing and custody gates incomplete |
| Stage E | Binary/text/frame components | Android event/state/UI platform incomplete |
| Stage F | Component timings | No whole-stage optimization or performance claim |

## Next work, in order

1. Resolve complete same-interpreter nested integrated compiler execution. Raw compact compiler nesting now passes, but is not a substitute for the full Android producer; expanded root capacity did not resolve its timeout.
2. Finish BF-owned exact annotated-source admission, original offsets, capability errors, physical closure integration and artifact authority.
3. Complete the annotated-source BF build entry and independent whole-stage oracle/session checks. The normalized-source native stages now compose in one BF file; source/closure/artifact authority remains missing. Run A01–A14 together and preserve a usable baseline.
4. Begin Stage B against that accepted baseline, then advance C–F through separate gates.

The [acceptance matrix](acceptance.md), [issue register](stage-a-issues.md) and [roadmap](development-roadmap.md) define remaining work. Earlier component results apply to their recorded hashes; this update does not retroactively pass missing or failed checks.
