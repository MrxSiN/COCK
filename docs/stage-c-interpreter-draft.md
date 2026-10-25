# Stage C interpreter, source and resource contract draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Design only.** Preserve the locked `COCK` semantics and all existing public wire/ABI identifiers. Extend an accepted Stage A interpreter rather than declaring the current failed candidate accepted.

## Source and internal records

Accept one exact immutable annotated source and raw binary guest input with independently established counts/read/close facts. Use the following distinct **narrow development invocation**, not an extension of the old u16 prototype, Stage B marker or a public BFIO/BHIO grammar: bytes 0–7 marker `43 43 49 4E 00 00 00 01`; u64 little-endian fields at 8 invocation ID, 16 source size S, 24 input size I, 32 source-byte budget, 40 input-byte budget, 48 decoded-command budget, 56 flags, 64 fuel, 72 maximum cells; exact source begins at 80, exact input at 80+S, final A5 at 80+S+I. Checked total is **81+S+I**. Invocation ID is nonzero. Flag bit 0 enables fuel, bit 1 enables maximum cells; other bits are zero, disabled values must be zero, enabled maximum cells at least one. Enabled zero fuel is valid. Source/input/command budget excess is an explicit resource failure, not invalid syntax. No parser is implemented.

The mechanical host supplies selected scalar options, truthful counts/closure facts and exact sealed byte copies; BF owns validation/decoding/execution/status. Require independent whole-record/source/input physical completion before semantic admission. Reject marker/flag/guard/length/overflow/truncation/appended-byte/count/identity disagreement and unknown close; A5 does not authenticate EOF. This debug invocation does not claim general multi-file session support. A production build-module caller must use its separately verified existing handoff with explicit adapter/identity checks, never assume the diagnostic grammar automatically describes it.

Run complete lexical validation in increasing original-byte order, then complete bracket validation, before effects. Legal full-line safe comments and whitespace consume zero commands. Illegal suffixes outrank earlier unmatched brackets; first unmatched close wins, otherwise earliest still-unmatched open. Preserve zero-based u64 raw offsets and exact raw source identity. Embedded NUL is invalid source, never an end marker; input NUL is ordinary data.

Proposed decoded records reuse the Stage B **documented internal** 32-byte shape: opcode at 0, seven zero bytes, u64 raw offset at 8, u64 partner command index at 16 (all-ones for nonbrackets), u64 next command index at 24. Code-only internal records do not replace original bytes/maps. Record count N has distinct terminal PC N. Pair maps must be in range, reciprocal and opcode-compatible; corrupted records are invalid internal state, not evidence the source was malformed. Guest source cannot overwrite decoder records.

Precomputed maps are an I2 candidate; the independent oracle instead searches brackets directionally. Keep the accepted I1 route available. Measure decode cost before claiming a faster end-to-end interpreter. No clear/transfer-loop shortcut, command fusion or dead-command deletion is in initial C O0.

## Separate guest addresses from outer storage

Guest pointer, logical high-watermark, values, input cursor, PC/fuel, decoded source and framing counters occupy disjoint owned regions on the outer tape. Document every region's anchors, lengths, growth direction and checked address translation in the actual BF source. Dynamic allocation on an ordinary BF tape is BF-authored movement/encoding, not a hidden allocator opcode. The external seed's maximum accessible tape and physical failure reporting are explicit outer constraints.

Proposed guest records have eight outer cells: byte value at 0, addressable marker at 1 and six zero-owned scratch cells at 2–7. Source records use the separate 32-byte layout above; buffered input records use value/occupied cells so binary zero is not a terminator. Put all finite metadata/source/input regions before the guest region, which grows rightward. Exact metadata anchors, scratch reuse, wide-counter operations and separators must be reconciled in the complete annotated BF implementation and its paper working-set calculation before source freeze; never silently increase a stride after testing begins. These are proposed outer-tape layouts, not claims of implemented allocation.

No universal tiny guest-cell/source cap is introduced. A finite outer representation can explicitly reject an unrepresentable invocation; it cannot wrap, overwrite source/status cells or call outer termination a guest budget trap. Current 16-cell/u16 candidate assumptions do not establish feasibility of this expansion or of two nested copies.

Movement right makes cells 0 through the new address logically addressable. Check address+1 overflow, configured maximum cells and physical backing separately; on failure pointer/high-watermark remain unchanged. Zero new cells before exposure; moving back preserves values. Left at zero traps before changing pointer. Logical count starts at one even if backing is lazy. `+`/`-` wrap bytes; comma consumes one real byte or writes EOF zero without incrementing consumed count. A source/input transport error is never EOF. Dot emits exact byte values; raw output and trusted status remain separate.

## PC, fuel and completion

Check cancellation at a declared safe boundary, then enabled guest fuel before each next original command. Charge one admitted command even if its own pointer/budget check then traps; insufficient fuel charges none and performs no effects. A zero `[` jumps after its paired `]` without charging skipped commands. A nonzero `]` resumes immediately after the paired `[`, never charging that opening bracket again. Counters and source offsets are checked u64 at the semantic boundary; unsupported internal width must be rejected before narrowing.

Keep exact partial guest output on runtime failure with an independent terminal result and error-producing original offset. Success/non-source errors use the all-ones offset. Use the frozen status vocabulary; count guest work separately from interpreter/outer/root commands and OS time. The Stage B 96-byte **internal test trace** may be adopted only with explicitly matching serialized expectations and independent decoder; it is not a new public frame or guest instruction.

Outer→inner execution gets independent source, guest tape, input cursor, fuel and status authority. The exact same interpreter bytes must execute inside themselves and then execute the actual real compiler; direct root execution is a diagnostic comparison. Compare the entire actual compiler artifact and all required completion statuses plus process/stream closure. A serializer equality, fixed ELF probe, short output prefix or toy guest cannot replace this proof.

Root memory/wall faults, unknown physical close, truncated output and missing result are outer FAILED/UNKNOWN, never invented GUEST_FUEL or successful guest termination. BF output bytes resembling `BFIO`/`BHIO`/OK have no host control authority. Buffered external seed output does not prove full-duplex host I/O; Stage E router capabilities stay separate.

## Optional sharing decision

Share only independently accepted production frontend/record definitions when the same grammar/offset/status semantics are demonstrated and actual source/working-set costs improve or responsibilities become simpler. Keep the reference oracle algorithm independent. Do not force the interpreter, AOT emitter and Android runtime into one implementation or cache dependency. Record size/startup/runtime/memory changes and rerun all affected Stage A/B/C source/fuel/nesting checks. On regression retain the accepted path; no measured benefit means no sharing requirement.
