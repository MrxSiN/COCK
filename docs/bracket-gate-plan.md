# Stage A bracket gate bounded slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status at plan freeze: implementation and tests NOT RUN. This document enumerates the entire first pass before implementation testing.

## Bounded files

- `src/bracket_depth_gate.bf`: a BF-authored second-layer validator for *already lexically normalized* full eight-command input, with a one-byte configured per-invocation source-count encoding, required `A5` trailer, checked nesting depth, early closing-bracket detection, and one Boolean output.
- `fixtures/bracket-depth-vectors.json`: literal positive and negative input/output vectors, including empty source, nested loops, premature closing, unmatched opening, and corrupted trailer.
- `docs/bracket-gate-evidence.md`: measured outcomes, failures, commands, hashes, and honest remaining gates after consolidated testing.
- `README.md` and `docs/status.md`: evidence-based integration updates after regression.

## Contract and limitations

Input is `[u8 source_count][source_count raw BF command bytes][0xA5]`. Count 0 through 255 is a **per-invocation configurable logical resource budget in this component** and not a universal project length limit. The gate assumes a separate source lexer has admitted only exact eight-command bytes; it is NOT a lexer or a complete Part 1 annotated-source preflight. It must never be used on arbitrary file bytes. Independent exact input count, end-of-stream closure, and host process status remain mandatory. Output one byte `01` only for structurally balanced brackets and matching guard; otherwise `00`. The gate does not emit production executable output and cannot authorize compilation by itself.

## Acceptance vectors before draft

- Empty stream `00 A5` -> `01`; `[]`, `[[]]`, `++[->+<]`, `+[-]`, no brackets -> `01`.
- `]`, `[`, `][`, `[]]`, `[[`, malformed trailer `00`, and absent trailer -> `00`.
- Byte count 255 containing 255 opens is rejected (not balanced) without wraparound; deeply nested matched brackets within budget accepted.
- Random nested streams: compare output against an independent external bracket-depth diagnostic oracle, NOT claim the oracle is BF or production.

No implementation tests are run until all new first-pass files exist.
