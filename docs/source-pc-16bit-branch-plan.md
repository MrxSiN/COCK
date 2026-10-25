# Stage A sixteen bit next command and fuel slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Purpose:** add one Brainfuck-authored dispatch decision over an existing validated source index and matching bracket map. The component does not execute guest tape or I/O effects and does not replace the working six-cell interpreter.

## Frozen slice inventory

- `src/source_pc_16bit_fuel_branch.bf` is the only new executable file and is annotated original eight-command Brainfuck.
- `fixtures/source_pc_16bit_branch/*.input.bin` and `*.expected.bin` are inert exact-byte input/output fixtures.
- `docs/source-pc-16bit-branch-plan.md`, `docs/source-pc-16bit-branch-evidence.md`, and `.json` are inert documentation and independently collected diagnostics.
- The two mini compiler source files and six existing raw AArch64 binaries are read-only regression inputs.

## Record contract

The input begins with one byte of count `Q`. Each of the `Q` records has eight literal bytes, in this order: `opcode`, `pc_low`, `pc_high`, `matching_bracket_low`, `matching_bracket_high`, `current_cell_value`, `fuel_low`, `fuel_high`. Numeric fields are little-endian. Output contains exactly five bytes per record: `status`, `next_pc_low`, `next_pc_high`, `remaining_fuel_low`, `remaining_fuel_high`.

The caller must supply an already preflighted legal opcode and the actual matching bracket offset from the BF-authored bracket map. The component additionally rejects an invalid opcode as status 13 before charging fuel. With zero fuel it reports status 6 with an unchanged program counter. With fuel available it charges one original guest command, selects the original program counter or the matching bracket partner as its base, then increments by one. A zero cell at `[` skips to the first command after `]`; a nonzero cell at `]` resumes after matching `[`. Other commands or the other cell states advance sequentially. A next-command position beyond 65535 returns status 10 rather than wrapping silently. The result of a nonzero status is diagnostic only and **must not** authorize guest effects.

The entire transport is a development-only bounded record format. No length-closure guarantee or authenticated bracket pairing can be inferred from the frame, nor does it implement the `COCK-FRAME-v1` result authority. At most 255 decisions may be submitted per invocation; this is not a project source, feature or APK limit. The source index/fuel fields are sixteen-bit representations for this development slice.

## Acceptance vectors

- Empty batch and one-record batches covering every legal BF opcode, both `[` cell states, both `]` cell states, and correct next-PC selection.
- Exhaustive low-byte carry boundaries at 255 and 256, sixteen-bit position 65535 overflow, all fuel zero/borrow cases, fuel after consumption, and source-invalid versus fuel priority.
- Every `[` and `]` in the full original and compact mini compiler, using actual independently parsed bracket pairs, including nested bracket PC jumps; seeded randomized legal opcodes, cell bytes, positions and fuel values.
- Exact binary saved input/output fixture pairs, preservation of the six frozen compiler artifact byte hashes, and an audit of all annotated repository BF sources.
- Report false/missing bracket partner, absent input bytes, extra unread bytes, and unknown outer process closure as unsupported or independent-boundary defects; never count them as successful end-to-end execution.

**Batch order:** record the inventory and expected vectors before one consolidated execution batch. Local Brainfuck execution uses the externally installed diagnostic evaluator; the independently implemented conventional expected-results model is outside the repository and verification-only. No production foreign-language source enters the workspace.
