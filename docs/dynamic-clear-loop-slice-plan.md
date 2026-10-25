# Dynamic tape interpreter clear loop slice

Status before consolidated test batch: DRAFTED NOT RUN.

## Objective

Preserve the verified right-growing tape interpreter while introducing one real guest loop construct in a separately named candidate. The only newly admitted bracket sequence is the complete adjacent command trio `[-]`, which has the normal eight-bit wrapping Brainfuck behavior with no configured guest fuel. Other loop forms remain explicitly unsupported, not silently executed or rewritten as a complete language implementation. The guest moves along the existing dynamic tape, and an admitted clearing loop executes at the current cell. Host input still represents a trusted finite source stream followed by one non-source zero delimiter; exact byte-count and complete-source preflight are external prerequisites. No output from this candidate may authorize packaging.

## File inventory

- `src/bf_in_bf_dynamic_clear_loop.bf` — annotated BF implementation extending the original five-command dynamic tape candidate with one supported guest loop pattern.
- `fixtures/dynamic_clear_loop/vectors.json` — inert expected-byte fixture data, including positive, negative and boundary cases.
- `docs/dynamic-clear-loop-slice-plan.md` — this interface and acceptance plan.
- `docs/dynamic-clear-loop-evidence.md` and `.json` — post-batch evidence and honest limitations.
- Existing compilers, the original six-cell interpreter, and their frozen binary outputs remain unchanged.

## Acceptance tests

- Complete zero-iteration and multiple-iteration clearing loops; byte wraparound and repeated clearing; loops at address beyond the former fixed six-cell tape; loops followed by output and pointer movement.
- Rejection of other bracket forms and malformed/truncated clear sequences, with diagnostic unsupported code `0D` and without unbounded interpreter reads.
- Preserve the original linear subset and its left-origin trap; random terminating mixtures of five linear commands and `[-]` against an independent outside-repository reference model, including travel beyond cell 255.
- Verify valid clearing does not spuriously leave a status marker or contaminate subsequent guest operations.
- Audit all repository BF sources for annotation grammar and balanced BF brackets. Independently recheck all six frozen raw AArch64 outputs through the unchanged compiler-capable six-cell interpreter, without attributing them to this restricted candidate.
- Verify archive integrity and report executable code size. A guest source with an invalid suffix is a known preflight failure mode and MUST NOT be counted as a pass for the full COCK source contract.

## Exclusions

This slice does not implement arbitrary loop bodies, backward branch search, guest comma input, guest fuel, exact guest source offsets, dynamic logical cell budgeting, host transport closure, complete-source preflight or the required same-interpreter nested mini compiler proof. `[-]` execution under an unlimited-fuel contract cannot be promoted as a fuel-aware optimization without original-command accounting.
