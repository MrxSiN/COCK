# Stage B source and execution contract draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Design only; integrated BF frontend and full oracle are NOT CREATED.** The locked `COCK` profile, `COCK-FRAME-v1`, `COCK-NATIVE-ENTRY-v1` and existing status numbers remain unchanged. This text does not establish a new public input/config version.

## Input authority and policy

Keep one immutable exact annotated `.bf` source per build. A mechanical host reports source byte count, successful read/close and stable snapshot identity; BF performs all grammar, semantics, code generation and stage decisions. Retain original bytes through preflight. Truncation, extra bytes, a mutable file, read failure, missing physical completion or contradictory closure facts prevent commit even if a guard/status is valid.

Stage B additionally needs a sealed binary **application input** snapshot and explicit runtime policy. Input bytes are arbitrary data and are not parsed as BF, frames or a source terminator. BF copies them unchanged into the generated ELF's read-only data and records their exact length. Empty input is valid. This first debug bridge supplies finite immutable invocation input; it does not offer interactive stdin, file-system access or network input to guest BF. Selecting raw input data changes artifact identity and never substitutes for generating instructions from the source.

Select a narrow **development-only sealed invocation record** for exactly one source and one binary input snapshot, keeping general multi-file manifest parsing in its separate later capability. This record is not BFIO/BHIO, `COCK-BUILD-INPUT-v1`, a revision of Stage A's record, or a shipped public protocol. Its distinct eight-byte marker prevents accidental grammar mixing. The mechanical host may encode selected non-executable scalar options/physical counts and copy sealed bytes; BF owns validation, semantics, compiler composition and all artifact framing. No host JSON parser/dependency selector is required or permitted for this narrow route.

| Offset | Width | Field |
| --- | ---: | --- |
| 0 | 8 | Literal draft marker `43 42 44 49 00 00 00 01` |
| 8 | 8 | Nonzero invocation ID |
| 16 | 8 | Actual sealed source byte count S |
| 24 | 8 | Actual sealed binary input byte count I |
| 32 | 8 | Configured source-byte budget |
| 40 | 8 | Configured input-byte budget |
| 48 | 8 | Configured normalized-command budget |
| 56 | 8 | Configured emitted-native-byte budget |
| 64 | 8 | Flags: bit 0 enables fuel, bit 1 enables logical maximum cells; all other bits zero |
| 72 | 8 | Fuel allowance; must be zero if disabled |
| 80 | 8 | Maximum logical cells; must be zero if disabled and at least one if enabled |
| 88 | S | Exact source bytes |
| 88+S | I | Exact binary input bytes |
| 88+S+I | 1 | Final literal `A5` guard |

All scalar fields are little-endian u64. Independently verify checked total `89+S+I`, both sealed snapshot counts/read-close facts and whole-record physical completion, then validate flags/marker/guard/budgets before source semantics. A guard does not prove physical EOF; appended bytes, failed close or unknown record completion veto success. Source and input may both be empty. No size field may wrap, truncate or serve as a source delimiter. False/truncated/trailing lengths are transport failures; unsupported marker is UNSUPPORTED_PROTOCOL; invalid flags/noncanonical disabled values are MALFORMED_FRAME; configured source/input/command/native limits are explicit resource failures with their proper phase, not syntax errors. A preflight non-source failure uses the all-ones offset.

`src/stage_b_input.bf` will implement admission and handoff; `tests/stage_b_input_check.bf` independently checks exact record/physical-fact binding. Neither exists. The standard multi-file protocol remains DESIGNED/UNSUPPORTED in this narrow build mode. Never describe this record or a host-assembled byte copy as a compliant production multi-file session. Before implementing a broader mode, inventory its BF assembler, host-I/O adapter, manifest parser and all standard session tests separately.

Per invocation record raw/command/native byte budgets, optional logical maximum cells, optional guest-command fuel, input length, compiler working-set/representation limits and independent root/process limits. Represent exposed counts, offsets, addresses and fuel as checked u64. A u16 prototype may only receive values after explicit capability checks; its format width is not a permanent language bound. There is no guessed usable root budget: actual final compiler BF size/tape expansion must fit the self-hosted interpreter, including both identical interpreter layers.

The proposed Android debug launcher requires explicit finite guest fuel because arbitrary loops are admitted. The abstract runtime may implement fuel disabled; that mode is an isolated worker-test capability and must never be the normal launcher policy until its separate cancellation/resource evidence passes. Reject a missing required finite Android launch budget as UNSUPPORTED_CAPABILITY, not INVALID_SOURCE_BYTE. Zero fuel is a valid configured value and must reach the runtime as enabled zero, not disabled. Empty source succeeds even with enabled zero fuel.

## Complete source admission

Run the whole lexical pass in increasing original-byte order before bracket matching. Accept blank lines, LF or CRLF, indentation with spaces/tabs, full-line printable ASCII `#` comments containing none of the eight BF glyphs, and code lines containing only commands/spaces/tabs. An unterminated final legal line is accepted. Reject bare CR, NUL, DEL, other controls, BOM/non-ASCII, inline comments, unsafe comments and prose on code lines at their first offending original byte. A bracket-looking character in an unsafe comment is a lexical error, never a command.

After lexical success, match every actual bracket. Report the first unmatched closing bracket. If none exists, report the earliest still-unmatched opening bracket. An earlier unmatched open cannot outrank a later illegal byte: the entire lexical pass has precedence. Reject before guest input consumption, guest cell changes, guest output or finalized native artifact. Physical input acquisition/closure must succeed before this semantic admission; do not invent an offset for an unread byte.

The decoded internal command record is 32 bytes: offset 0 u8 opcode, offsets 1–7 zero, offset 8 u64 original source-byte offset, offset 16 u64 partner command index or all-ones for a nonbracket, offset 24 u64 next command index. All integers are little endian. End-of-stream command index is `N`; no source command occupies that position. For paired brackets use the partner's command index, not its normalized-byte or native address. Both branch directions are range/pair checked. `next=index+1` is checked; keep N and source byte length separately. This is a proposed compiler-internal record, not a change to BFIO.

Source maps bind each native block and its helper-call failure sites to the same raw offset, opcode and source identity. Comments/whitespace execute no commands and consume no fuel. Retain raw source identity even when changed comments leave commands identical. Preflight success does not authorize staging a successful artifact if later lowering, layout, producer completion or physical closure fails.

## Execution order and terminal result

The independent reference order is: complete source admission; initialize pointer 0, logical cell count 1, zero-valued cells and all counters; at each next original command check cancellation at a declared safe boundary, then enabled fuel, then charge one executed command, then perform that command's checks/effects. A cancellation at that boundary consumes no command. Fuel insufficient for the next command returns GUEST_FUEL at that command's raw offset without changing its effects or count. A fuel-admitted command that then traps on its own pointer/budget/I/O check **does** count as executed.

`>` checks address increment overflow, logical cell limit and necessary physical growth before changing pointer. Successful movement makes cells 0 through the new address addressable and initialized. `<` at zero returns LEFT_BOUNDARY before pointer change. Arithmetic wraps modulo 256. `,` takes one input byte when available and increments consumed count; EOF writes zero and consumes no input. `.` emits exactly the current byte; only a completed physical one-byte write increments emitted count. An OS read/write error is distinct from EOF and may leave the current command counted but unsuccessful. Physical allocation timing is not promised identical across implementations.

`[` charges once when evaluated; zero skips to after its partner `]`, charging no skipped body/bracket. Nonzero enters the body. `]` charges when evaluated; nonzero resumes at the first command after its partner `[`, without charging `[` again. Empty nonzero `+[]` therefore repeatedly evaluates `]` until fuel/cancellation. Checked counter overflow returns CHECKED_INTEGER_OVERFLOW; it cannot silently wrap status or count fields.

Native result is exactly the unchanged 56-byte v1 header. Compare u32 return status with header status; source offset is the failing original command, or all-ones on success/non-source failures. Preserve counters, logical high-watermark and exact partial output on a runtime trap. Preflight failures have zero executed/input/output counts and no guest invocation. Output never carries control authority, including guest bytes that look like `BFIO`, `OK` or terminal status.

Cancellation and physical faults remain separately attributable. A native crash, process kill, missing worker return, unknown close result or missing status is FAILED/UNKNOWN completion, never an invented guest-fuel trap. Compiler guest fuel, application guest fuel, native runtime overhead, outer seed commands and OS wall timeout have distinct ledger fields.
