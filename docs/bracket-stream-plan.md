# Stage A streaming bracket gate slice

First pass inventory and test design frozen before source drafting and execution testing.

- `src/bracket_stream_gate.bf`: Brainfuck authored streaming bracket depth validator supporting multiple physical data chunks followed by a mandatory terminal record.
- `fixtures/bracket-stream-vectors.json`: passive framed examples and required negative fixtures.
- `docs/bracket-stream-evidence.md`: exact test results including failure and repair records.
- `README.md` and `docs/status.md`: update only after diagnostic tests.

Input grammar: zero or more records `u8 count (1 through 255) | count normalized BF instruction bytes | literal A5`, then exactly one terminal `00 A5`. No further bytes allowed by independent host closure. The part validated in Brainfuck is the explicit length, per-record guard, bracket depth and first-unmatched-close rejection. A separate lexical gate must verify that all data bytes are exact commands `+-<>[].,`; host transport must independently report real counts/stream closure, since guest EOF writes zero. This custom provisional diagnostic stream is **not** a frozen BFIO or BHIO wire contract and cannot be presented as such.

Input length across chunks has no global cap; per-chunk size 255 is a fixed *record representation*, not a project constraint. Bracket nesting depth beyond 255 is a implementation specific logical capacity of this early component: it must reject overflow, rather than accept wrapped depth. Failure output one zero byte, balanced completion output one byte 01. This component does not implement full Part 1 syntax or Stage A compiler execution. Source bytes are read and validated before any acceptance result is emitted.

Frozen acceptance: empty terminated stream, one chunk with `[]`, multiple chunks separating a matching pair, actual mini-compiler command stream across 255-byte chunks (515 commands), random valid and invalid command streams, immediate unmatched closing before later balanced suffix, malformed/missing data guard, absent final terminal record, maximal depth 255, depth 256 rejection, and random chunk partitioning. Compare against an independent outside-repository diagnostic depth model. No implementation test before the first draft of all inventoried files.
