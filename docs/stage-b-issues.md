# Stage B issues and closure requirements

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


All entries are open at the 2026-10-25 design checkpoint. No runtime check was performed while drafting this package. [Actual latest execution](emulator-retry-evidence.md) remains the source of emulator/nesting observations.

| Issue | Severity / affected IDs | Evidence and impact | Required closure |
| --- | --- | --- | --- |
| B-BASELINE | CRITICAL / B01, B08, B09 | Stage A is not accepted; production source/native/ELF/artifact/build missing | Complete A01–A14/A09a with a restorable known-working self-hosted debug compiler, both mini APK runs and all required independent checks |
| B-NESTING | CRITICAL / B01, B07, B08 | Identical-interpreter real compact compiler still timed out after 900 seconds; only three output bytes | Necessary, fully inventoried representation/performance/capacity repair or evidenced changed execution route, then exact full nested real-compiler output and both successful completions; no fixed probe substitution |
| B-TARGET | CRITICAL / B04, B07, B08 | Software emulator did not finish boot; package/storage services failed; no KVM; no actual probe load | Stable API-35+ ARM64 target or proved bridge, real load/launch, lifecycle and binary extraction; preserve actual failure evidence |
| B-SOURCE | MAJOR / B01, B05, B07 | Separate old parsers exist; integrated sealed original-offset frontend/full oracle absent | Complete BF source and independent oracle, exact grammar/precedence/source maps, physical snapshot/session proof |
| B-INPUT | MAJOR / B01, B04, B05 | Exact narrow draft record is specified, but BF admission/independent checker and physical binding are absent; Stage A record cannot silently change | Implement the inventoried BF narrow input/checker, literal marker/length/flags/budget/closure negatives and immutable source/input binding; do not claim standard multi-file session compliance |
| B-AOT | CRITICAL / B02, B03, B06, B07 | No Android eight-command native compiler exists; Linux arithmetic examples and no-op ET_DYN probe are insufficient | Complete BF native/runtime/ELF composition, independent byte/relocation goldens, actual native semantic/fuel/state tests |
| B-SERVICE | CRITICAL / B03, B04, B06 | Runtime service table is proposed; no emitted functions or binding/ownership tests | Exact emitted ABI/state layout, live-handle validation, tape/I/O/fuel and allocator/error tests plus real device behavior |
| B-LIFETIME | CRITICAL / B02, B04, B08 | Worker/library lifetime, destroy/cancel and potentially blocked OS write are unproved | Supported bounded callback/worker lifetime, cancellation/cleanup under all failures, no stale NativeActivity accesses or unload hazard, measured responsiveness; redesign if infeasible |
| B-CAPACITY | MAJOR / B01, B02, B07 | Current interpreter uses u16 lengths/capacity and 16-cell source records; final compiler/runtime emitter working set unknown | Checked actual normalized BF size and full nested tape requirements; necessary BF widening/storage repair and complete regressions; no direct-root substitution |
| B-GOLDENS | MAJOR / B01, B07 | Literal semantic seed data exists; native/ELF/service/trace exact byte vectors and complete BF tests absent | Author every actual implementation-specific independent expectation and complete BF test source before freezing/testing the relevant group |
| B-OWNERSHIP | MAJOR / B01, B07, B08 | Earlier external authoring/evaluator provenance is uncertified; new docs cannot repair history | Repository-wide BF source audit and disclosed immutable provenance for new work, explicit residual historical limitation; no foreign executable helper or native template |
| B-PERF | MAJOR / B09 | No passing whole-stage unoptimized Android baseline or measurements | Correctness/target first, then repeatable time/memory/size observations and justified optimization or NOT NEEDED |

The master Part 23 instruction is: “If an unresolved critical bug, failing check or unavailable mandatory target remains, STOP / BLOCKED: do not optimize, integrate or represent the feature as working.” This closes promotion and optional optimization of the affected path. Part 25.4 permits independent source work and drafting; another start-work approval is not required for authorized development.

Close an issue only with exact changed source/contract/checkpoint identities and completed independent results. Keep missing implementation, a failed test and an unavailable target distinct. Never weaken expected fuel/trace behavior, discard a regression, mark a skip as success, or defer mandatory Stage A proof into Stage C to remove a blocker label.
