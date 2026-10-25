# Stage A sixteen bit PC and fuel branch decision evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Result: LOCAL DIAGNOSTIC PASS for the isolated BF decision component. This is not a completed compiler capable interpreter or nested self hosting proof.**

## New artifact and exact contract

`src/source_pc_16bit_fuel_branch.bf` has 4494 executable Brainfuck instructions and legal inert annotations. The only executable implementation deposited in the repository is original eight-command BF. For each development-only eight-byte input record, it returns a five-byte status, selected sixteen-bit next command position and remaining sixteen-bit original-command fuel.

The input is a one-byte record count, followed by each `opcode | u16 little endian PC | u16 little endian bracket partner | current cell | u16 little endian fuel`. The output for each record is `status | u16 little endian next PC | u16 little endian remaining fuel`. The branch decision for `[` with a zero cell advances to the instruction following its matched `]`. The decision for `]` with a nonzero cell advances to the first instruction following its matched `[`. Other cases advance to PC plus one. An invalid opcode yields diagnostic status 13 without fuel consumption; exhausted fuel yields status 6 and no advancement. A valid executed command consumes one fuel unit, even if next-PC overflow returns diagnostic status 10. The component does **not** implement tape operations, guest I/O, original annotated-source byte offsets, exact full BF trace state or a complete framed guest status authority.

## Executed local tests

| Verification | Result |
| --- | ---: |
| BF dispatch decision fixture batches | 23 of 23 passed |
| Individual decisions within those batches | 2557 of 2557 passed |
| Full original mini compiler source control flow | all 515 commands covered |
| Full compact compiler source control flow | all 452 commands covered |
| Bracket states across both compiler sources | 228 bracket state decisions covered |
| BF authored whole source bracket pairing against frozen expected output | both compiler sources passed |
| All six frozen AArch64 compiler artifacts, rerun with preserved compiler capable interpreter | 6 of 6 exact byte matches |
| Annotated repository Brainfuck file audit | 45 of 45 passed |

The decision suite includes all eight opcodes, zero/nonzero cell behavior at both bracket types, fuel zero and borrow cases, two byte PC carry at 255 and 256, overflow at 65535, invalid opcode precedence over fuel, and seeded randomized records. Input/output fixtures for the 23 batches reside in `fixtures/source_pc_16bit_branch/`. SHA-256 identities, raw evaluator observations and the six frozen artifact hashes are saved in the JSON evidence file.

Local command form for the compiled outside-repository diagnostic evaluator: `diag CODE inputfile outputfile limit`. For example, run `diag COCK/src/source_pc_16bit_fuel_branch.bf COCK/fixtures/source_pc_16bit_branch/bracket_states.input.bin actual.bin 20000000` and compare `actual.bin` to the corresponding `.expected.bin`. The executable is *not* part of the archive. An independently written model, used only for test expectations, was also outside the repository.

## Observed failures and acceptance boundaries

Three negative probes demonstrated that this component cannot be used as an authoritative parser or build dispatcher on its own.

1. A falsely supplied bracket partner produced an incorrect next PC while returning nominal success. The caller must use a validated **BF-authored** whole-source bracket map from the exact admitted source.
2. An incompletely supplied record was padded implicitly by the diagnostic executor's EOF-zero behavior. The BF response cannot establish a trusted eight-byte record count or host I/O completion.
3. Bytes after the last requested record were unread and did not prevent apparent success. External source and stream closure, exact actual byte count and successfully bound process exit must be separately observed.

No real combined fetch, pairing, fuel-dispatch and guest-tape execution authority is claimed. This is a checked **PC decision primitive** that still requires a properly integrated interpreter, dynamic guest tape, multiword budget state, full annotated-source validation and host-close evidence. The sixteen-bit widths and 255 decision batch count are implementation representation limits, not application-size policy limits. The external source layout aid used during drafting was not checked in; strict BF-only development-process provenance is **NOT CERTIFIED**.

## Preservation and next step

The original and compact mini compiler BF source files and the six frozen raw AArch64 artifacts remain unchanged. The tested new component selects the next command and charges fuel only; the existing six-cell preflight interpreter separately generated and exactly matched the six raw binaries. The next meaningful integration is to couple the BF-authored 16-bit source fetch and bracket map to this dispatch step **inside one BF-authored interpreter**, preserving source preflight and guest state. The full same-interpreter to same-interpreter to actual compiler proof remains **NOT VERIFIED**. Android SDK, emulator, APK and device execution remain **DEFERRED**.
