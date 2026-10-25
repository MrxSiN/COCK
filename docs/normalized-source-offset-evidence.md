# Normalized guest source offset preflight diagnostic

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**2026-10-24. COMPONENT DIAGNOSTIC PASSED. Stage A remains NOT ACCEPTED. Android deferred.**

## New implementation

`src/normalized_source_offset_gate.bf` is manually authored annotated Brainfuck with **1,252 executable commands** and SHA256 `500ef891d6d3f7a5ff2cfc4fe64aa850a75a65a6c676a88c85d931239a77c6d6`. It reads one unsigned byte `N`, then precisely `N` normalized source bytes, followed by required nonzero guard `A5`. It emits exactly two diagnostic bytes after attempting the full record: `status` and the first invalid original command byte offset. `00 FF` means all bytes belong to the eight-command alphabet; `01 ii` means illegal byte at zero-based index `ii`; `0B FF` means an absent or wrong guard. A malformed terminal guard takes precedence over a known invalid source byte.

The program produces **no guest output and no source bytes** during validation. A source such as `+.X` is rejected with `01 02` rather than invoking the interpreter and leaking the preceding guest output. An `X` at byte 254 is also located correctly. The current interface allows 0 to 255 source bytes per invocation; this is a diagnostic record limit rather than a system-wide source limit.

## Executed verification

- Exhaustive one-byte alphabet checks: **256/256**.
- Seeded valid-source randomized cases: **450/450**.
- Seeded arbitrary-byte randomized cases: **450/450**.
- Wrong or missing completion guard: **4/4**.
- Source-length boundary cases through 127 bytes: **5/5**.
- Invalid last-byte positions through 127 bytes: **4/4**.
- Further 128, 254 and 255 byte boundaries: **6/6**.
- **Total new randomized and boundary cases: 1,175/1,175 passed** after the initial defect was corrected and the full run repeated.
- **11/11** saved binary fixture pairs rerun successfully.
- **6/6** legacy raw AArch64 artifacts separately rerun through the unchanged `bf_in_bf_six_cell.bf` kernel and compared byte for byte against the frozen candidate files.
- **35/35** repository Brainfuck sources passed the independent static annotation and bracket audit.

The first draft had a copying-loop error when the first invalid byte followed at least one valid byte, causing an outer evaluator instruction-budget exhaustion. The copy loop was corrected with a decrement inside its restore loop. The full 1,169-case initial suite and the six additional long-length boundary cases then passed. The legacy compiler code and candidate binaries were not changed.

## Explicit limitations and negative evidence

A source `+.[` passes **this lexical checker**, because verifying matching brackets is a distinct operation. This is an intentional negative acceptance probe; downstream execution is **not authorized** without the separate complete bracket/source admission authority. The diagnostic input is normalized source only, not Part 1 annotated `.bf` text. The gate returns only status and offset, not an admissible source stream, so BF-owned validation-to-interpreter routing remains unfinished.

The guard rejects EOF-produced zeros at the expected trailer position, but BF `,` cannot independently detect extra bytes **after** the guard. It is not the `COCK-FRAME-v1` protocol or a substitute for actual byte-count, host read status and process/stream closure. A hostile or failed host cannot be authenticated through this gate. The separate outside-repository harness issued finite inputs and checked exact process completion. The BF evaluator is a **local diagnostic**, not an independently certified bootstrap. The source itself is hand-written eight-command Brainfuck; the independent test suite was executed outside the repository. No foreign-language executable test source was checked in.

## Reproduction contract

Use any independently available BF executor that implements the documented 8-bit wrapping-cell and binary-I/O behavior. Feed the exact binary records in `fixtures/normalized_source_offset_gate/` to `src/normalized_source_offset_gate.bf`, confirm successful host exit, and compare every stdout byte with its paired `expected.bin` file. Then independently verify read-count and transport closure. Unmatched-bracket and trailing-byte cases are **not** accepted by this component as complete-source proofs.

Two executed negative nonacceptance probes confirmed that an extra `X` after an otherwise valid `A5` guard is still reported `00 FF`, and `+.[` is still reported `00 FF` by this strictly lexical checker. Neither result is admissible as complete COCK preflight.
