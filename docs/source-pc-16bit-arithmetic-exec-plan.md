# Sixteen bit retained source arithmetic execution slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


## Bounded first draft inventory

Executable repository source: `src/source_pc_16bit_arithmetic_exec.bf` only.
Inert fixtures: `fixtures/source_pc_16bit_arithmetic_exec/*.input.bin` and `.expected.bin`.
Evidence: `docs/source-pc-16bit-arithmetic-exec-evidence.md` and `.json`.
Leave the prior two compilers, their six frozen raw AArch64 artifacts, and all older interpreters unchanged.

## Development only input and output

Request: `u16le source_length | u16le guest_fuel | source_length exact normalized source bytes`.
Only `+`, `-`, `.` guest opcodes are supported. Preflight checks all retained source bytes before the first guest instruction. On success emit guest `.` bytes followed by one trailing `00` diagnostic status. On rejected source emit `0D` (unsupported) with no guest output. On fuel violation emit already generated guest bytes followed by `06`. This trailing unframed status is *not* COCK-FRAME-v1 and is *not* a trustworthy production completion result.

Source length and fuel are representation-bounded at 65,535 each, independently; empty source with zero fuel is permitted. Exact request byte count and physical stream closure must be established by an independent host boundary. Missing bytes may be read as zero and recognized as illegal source, but extra bytes after the declared length are not detected internally. No app-specific code is authored outside annotated eight-command Brainfuck source. Diagnostic drafting and independent test tooling, when used, are outside the repository and do not establish pure-BF *development process* provenance.

## Acceptance vectors frozen before implementation

- Empty source with zero fuel is success with one status byte.
- `+.` with fuel two emits `01 00`; fuel one returns `06` without guest output; fuel zero also returns `06` without guest output.
- `+.-.` with fuel four emits `01 00 00`; fuel two emits partial output then status `06`.
- `+X.` emits rejection `0D` with no earlier output; a NUL in the source is rejected before execution.
- 255 / 256 / 515 / 65,535 source-length boundaries, including wraparound of the byte cell and 16-bit fuel carry/borrow.
- Randomized finite arithmetic sources differential against a separately authored diagnostic reference; program records must retain original commands and not choose output by source ID.
- Recheck six frozen compiler artifacts under the existing independently passing interpreter, not by claiming the new restricted interpreter can execute those compilers.

## Nonpromotion criteria

No bracketed loops, guest `,`, guest pointer travel, original annotated byte offsets, authenticated bracket map, trusted host closure, BFIO/BHIO result authority, Android ELF/APK or same-interpreter nested mini compiler. Any one of these omissions blocks full Stage A acceptance.
