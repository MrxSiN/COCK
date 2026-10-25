# Dynamic guest tape development slice

Status at drafting: NOT RUN. No Android work is in scope.

## Goal

Add a COCK-authored diagnostic BF-in-BF execution component with dynamically right-growing guest tape cells. Guest source for this first slice is a *trusted, already admitted*, contiguous stream of original `+ - < > .` commands, terminated by a zero byte under independently known host input length and closure. Only this five-command subset is supported; unmatched loops, guest `,`, nonzero illegal commands and annotated source are rejected or unsupported. It is not a full COCK executor.

## Design

Each guest tape cell is a twelve-cell outer BF record with one byte of guest value, one opcode scratch, temporary compare cells, an active marker, an origin sentinel only on logical cell zero, and trap status. The interpreter reads original guest commands one at a time and moves the outer tape head between adjacent guest records. Right moves allocate or address another zero-initialized host record as needed. Left at origin reports code `04` and stops without crossing the outer BF left boundary. A non-admitted opcode reports `13`. This first slice intentionally DOES NOT implement bracket dispatch, exact source offsets, complete-source validation, guest fuel or host closure. The root diagnostic BF executor supplies eight-bit wrapping cells and right-growing physical host memory. No fixed guest-tape cap is coded; physical memory remains finite.

Output is diagnostic: guest `.` bytes in order, followed by exactly one terminal status byte (`00` success, `04` left boundary, `0D` unsupported opcode). This is not the final COCK status envelope and may contain partial guest output before a bad opcode; no build or artifact publication is permitted from this prototype.

## Complete initial file inventory

- `src/bf_in_bf_dynamic_linear.bf`: the full BF-authored production-algorithm candidate for this bounded slice.
- `docs/dynamic-tape-slice-plan.md`: this frozen acceptance and interface plan.
- `docs/dynamic-tape-evidence.md` and `docs/dynamic-tape-evidence.json`: results to be filled only after the consolidated test batch.
- `fixtures/dynamic_tape/vectors.json`: inert source and expected exact-byte fixtures.

No outside-language executable code or wrappers will be written into the repository. The externally compiled diagnostic BF executor remains outside the repository and does not implement guest semantics for this component.

## Test inventory frozen before execution

- Blank source; single arithmetic and wraparound; printable/binary `.` bytes.
- Right growth past six guest cells, past 255 guest cells, and roundtrip left to the first cell.
- Repeated visitation of newly allocated cells; preserved old values; zero initial values.
- Left move from origin on first command and after a return; no underflow or accidental success.
- Illegal `[` / `]` / `,` / random non-admitted byte reports `13`; a valid source with an invalid suffix exposes provisional partial output explicitly.
- Differential output/status against a standalone independent diagnostic reference model, randomized terminating five-command source programs with no left underflow except named trap vectors.
- Recheck six frozen machine-code outputs against the *unchanged* six-cell compiler interpreter path; do not ascribe those passes to the new interpreter.
- Independently audit repository BF source grammar and brackets; archive ZIP integrity.

## Exit condition

Promote this component only as a dynamic-tape diagnostic subprofile after the full batch passes. Keep Stage A unaccepted until guest loops, trusted source preflight/host closure, dynamic tape runtime budget checks, original-command fuel, and the same-interpreter full nested compiler are proved. Never silently claim that five-command support can run the real mini compiler.
