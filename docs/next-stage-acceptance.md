# Consolidated batch for the nested-proof draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**NOT RUN.** These are prospective invocations and acceptance rules, not evidence of execution. The new source is frozen at the [draft checkpoint](next-stage-draft-checkpoint.md). Do not test during the draft, silently regenerate expectations from actual output, or replace a nested run with direct execution of the compiler.

## Execution boundary

Run from `/workspace/COCK`. The installed external seed is `/workspace/tools/bin/tritium`. BF code owns source admission, projection, request construction and byte comparison. Standard installed `printf`, `cat`, `dd`, `wc`, `cmp`, `sha256sum`, `timeout` and the shell may only materialize literal bytes, count/copy exact sealed byte ranges, schedule processes, capture process/close outcomes and independently veto a result. No Python, conventional test generator, guest parser, guest-semantic host oracle or source-layout generator is part of the batch.

The BF driver emits bytes; it cannot start OS processes using the original eight commands. External scheduling is mechanical test execution, not a hidden production BF launcher. A zero BF comparison result is one necessary observation and never the physical completion authority.

Use fresh output paths outside the checkout under `/workspace/test-results/nested-proof`. Record command, exact stdin identity/length, executable/source identity, UTC timestamp, backend, declared timeout, exit status, stderr, stdout identity/length, comparisons and close results for each invocation. Preserve the command's exit status before any subsequent inspection; do not mask it through a pipeline. The report may display dates in Asia/Kuala_Lumpur with the explicit timezone.

## Ordered batch

1. **Admission and language ownership.** Inspect every tracked executable source and any newly introduced file. The only new executable is `tests/nested_request.bf`. Submit its exact physically counted annotated bytes through the preserved BF `source_guard_records` and `annotated_source_stream_gate`; expect `01`. Use the preserved BF normalizer for execution-stream identities. Deliberately unsafe comments and mismatched brackets must fail admission. This is an acceptance test, not a documentary draft review. Preserve historical provenance limitations; do not certify old authoring history from a present source audit.
2. **Six literal serializer vectors and four counter boundaries.** Materialize the literal records in `fixtures/nested_proof/vectors.json`. Each payload boundary uses an exact byte range of the existing frozen growth fixture. Expected output is the specified literal header and the same sealed payload ranges in the documented positions. This is mechanical routing of expectations, not host compilation. Compare exact length and bytes with both the existing BF comparator and independent `cmp`. All ten cases must finish with process exit zero under 30 seconds each. If they do not, record the full batch and group any driver repairs; 65,535 remains unverified by this bounded batch.
3. **Two historical request reconstructions.** The two literal 18-byte recipe headers and exact sealed interpreter/compiler ranges are fully specified in the fixture inventory. Feed each completed recipe into the new BF driver. Require exact identity with the unchanged corresponding `fixtures/dynamic_kernel/nested/*.input.bin`. Independently re-project the actual root kernel and compiler sources with BF and compare the embedded bytes; using frozen segments alone does not prove source identity. A serializer pass means only that the request was built correctly.
4. **Result veto tests.** Feed the six mismatched literal outputs through `tests/byte_compare.bf`, with the exact 18-byte completed result as expected. Require `01`. The two equal-byte examples must yield `00` from the comparator but remain overall failure/no-commit because process/closure evidence is invalid. The three physical-input negatives must be vetoed on actual length/closure; the serializer itself is not expected to detect EOF ambiguity. Do not change the BF driver to pretend it can certify an absent OS close result.
5. **Existing regression batch.** Replay the 30 literal kernel vectors, two growth cases, the explicit balanced-depth case, 73 legacy profile replays with the documented depth expectation, BF comparator self-tests, independent common-profile BF comparisons and six real compiler payloads from `dynamic-kernel-evidence.json`. Also preserve both existing postdraft ASCII compiler checks and the arithmetic oracle. Counts overlap; report groups separately. The kernel/compiler source and all existing goldens must remain unchanged for this infrastructure slice. Any changed kernel triggers a new repair inventory and full affected acceptance batch.
6. **Mandatory nested gate remains separate.** Existing 300/600-second runs have already failed. Do not spend another identical timeout to declare progress. Before a further run, record what resource changed, the exact backend, wall ceiling, logical fuel/capacities, available memory/CPU and expected completion bytes. A planned changed-resource diagnostic may use one 1,800-second compiled-backend run, if resource inspection supports it; it is NOT RUN and not automatically authorized by this draft as an accepted result. Preserve outer fuel `ffffffff`, outer capacity `0040`, inner fuel `ffff0000`, inner capacity `0800` for request identity. Any requested change belongs in a separately identified input. Do not retry serially without a new diagnosis. The short `+.` input is a raw compiler-component diagnostic, not an admitted printable Android guest.
7. **Real application coverage after a completed nested control.** Run the identical-kernel chain with each actual original and compact compiler on both printable examples, then select a new admitted held-out input after this draft checkpoint. Compare the entire BF-produced native payload plus both statuses, source-derived instruction differences and the independent BF arithmetic result. The existing `heldout_mixed_ascii.bf` is a regression, not a fresh held-out selection. Define and freeze each new expected literal test result independently before invoking the compiler on it. No program-name lookup, prebuilt output or host compiler can supply actual production bytes.
8. **Target and final decision.** Android build/install/launch tests remain NOT RUN without a usable ARM64 execution target and BF-generated entry/ELF. Do not start the unstable AVDs just to repeat a known failure for a serializer change. Record those missing gates and the root qualification/physical authority gaps. Update the five statuses only from observations. A passing driver suite is an independently useful test component; it does not promote the failing interpreter or accept Stage A.

## Prospective command forms

After the draft gate opens, this executes the new serializer on one complete sealed recipe. Redirections and paths below describe the batch's future files; they have not been run:

```text
timeout 30 /workspace/tools/bin/tritium -r -b -z -B -O1 -fno-negtape tests/nested_request.bf < /workspace/test-results/nested-proof/compact.recipe.bin > /workspace/test-results/nested-proof/compact.request.bin
cmp /workspace/test-results/nested-proof/compact.request.bin fixtures/dynamic_kernel/nested/compact.input.bin
```

Record the first command's exit before running the second. For BF comparison, the complete physical packet is `u16 expected byte count | expected bytes | u16 actual byte count | actual bytes`; use `tests/byte_compare.bf`, expect exactly `00`. Counts must be measured from closed actual files, never copied from an expected label. The comparator's 16-bit count limit is adequate for this batch's requests; it does not cover every possible maximum-size serializer output. Veto oversized comparison jobs instead of wrapping lengths.

Only after a resource decision and input-identity checks, an increased-wall-budget diagnostic would take this form:

```text
timeout 1800 stdbuf -o0 /workspace/tools/bin/tritium -r -c -b -z -B -O1 -fno-negtape -mem 2097152 src/source_pc_dynamic_tape.bf < /workspace/test-results/nested-proof/compact.request.bin > /workspace/test-results/nested-proof/compact.result.bin
```

The root's compiler backend is external executor implementation, not a COCK native compiler. A timeout, signal, incomplete output, nonzero status, stderr evidence of failure or unknown closure defeats acceptance even if the observed output contains native bytes. Native prefix `00 00 80` is the historical timeout result, never a valid completed proof.

## Exit rules

Group failures, repair all affected driver/test files together, freeze the repair checkpoint, then rerun affected checks and the whole relevant suite. Do not optimize the kernel while the mandatory nested gate fails. If changed resources still cannot complete it, record **BLOCKED: nested feasibility** with the exact completed invocation and stop that acceptance path. A necessary algorithm repair must be justified by the diagnosed failure and drafted as its own full slice; do not disguise an optional optimization as repair.

Full Stage A additionally requires qualified bootstrap/profile behavior, trusted exact source/closure and original offsets, printable capability admission, real BF-native Android entry/ELF, debug-only packaging and both distinct app launches plus a fresh held-out observation. Passing this batch cannot waive those gates. Later-stage designs in the roadmap remain unimplemented.
