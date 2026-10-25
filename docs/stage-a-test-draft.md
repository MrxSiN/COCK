# Whole Stage A consolidated acceptance draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**NOT RUN as a complete stage. Test gate CLOSED until every required first-pass BF implementation/test exists and is frozen.** Existing component outcomes remain in their historical ledgers, including the failing nested execution attempts. This complete batch covers A01–A14 and A09a without inferring any pass from this document or the presence of installed tools.

## Draft readiness before execution

Reconcile the full executable/inert inventory in `stage-a-full-draft.md`. Resolve source composition, BF tape/representation/resource feasibility, every new dependency and exact interfaces before claiming all-source DRAFTED. All implementation modules, independent BF oracles/checkers/driver logic, literal inputs/expected bytes and prospective commands must be complete with no empty placeholders. New BF files need Part 1 purpose/input/output/tape annotations. A paper algorithm is not executable first-pass source.

Freeze the actual complete source, policy, fixture and documentation bytes in a restorable pretest commit/archive. Record its identity before selecting the fresh held-out app or running source, byte, compiler, interpreter, device, benchmark or optimizer tests. The documentary archive for this design package is a different checkpoint and cannot be used to imply missing source was frozen.

`fixtures/stage_a_full/acceptance.json` defines inert expected source/ABI/session/device outcomes. Fill the native implementation's exact independent byte/ABI vectors from its fully chosen encoding/layout before executing it; no expectation is captured from the implementation's actual output and relabeled an oracle. The existing small raw-word anchors do not constitute a full native/ELF expected artifact.

## One coordinated acceptance batch

| Group | Required observations and independent vetoes |
| --- | --- |
| BF-only ownership | Every tracked/generated executable source is annotated original eight-command BF; no foreign script/wrapper/CI recipe, foreign source generator, opaque native template or app-specific opaque executable. Gate actual source bytes with BF; record historical process-provenance limitations separately |
| Root/guest qualification | Freeze external Tritium implementation/hash/backend/flags/cell/EOF/tape/buffering/error assumptions. BF guest behavior must independently implement preflight, traps and resources, including observations the root does not enforce. Buffered root cannot claim interactive BHIO |
| Physical source | Exact count, actual read/close, guarded length, immutable bytes, source mutation, truncation, NUL, trailing bytes, read faults, cancellation and failure before successful semantic admission |
| Annotated frontend | LF/CRLF, indentation, empty/final lines, safe comments, unsafe comments, inline prose/comment, non-ASCII/BOM/control bytes, full-input suffix precedence and exact original offsets |
| Bracket/subset policy | First illegal byte before bracket checking; first unmatched close/earliest remaining open; syntactically valid loops rejected as capability; pointers/input, missing/multiple dot, nonprintable result and per-job limits rejected before codegen |
| Independent BF oracle | Arithmetic modulo byte, source maps/status/offsets, capability decision, binary comparison correctness and source/frontend independence. Do not use the production parser as its only oracle |
| Tool interpreter | Full all-eight-command profile, forward/backward nested loops and exact original command fuel, left/right traps, EOF and `00/ff`, zero/init/growth/boundaries, no preflight effects, wide counts/depth/fuel and memory/representation checks |
| Real compiler single layer | Actual original/full Android compiler as BF guest, source-dependent output for both printable apps, independent byte expectations, immutable compiler/interpreter identity |
| Mandatory identical nesting | Root → same outer/inner BF interpreter → actual compiler, complete expected source-dependent result and both completions, no timeout/prefix/direct-root substitution |
| Native code/ABI | Inspect every emitted word/branch/relocation, context/result layouts, register/stack conventions, non-service checks, source-ordered arithmetic, printable sink/error status, original source map and bounded callback |
| ELF | Independently inspect headers/load permissions/alignments, exports/imports/dependencies, symbol/string/hash/relocation bounds, entry versus manifest mapping, no foreign executable contribution and no text relocations |
| Artifact session | Full selected BFIO declaration/chunk/END/status grammar, exact lengths/order/correlation/offsets/guard, source/producer identity and separate process/write/close authority; forged/missing/early/duplicate status or trailing bytes cannot finalize |
| Debug container/signing | External dependencies explicitly DEBUG-ONLY, disposable key/certificate, package manifest independently decoded, complete executable inventory, signature/tamper/alignment verification, extracted native identity |
| Real Android observation | Stable selected ABI/API/page-size target, install/launch/loader/import success, exact invocation-correlated byte for two apps and fresh held-out source, callback return/ANR/crash/lifecycle/teardown evidence |
| Reproducibility and baseline | Repeat identical sources/policy/tool identity for stable ELF bytes and documented APK signature/container variability; preserve passing unoptimized baseline, actual measurements and rollback |

Run the relevant groups together only after the all-source draft gate. Individual failures do not permit optimizing/promoting another unverified Stage A path. Complete the batch, group related repairs, freeze the repair source, rerun affected checks and then the whole stage suite. Mark unavailable hardware/tools NOT RUN; zero tests, skipped checks or process exit alone never pass a group.

## Existing regression obligations

Preserve the fixed eight-cell baseline, both raw producers and six frozen native artifacts. Reuse the dynamic-kernel 30 literal cases, growth/trap boundaries, balanced depth-256 expectation, 73 adapted legacy cases, BF comparator self-tests, 19 common-profile checks and existing held-out ASCII compiler checks. Groups overlap, so report separate counts. The historic depth expectation change is explicit; do not rewrite an old golden just because a new candidate differs. Any kernel/source-format change requires its full affected test matrix and rechecks of all preserved compilers/artifacts.

The prior nested fixtures carry the complete same 7,248-command kernel and real 452-/515-command compiler. Five completed 300-/600-second attempts failed; JIT/compiled emitted only `000080`. Repeating those unchanged invocations is not a new baseline. First verify the drafted nested-request driver, exact request identities and current source projections. Record a changed-resource or diagnosed functional-repair rationale before any further attempt. A larger timeout is a declared resource choice, not a correctness fix, measured speedup or completed self-hosting proof.

A successful short raw `+.` nested diagnostic would still be outside the printable app policy. Whole Stage A requires the actual final Android compiler path and printable app inputs; an old raw compiler proof alone cannot validate new ELF/native code. Check the final compiler's normalized size and tape working set under the real interpreter; the 16-cell record representation and u16 capacities may require a separate mandatory source repair. Do not silently invoke a too-large compiler directly under Tritium.

## Source-to-output and held-out proof

For app A and B record exact raw source identity, annotated preflight outcome, normalized commands/original offsets, independent arithmetic result, same BF compiler identity, actual guest execution chain, native text differences, ELF identity, final APK identity, extracted ELF identity, selected target and observed log/result/lifecycle. Hold package metadata and external tools constant except unavoidable signed-container facts, and attribute every changed executable region.

Select an additional previously unlisted admitted source only after the actual all-source checkpoint. Derive its expected arithmetic with the independent BF oracle, freeze the literal semantic/native expectations without copying actual producer output, then execute the same compiler path and install/observe it where the declared sink supports it. `held_out.bf` and `heldout_mixed_ascii.bf` are existing regressions and cannot be counted as this fresh held-out selection.

Negative provenance tests: modify source without changing its name, rename identical source, mutate comments preserving commands, alter an arithmetic command, keep package labels fixed, corrupt the staged ELF after approval, replace final in-APK native bytes, replay stale logs and fabricate guest status-like output. Require exactly the relevant identity/semantic/authority veto or independently explained valid equivalence; no source-name table can supply compilation.

## Per-run ledger

Record feature/test ID, draft/source/config/compiler/root hashes, exact command and working directory, selected source/input bytes and sizes, target/API/ABI/page size, seed/backend/flags, wall/CPU/memory budgets, actual start/end with timezone, underlying process status/signal, stdout/stderr identities/lengths, physical read/write/close outcomes, BF oracle/comparison results, independent inspector/device observations and all artifacts. Use UTC for machine timestamps and label Asia/Kuala_Lumpur for user-facing dated reports. Never dump credentials, the environment, private keys or authentication files.

For errors retain phase/code/original offset and executed/input/logical/output counters when applicable; keep physical host faults distinct from guest traps. Status emitted by a tool is provisional until independent completion. An authoritative staged session plus unknown physical close is UNKNOWN / NO-COMMIT, even if every byte matches. Record each test as PASS, FAIL, NOT RUN, SKIPPED or BLOCKED accurately, with counts only for actually completed cases.

## Acceptance and publication

A01–A14 and A09a require actual evidence, including fresh held-out, mandatory identical-interpreter final compiler execution, two distinct real app launches, exact extracted executable identity, runtime ABI/main-thread safety and BF-only source ownership. The full source draft cannot be marked complete while inventoried BF files are absent. Missing implementation, timeouts or unavailable target keep the affected gate blocked.

Only a passing unoptimized Stage A baseline can be integrated as a working restricted debug compiler. Preserve prior known-working raw components and keep the failed candidate reviewable. No BF-native release signing, general Android/UI/binary I/O, policy compliance, optimization benefit or all-device compatibility is implied. Real release-key use and publication require their separate explicit instruction/security gates; a development push is not production release authorization.
