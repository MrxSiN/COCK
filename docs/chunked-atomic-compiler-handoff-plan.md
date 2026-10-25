# Chunked atomic compiler handoff slice

Status at inventory freeze: DRAFTING, no implementation test run.

## Goal and scope

A Brainfuck-authored source-admission and six-cell-loader-framing tool. Input is complete, previously acquired NORMALIZED source, transmitted as repeated one-byte-length chunks and a required final nonzero A5 guard. The BF tool validates all eight-command bytes and matching bracket pairs BEFORE it emits any guest source instruction. It emits status 01 followed by the six-cell loader's one-command chunks (01, command), then an 00 source-end byte. Rejections emit ONLY status 00. The exact stream boundaries and outer process exit still require independently observed physical host closure. These source-record bytes are not COCK-FRAME-v1 or COCK-HOST-IO-v1.

This slice does not implement Android, host I/O, annotated-source decoding, COCK guest fuel, six-cell runtime boundary traps or mandatory nested self-interpreter execution. A separate, admitted application input segment must be routed unchanged to the six-cell interpreter by an independently declared physical transport boundary. Status is consumed by a host checker, NEVER forwarded as guest input.

## Frozen file inventory

- `src/chunked_atomic_compiler_handoff.bf`: sole new executable source, checks entire source and produces held back loader bytes.
- `fixtures/chunked_atomic_compiler_handoff/vectors.json`: inert golden descriptions and negative fixture corpus, including both actual compilers and chunk crossings.
- `docs/chunked-atomic-compiler-handoff-evidence.md`, `.json`: actual post-draft outcomes, environment and hashes.
- `docs/status.md`, `README.md`: update only after tests.
- `COCK_Stage_A_Engineering_Workspace.zip`: refreshed only after test/evidence recording.

## Byte format

Input: `(u8 chunk_len=1..255, chunk_data[chunk_len])*`, then `u8 chunk_len=0`, then one `A5` guard byte. All inner lengths refer to exact bytes. Chunk lengths have no universal total source limit; the admitted alphabet has nonzero byte values. Cell-based bracket depth currently has a 255-depth limit; deeper valid input must fail or be explicitly unsupported rather than wrap and pass. Test zero-length source separately.

Output accepted: `01` status, then `(01, source_command_byte)*`, then final `00` source-terminator. Output rejected: a single `00` failure marker and no source. An outer host MUST enforce source packet actual byte count, no trailing extra bytes, successful producer exit and exact source identity; A5 cannot attest host closure.

## Planned fixed positive fixtures

- Exact empty stream; one arithmetic command; all eight legal glyphs in one balanced program; nested brackets spanning chunk boundaries.
- Both unchanged compiler sources, at 515 and 452 commands, split into chunks of 200 commands; 1-byte chunks; a 255-byte chunk.
- Valid sources of 255, 256 and 1024 commands, not imposing a total length ceiling.
- Real original and compact compiler execution after stripping the leading status and independently forwarding each of the three admitted application programs; frozen six byte-artifacts must match.

## Planned fixed negative fixtures

- NUL and non-BF `x`; forbidden suffix after valid prefix; unmatched close/open; invalid guard; missing final guard; mid-chunk truncation; extra bytes after a terminal guard (HOST CLOSURE NEGATIVE, not solvable from BF stdin alone); 256-level nesting (explicitly track unsupported behavior).
- Any invalid packet must not release an admitted source command.

## Acceptance

Run one coordinated batch of fixed-byte oracle vectors, bounded randomized valid and malformed sequences, raw compiler artifact regressions, and strict source purity audit. Preserve all prior six raw artifacts and both compilers exactly. Do not promote the component to production or claim full self-hosting on a diagnostic root execution alone.
