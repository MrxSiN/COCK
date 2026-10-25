# Full Stage C design draft

Actual source continuation: [the retained binary input/EOF primitive](real-bcde-implementation-evidence.md) now exists at `src/stage_c_binary_input.bf`, with exact consumption counts and direct/BF-in-BF checks. It supports the interpreter's input responsibility; it is not a replacement interpreter or the missing expansion/nesting proof. The proposed full-source inventory below remains incomplete.

Prepared 2026-10-25 (Asia/Kuala_Lumpur) against `fe9d57a`, using the [master specification](COCK_Master_Engineering_Prompt_Updated.md), Parts 1–2, 6, 18, 21 and 23–25. **C01–C06 documentary coverage is complete; actual executable first-pass draft is INCOMPLETE, tests NOT RUN, acceptance BLOCKED.** Proposed paths are responsibilities, not created placeholders. The user's request authorizes this design work; specification checkboxes are not execution evidence.

## Scope and prerequisite

Extend the Stage A BF-in-BF tool interpreter incrementally beyond the real compiler workload. Preserve its source, supported build interface and restorable checkpoint. Stage C cannot replace the missing Stage A kernel proof with a new interpreter or postpone identical-interpreter nesting. It does not establish the Stage B Android AOT runtime, require shipping a BF interpreter in APKs, or require universal IR/cache/JIT abstractions.

Current candidate `src/source_pc_dynamic_tape.bf` has bounded component/eight-command/compiler diagnostics. It has normalized u16 source/capacity fields, 16-cell source-record expansion, provisional status bytes and unresolved source/closure constraints. The [actual nested retry](emulator-retry-evidence.md) timed out after 900 seconds. No accepted Stage A/B Android compiler baseline exists. Any representation repair necessary for Stage A belongs in its own inventoried repair, with Stage A regressions, before a Stage C expansion can be promoted.

| ID | Complete design | Closure evidence |
| --- | --- | --- |
| C01 | Exact expansion/test inventory below; retain existing kernel; bounded groups | Actual annotated BF implementations and independent expectations complete/frozen before testing |
| C02 | [Decoder/tape separation](stage-c-interpreter-draft.md), checked representation and source ownership | Cross-layer alias, source/map and growth/physical-failure tests on actual code |
| C03 | Complete eight-command guest profile, loops, binary I/O, EOF and traps | Independent full-state/trace comparisons including guests outside compiler workload |
| C04 | Original raw offsets, preflight/fuel order and locked status/error vocabulary | Full source grammar/precedence, every command cutoff and exact original-offset differential |
| C05 | [Benchmark/acceptance plan](stage-c-test-draft.md), isolated candidate, unchanged accepted default | Passing functional baseline and measured complete costs, including slower results |
| C06 | Separate independent oracle; optional shared frontend/records only after benefit proof | Attributable simplification/performance evidence, compatible interfaces and complete regression; otherwise retain separation |

## Exact proposed executable inventory

Every new path is **NOT CREATED**. All authored executable source, including developer/test tools, must be annotated original-eight-command BF.

| Path | Complete responsibility |
| --- | --- |
| `src/stage_c_input.bf` | Admit/bind exact source, binary input, policy and independent caller/physical completion under a selected fully specified invocation grammar |
| `src/stage_c_decode.bf` | Exact annotated-source admission, raw offset records and precomputed checked bracket map; no command execution before whole-source success |
| `src/stage_c_tape.bf` | Checked guest-to-outer address representation, logical growth, zero initialization and ownership separated from decoder/input/output metadata |
| `src/stage_c_interpreter.bf` | Integrated guest state/PC, all eight command transitions, precise fuel/input/output/traps and authoritative guest completion |
| `tests/stage_c_oracle.bf` | Independently structured raw-source scanner/reference execution using directional bracket searches and separate state representation |
| `tests/stage_c_input_check.bf` | Independent exact caller grammar, lengths, immutable identities and closure-fact checks; no source-prefix or guard-only acceptance |
| `tests/stage_c_decode_check.bf` | Grammar/offset/map integrity and full-source error precedence, including annotation changes |
| `tests/stage_c_isolation_check.bf` | Outer/inner tape, source, frame, counter and nested invocation isolation; explicit overflow and fault cases |
| `tests/stage_c_differential.bf` | Full output/state/trace/result comparison, new guests plus all historical compiler fixtures |
| `tests/stage_c_workloads.bf` | BF-owned deterministic larger/binary/nested workload construction and saved-case replay; seed and exact input identities |
| `devtools/stage_c_smoke.bf` | Coordinated verdicts including original Stage A/B and mandatory identical-interpreter real-compiler checks |
| `devtools/stage_c_bench.bf` | Workload/measurement comparison decisions and baseline/fallback selection; OS timing is external observation |

Candidate modules require one BF-authored composition/entry mechanism, or a single integrated BF implementation with reconciled inventory. A host source concatenator or semantic dispatcher is not an implementation of BF composition. The proposed Stage B source oracle/trace checker may provide **additional independent checks after implementation**, never a silently existing dependency. No native compiler service is reused as an external semantic interpreter.

## Complete inert inventory and implementation groups

Present design files are `docs/stage-c-full-draft.md`, `docs/stage-c-interpreter-draft.md`, `docs/stage-c-test-draft.md`, `config/stage-c/policy.json` and `fixtures/stage_c_full/acceptance.json`. Shared current issues and design archive are in [the C–E checkpoint](stages-cde-draft-checkpoint.md); README, roadmap and status provide navigation. Existing BF sources/fixtures, master prompt and Stage A/B configuration remain unchanged.

Groups are C-DECODE (input adapter/checker, decoder, oracle source admission, map checker and literal source vectors), C-STATE (tape/interpreter/isolation/differential sources and all eight-command fixtures), and C-REGRESSION (workload/smoke/benchmark sources, nested real compiler and original build path). Complete all inseparable dependencies and byte/count/trace expectations in each group before the immutable actual-source freeze. No implementation test runs during source drafting. Repair failures together and rerun applicable mandatory checks; optimization requires a passing baseline. C06 sharing is optional and requires a separate measured decision, never forced consolidation.

Five-state record for every C ID: actual DRAFTED **INCOMPLETE**, IMPLEMENTED **NO**, TESTED **NOT RUN**, OPTIMIZED **NO**, INTEGRATED **NO**. Documentary completion does not open Part 23's test gate. Integration requires accepted Stage A, still-passing Stage B where shared code/build paths are affected, full profile/source/physical authority and exact nesting proofs, plus a preserved rollback checkpoint. Missing target, failing mandatory test or critical bug prevents promotion; independent drafting remains permitted.
