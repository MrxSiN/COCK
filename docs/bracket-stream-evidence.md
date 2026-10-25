# Streaming bracket gate evidence

2026-10-24. All reported executions used the local, **nonqualifying** out-of-repository BF diagnostic evaluator `/usr/local/bin/cock-bf-diagnostic`. No Android, independently supplied BF host or trusted physical source-closure tests were run.

The first-pass inventory and tests were frozen in `docs/bracket-stream-plan.md`; the first consolidated diagnostic batch passed **721 of 721** cases. Breakdown: 8 fixed vectors, 700 deterministic random streams, one actual 515-command mini compiler stream in chunks of 200 plus 200 plus 115, 8 nesting-boundary cases including depth 256 rejection, and four corrupted or missing trailer and termination cases. Source and annotation static audit passed.

The previously saved three raw native candidates remain byte-identical after running the existing BF-authored compiler directly under the local diagnostic evaluator, without the mandatory BF-in-BF layer. This is a regression check, **not** self hosting.

Source SHA256: `d0bd637880b616311be5e9760376a9403aa9f74626ce63fcf7210ff53cc80d9e`.

Diagnostic execution command: `python /tmp/verify-bracket-stream.py`, a temporary outside-repository independent validator used solely for testing. The BF program is `src/bracket_stream_gate.bf` and can receive an exact prebuilt binary stream via a permitted physical byte transport. The temporary diagnostic script is not committed to the project and is not an executable production algorithm.

**Known limits:** source must already be lexically admitted normalized eight-command bytes; it does not validate illegal bytes or Part 1 human-readable annotations, original source offsets or full source identity. Source count is per record and total source can exceed 255 bytes, but bracket nesting deeper than 255 fails. A mandatory `00 A5` terminal record is syntactically verified, while trusted *physical* host closure after it has **NOT** been independently implemented: extra bytes, including zero, require host rejection. Neither this custom diagnostic record format nor the provisional Boolean is a BFIO/BHIO production protocol or publication authority. No interpreter or Android output was generated in this slice.
