# Stage A issue register

Updated 2026-10-26. [Device evidence](windows-device-evidence.md), [acceptance](acceptance.md) and the [documentation index](README.md) own current status.

Latest [integrated producer results](android-native-compiler-evidence.md) and [nested ledger](same-kernel-evidence.md) refine the open issues: normalized-source native stage composition is implemented and one-layer/device tested; exact compact A/B raw nesting passes. Full integrated nesting still fails after 600 seconds with 64-MiB root capacity. The original-source frontend/error API, output authority and general build entry remain missing. Existing issue rows below remain open at whole-stage scope.

| Issue | State | Evidence or required action |
| --- | --- | --- |
| A-CALLBACK-EXCLUSIVE | FIXED / TESTED | One failed exclusive store falsely rejected physical-device startup. Bounded sixteen-attempt acquisition fixes it. Six native cases include forced retry exhaustion; binary consumers and metadata follow the 220-byte contract. |
| A-TARGET | AVAILABLE / SLICE TESTED | Pixel 8 Pro API 37 ARM64 loads BF libraries and emits source-derived output. Old emulator failures are historical; API 35 and 16-KiB execution remain unverified. |
| A-NATIVE / A-ELF | IMPLEMENTED / DEVICE TESTED COMPONENTS | Guest, callback, liblog relocation and ET_DYN work on the pinned device. Authoritative source/build integration remains open. |
| A-DEBUG | COMPONENT PROOF PASSED | Four native-only candidates run, including fresh H. Wrong-entry package is rejected. Packaging/signing remain external DEBUG-ONLY. |
| A-NEST | OPEN / MAJOR | Reference nested compact A/B and original A pass exact raw output. Full integrated Android compiler fails at 600 seconds with zero output even with 64-MiB root tape; callback/guest nested attempts also time out. Partial/raw-only proofs do not close this gate. |
| A-SOURCE | OPEN / MAJOR | Implement exact BF frontend, original offsets, capability errors, precedence and atomic handoff with independently verified read/count/close. |
| A-DRIVER | OPEN / MAJOR | Native normalized admission/callback/guest/ELF now compose in one tested BF program. Original-source entry, artifact/session authority and usable whole-build CLI remain absent. |
| A-CAPACITY | OPEN / MAJOR | Checked native size passes at 65,532 bytes and rejects overflow; full compiler source is 29,542 commands. A 64-MiB nested root still times out. Diagnostic u16 fields are not universal app limits or a full nested-working-set proof. |
| A-TESTS / A-DRAFT | OPEN / MAJOR | Finish missing whole-stage BF implementations and independent oracle/session/self-host checks, freeze, then run consolidated acceptance. |
| A-BOOTSTRAP | PARTIALLY QUALIFIED | Android seed/backend pass byte/EOF and existing interpreter controls. Windows binary I/O fails and is excluded. Full profile/authority qualification remains separate. |
| A-PROVENANCE | HISTORICAL LIMITATION | Earlier evidence disclosed conventional outside-repo drafting aids. Current source audit cannot certify old authoring provenance retroactively. |

No optional optimization or later-stage promotion is claimed while mandatory Stage A gates remain open. Independently supportable implementation can continue without another development-start approval. Production signing and release publication retain separate authorization/custody requirements.
