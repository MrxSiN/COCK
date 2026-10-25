# Stage A bounded source fetch slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Goal:** BF-authored repeatable instruction lookup using sixteen-bit unsigned positions over a source program loaded once, with nonmonotonic query order, including the 255/256 boundary and both actual mini compiler sources. This is an execution primitive for a later program-counter dispatcher, **not** guest execution.

## Inventory frozen for this slice

- `src/source_pc_16bit_fetch_many.bf`: only authored executable source. Every executable character is one of the original eight commands; other bytes are safe comment lines, whitespace and line endings.
- `fixtures/source_pc_16bit_fetch/*.input.bin` and `*.expected.bin`: inert, exact-byte program/query and response vectors.
- `docs/source-pc-16bit-fetch-plan.md`: input contract and acceptance plan.
- `docs/source-pc-16bit-fetch-evidence.md` and `.json`: measured regression and limits, written after the batch.
- Existing original/compact mini compiler source and six frozen raw AArch64 binaries: **read-only regression baselines**.

## Diagnostic contract

Stdin begins with an already normalized original-eight-command program, with `00` as a terminating byte, followed by one unsigned byte query count `Q` and exactly `Q` little-endian unsigned sixteen-bit source-command indexes. No two query positions need be monotonically ordered. For each query, stdout contains the selected instruction byte and a status byte. `00` status means the instruction was present, `0D` status means no instruction was present (in that case the preceding opcode is zero). The program and result are **not** BFIO/BHIO records.

The accepted source requires independent exact-source preflight, a trusted real byte count, read/pipe closure and honest process exit. The NUL terminator is *not* a substitute for a checked complete-source length; embedded NUL, malformed nonzero source characters, an absent terminal NUL, or appended unread bytes can invalidate the authority of this diagnostic protocol. Individual queries admit the range 0..65535, and each invocation has at most 255 queries. These bounded record widths **do not impose a global COCK source or app size limit**. The loader has no independently enforced source byte-count ceiling and is not accepted for production.

The source records use four outer BF cells per instruction and temporary navigation markers. The fetch loop leaves the original opcode cells unchanged, moves a sixteen-bit remaining index, and rewinds across marked records before the next query. No guest BF instructions are interpreted.

## Acceptance vectors

- Input query count zero and empty source; one and repeated lookups at offset zero; exact last opcode; one-past-end; five consecutive 255/256-crossing queries; backward and repeated lookups.
- All eight legal opcodes, real 515-command original compiler, real 452-command compact compiler, and source with 65,535 bytes whose last instruction is queried.
- Representative random eight-command sources, random valid/out-of-range unsigned sixteen-bit queries, and binary exact-output comparison.
- Independent full-source BF syntax audit, frozen six raw-code candidate hash preservation, and ZIP archive integrity.
- Negative observations for illegal nonzero source opcode, embedded NUL, missing NUL and appended unconsumed bytes must be recorded as unsupported/unverified, not successes.

**Test boundary:** externally installed compiled diagnostic BF evaluator (outside repository), with an independent ordinary-language *verification only* oracle. Neither may generate production source or output artifacts. This does not satisfy the mandatory COCK interpreter, runtime fuel, Android or nested self-hosting acceptance gates.
