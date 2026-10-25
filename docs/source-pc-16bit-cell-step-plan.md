# Stage A combined sixteen bit dispatch and arithmetic step slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


## Purpose and bounded acceptance contract

This slice extends the existing BF authored sixteen bit control flow and fuel decision with guest cell arithmetic for the two operations `+` and `-`. It preserves all existing control flow and fuel rules. It is still NOT a full interpreter and does not claim full compiler execution.

## File inventory

- `src/source_pc_16bit_cell_step.bf` is the single added executable source, written in original eight command BF with valid full line annotations.
- `fixtures/source_pc_16bit_cell_step/` stores literal binary input and expected output fixture files with no executable content.
- `docs/source-pc-16bit-cell-step-plan.md`, `docs/source-pc-16bit-cell-step-evidence.md` and `.json` are inert planning and measured evidence.
- Earlier branch primitive, source-fetch primitive, compiler source, and six frozen AArch64 binaries remain unmodified.

## Exact development only record contract

Input begins with one byte count Q, then Q eight byte records: opcode, u16 PC, u16 bracket partner, guest cell byte, u16 fuel, exactly as `source_pc_16bit_fuel_branch.bf`. The result is six bytes per record: `status, u16 next_pc, u16 remaining_fuel, guest_cell_after`. All numeric fields are little endian.

The BF component updates the supplied cell byte by exactly one modulo 256 for executed `+` and `-`, respectively. All other supplied opcodes leave it unchanged. Invalid opcode, exhausted fuel and checked PC overflow leave guest cell unchanged. Branches preserve Part 2.2 nonzero closing semantics, one source command of fuel, and zero cell opening skip semantics. Every decision is independent; this component does NOT keep a tape across records, execute `,` or `.`, validate a bracket partner against actual source or authenticate stream closure. Only a verified caller may supply each input record.

## Frozen acceptance vectors

- All eight guest opcodes and both bracket cell conditions, including corner cases with no fuel, plus invalid opcode.
- Exhaustive 256 existing guest cell values for both + and -, with modulo wrapping.
- Two byte fuel and PC carry, underflow, and 65535 overflow; no arithmetic effect on any nonzero status.
- All source opcode/control flow positions in each original and compact compiler, and seeded randomized records.
- Byte exact retained branch baseline for first five output bytes on all admitted inputs; all six frozen AArch64 raw binaries remain identical through unchanged compiler interpreter.
- Tests of truncated records, false partners and trailing bytes recorded as missing physical transport authority, not passed security validation.

Batch policy: first complete the source and inert fixtures without implementation testing, then run one consolidated suite. An externally compiled BF evaluator and a conventional independent model are only development diagnostics outside the project repository. Neither is production code.
