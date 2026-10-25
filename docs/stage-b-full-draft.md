# Full Stage B design draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Actual implementation continuation: [checked u64 addition and other real BF components](real-bcde-implementation-evidence.md) are now implemented and tested directly/through BF-in-BF. `src/stage_b_u64_add.bf` is a complete new arithmetic subcomponent, not the missing frontend/native/compiler/runtime files below. The whole-stage source and acceptance gates remain incomplete.

Prepared on 2026-10-25 (Asia/Kuala_Lumpur), against candidate `57b625c47d17d682080f050f0b0ee9755169b663` and independently fetched main `c5b02dcd1d0eae6793ef7eb84c4bb17fa00c3d8c`.

**All B01–B09 have documentary draft coverage. Executable Stage B first-pass draft: INCOMPLETE. Implementation acceptance: BLOCKED.** This package contains design, inert policy and hand-derived reference data. It creates no placeholder BF modules, generated native templates or claimed test results. In the master prompt, DRAFTED requires complete actual first-pass source; documentary completion does not satisfy that gate.

The [master specification](COCK_Master_Engineering_Prompt_Updated.md), particularly Parts 1–2, 7.4, 8, 21 and 23–25, is the engineering specification used for this draft. The user's present request authorizes drafting Stage B. It does not turn unchecked specification requirements into completed implementation or authorize release publication.

## Scope and baseline

Stage B extends the Android **AOT application compiler** to all eight original BF commands, nested loops, wrapping byte cells, checked right-growing tape, binary I/O, complete annotated-source preflight, original offsets, optional guest fuel and independent differential correctness. It retains the normal compiler-as-guest-of-BF-in-BF build path. The existing tool interpreter's eight-command diagnostics do not establish Android AOT support. Stage C may broaden that interpreter; it cannot absorb missing Stage A self-hosting or Stage B AOT requirements.

Target remains Android API 35, minimum/target SDK 35, AArch64/`arm64-v8a`, direct-install disposable-key debug APK, framework NativeActivity, BF-produced native executable bytes, and disclosed external SDK packaging. There is no Play, release signing, UI, interactive console, managed helper, additional ABI/API or general Android capability claim.

Stage A is not a verified usable baseline. The [latest actual execution](emulator-retry-evidence.md) records a 900-second nested real-compiler timeout and failed APK installation on an incompletely booted software emulator. The 1,232-byte BF-generated ET_DYN probe has a return-only callback; it supplies neither a compiler nor a guest runtime. Production frontend/native/ELF/artifact/build responsibilities in the [Stage A inventory](stage-a-full-draft.md) remain missing. Preserve these candidate checkpoints as diagnostics. No known-working Android compiler checkpoint is invented.

Drafting can proceed independently under Part 25.4. Acceptance/promotion requires a completed Stage A gate, a stable ARM64-capable Android target, and the new source/runtime/ABI gates below. Part 23's STOP/BLOCKED restriction continues to prevent optional optimization, integration and working-feature claims for the failing path.

## Requirement coverage

| ID | Complete design coverage | Evidence required to close |
| --- | --- | --- |
| B01 | Exact executable/inert inventories here; bounded work groups and freeze rules below | All actual files for the selected slice complete, annotations/interfaces reviewed, immutable pretest identity recorded before implementation tests |
| B02 | [AOT lowering](stage-b-aot-draft.md): one original-command block, direct native transitions, checked nested-loop targets | All eight commands and nested loops execute as generated AArch64; independent disassembly, oracle and Android checks |
| B03 | [Runtime](stage-b-runtime-draft.md): commit-on-movement logical growth, checked addresses, zeroed physical backing, distinct physical failures | Left/right boundary, new cells, wrap, allocator/overflow and cleanup tests |
| B04 | Runtime input/output service and private-file debug bridge; binary bytes distinct from status | Exact `00/A5/FF`, EOF counts, partial output, physical write failure and independent device extraction |
| B05 | [Frontend](stage-b-source-draft.md): sealed bytes, full lexical pass then brackets, u64 original offsets | Independent grammar/bracket/source-map oracle, suffix precedence, mutation/count/closure negatives |
| B06 | Source/AOT/runtime command-boundary order, guest fuel separate from outer work and cancellation | Exact trace, evaluated/skipped bracket counts, zero fuel, fuel versus pointer/I/O failure precedence |
| B07 | [Acceptance plan](stage-b-test-draft.md), independent BF oracle/checkers and literal semantic data | Source/AOT/device differential records including all required failures and a fresh held-out source |
| B08 | Unchanged Stage A source/compiler/package identities and old app install/launch reruns | Both original mini apps and held-out regression work through accepted self-hosted path on actual target |
| B09 | Unoptimized benchmark and rollback protocol in acceptance plan | Passing baseline, measured costs; optimization only if justified, otherwise explicit NOT NEEDED |

No B item is marked IMPLEMENTED, TESTED, OPTIMIZED or INTEGRATED by this package. Design-only checks are listed in the checkpoint record.

## Exact proposed executable inventory

Every new path below is **NOT CREATED**. These are responsibilities to implement, not files to generate empty. All authored executable source, including test and developer tools, must be annotated original eight-command `.bf`. No shell/Python/C/assembly/Java/Kotlin/CI executable source is introduced.

| Proposed path | Responsibility / interface |
| --- | --- |
| `src/stage_b_input.bf` | Admit the exact narrow sealed source/binary-input/options record, checked counts/flags/budgets/closure-fact binding and BF-owned handoff |
| `src/stage_b_source.bf` | Sealed-source frontend; complete lexical/bracket admission, raw offsets, command/partner records and policy handoff; supersedes the restricted app capability check only in the new candidate path |
| `src/stage_b_native.bf` | Unoptimized AArch64 block lowering, source-map binding, helper calls, branches/veneers, entry/result ABI and relocatable native records |
| `src/stage_b_runtime.bf` | Emit BF-generated tape, tick, input/output, native service validation, cancellation, worker/lifetime and status-authority native routines; contains no hidden BF interpreter |
| `tests/stage_b_oracle.bf` | Independently structured full annotated-source/reference executor; raw source scans for loop partners, explicit trace and deterministic expected results |
| `tests/stage_b_input_check.bf` | Independent narrow-record marker/length/flag/budget/source-input identity and physical completion checks; reject standard-session grammar mixing |
| `tests/stage_b_native_check.bf` | Independent instruction/relocation/branch/ABI byte checks, symbol-to-source-map correspondence and preserved code identity |
| `tests/stage_b_runtime_check.bf` | Service header/entry/lifetime validation and fault-injection result checks; injection decisions belong to BF-generated test routines |
| `tests/stage_b_differential.bf` | Compare independent oracle, source executor and actual AOT run; compare state/counts/status/offsets as well as exact binary output |
| `tests/stage_b_trace_check.bf` | Decode independent trace records, verify original-command charging and first divergent boundary; bounded binary records, not log-text heuristics |
| `tests/stage_b_bridge_check.bf` | Validate private-file output/status identity, exact extraction/closure and forged/missing/partial completion negatives |
| `devtools/stage_b_build.bf` | BF-owned composition and success routing; source/policy/input snapshot binding, compiler through BF-in-BF, native/runtime/ELF/artifact graph |
| `devtools/stage_b_smoke.bf` | BF-side coordinated regression/device observation verdicts and five-state ledger; host only executes selected physical actions |
| `devtools/stage_b_bench.bf` | BF-authored workload selection/semantic checks and benchmark comparison decisions; external timers report physical observations |

Existing sources remain unchanged in this design package: `src/source_pc_dynamic_tape.bf`, both `src/mini_compiler*.bf`, the uploaded Linux experimental generators and `tests/android_native_entry_probe.bf`. None becomes the Stage B compiler by relabeling it. Reuse `tests/byte_compare.bf` only within its checked two-byte length limit; larger comparisons need a fully inventoried BF widening or bounded chunk comparison before use.

Inherited but still **NOT CREATED** Stage A dependencies are `src/stage_a_elf.bf`, `src/stage_a_artifact.bf`, `tests/stage_a_source_oracle.bf`, `tests/stage_a_native_check.bf`, `tests/stage_a_session_check.bf`, `tests/stage_a_selfhost_check.bf`, and the complete Stage A build/smoke path. Stage B may reuse a subsequently verified ELF/artifact layer only after its exported/imported symbol, relocation, writable-data and multi-file input needs are reconciled. If that requires edits or replacement, those exact files enter the slice inventory before drafting/testing. Documentary reuse is not a resolved binary dependency.

Initial composition decision: implement one integrated BF compiler/build entry or a **BF-authored** composition mechanism with explicit tape ownership. Original BF has no include/call/subprocess command. A conventional linker, source concatenator, host module selector or script cannot fill this gap. The native runtime is emitted code, separate from the compiler's own BF execution tape.

## Complete inert inventory

| Path | Role / present state |
| --- | --- |
| `docs/stage-b-full-draft.md` | Scope, all B IDs, actual states, inventories and slice gates; design complete |
| `docs/stage-b-source-draft.md` | Source/policy acquisition, grammar, maps and precise preflight/runtime precedence; design complete |
| `docs/stage-b-aot-draft.md` | Native block transitions, relocations, ABI and instruction-proof obligations; design complete |
| `docs/stage-b-runtime-draft.md` | Native service, memory, binary bridge, worker/lifecycle and failure authority; design complete |
| `docs/stage-b-test-draft.md` | Consolidated independent test, regression, target, benchmark and rollback plan; design complete |
| `docs/stage-b-issues.md` | Current blockers and closure evidence; design complete |
| `docs/stage-b-draft-checkpoint.md` | Design archive identity, static checks, explicit distinction from source freeze |
| `config/stage-b/target.json` | Inert target/service/ownership policy, not implemented config parser |
| `fixtures/stage_b_full/semantics.json` | Hand-derived literal source/fuel/tape/I/O expectations, NOT RUN |
| `README.md`, `docs/status.md`, `docs/development-roadmap.md` | Navigation and accurate Stage B state |

No Stage B ELF/APK/native golden, output-captured expectation, executable recipe, signing key or production configuration parser is fabricated. Stage A's manifest remains the proposed base; Stage B continues its package/library identity for regressions. Any manifest change must be inventoried with independent decoded-manifest expectations first.

## Bounded implementation groups and dependencies

| Group | Scope / files to complete together before testing | Acceptance boundary |
| --- | --- | --- |
| B-SOURCE | Narrow input admission/checker, frontend, independent source portion of oracle, source/input fixtures, source/policy contract | Exact snapshot/preflight/maps only; no Android AOT claim |
| B-SERVICE | Runtime generator, runtime/bridge checkers, service ABI/layout/injection vectors, lifecycle fixtures | Independently inspected emitted routines and real device service/worker tests; full guest support still unaccepted |
| B-AOT | Native generator, completed service/ELF integration, build driver, native/trace/differential checkers, complete opcode/branch goldens | All eight commands, loops, traps/fuel and actual compiler-through-BF-in-BF artifact path |
| B-REGRESSION | Smoke/benchmark BF tools, full source/session/self-host checks, both mini apps and target fixtures | Stage A reruns plus complete B07/B08; baseline measurements only after correctness |

These are task boundaries, not new protocol or language versions. A group with inseparable service/native/ELF dependencies must be combined with those dependencies before its test gate. No small proof is substituted for the full stage gate. Write actual implementation-specific instruction/layout expectations before executing each implementation. Select fresh held-out source after the actual complete source freeze, not after this design archive.

For each group: inventory all changes/dependencies; resolve representation/ABI/target feasibility; draft every actual BF file and independent fixture; freeze a restorable complete checkpoint; execute coordinated unit/oracle/integration/target tests; triage all results and repair together; rerun affected and mandatory regressions. Record DRAFTED, IMPLEMENTED, TESTED, OPTIMIZED and INTEGRATED separately. No tests during first-pass source drafting and no optional optimization while mandatory correctness/target checks fail.

Stage B integration requires all B IDs, verified Stage A, exact executable ownership and debug APK identity, full-source and real nested-compiler proof, correct device behavior/lifecycle, and a retained rollback checkpoint. Until then the candidate branch remains a reviewable development checkpoint.
