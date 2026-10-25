# Backward bracket lookup development slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status before the consolidated test batch: NOT RUN.

## Purpose and scope

Supply a Brainfuck authored reversal step and a mirrored bracket scanner so a caller holding a complete normalized source prefix ending at a closing bracket can find its matching opening bracket. The reversal is performed by Brainfuck and must not be delegated to the host in the claimed execution path. This is only a reusable query primitive, not an executable program counter or general interpreter. Keep the earlier forward scanner and both compilers unchanged.

## Inventoried slice files

- `src/reverse_normalized_source.bf`: consume a zero terminated, trusted command stream and emit all commands in reverse order.
- `src/general_backward_bracket_probe.bf`: consume a reversed prefix beginning with the closing bracket and compute the checked 16 bit relative matching opening bracket distance plus status.
- `fixtures/backward_bracket_slice/vectors.json`: inert test vectors and acceptance expectations.
- `docs/backward-bracket-slice-plan.md`: inventory, interface and test plan.
- `docs/backward-bracket-evidence.md` and `docs/backward-bracket-evidence.json`: post batch evidence.
- `docs/status.md` and `README.md`: milestone limitations and updated state.

## Interface and authority

A trusted complete source preflight must precede any invocation. Given a source prefix ending with a closing bracket, call the BF reverse component on that prefix plus the diagnostic zero sentinel. Feed its exact output bytes plus a zero sentinel into the BF backward probe. The probe must return a three byte record: two byte little endian relative matching distance and one status byte. Status `0` means success, `3` missing opening bracket, `10` checked distance or depth overflow and `13` wrong starting command. Failure must force the returned distance to zero. Neither component is allowed to turn missing OS read data into a success claim. Host test coordination may transport exact bytes but not reverse source or decide bracket semantics in place of BF.

This private diagnostic format is not a new COCK protocol or ABI. The probe uses a 16 bit offset and 8 bit depth, limitations of the temporary component only. The zero sentinel is not a complete file closure guarantee, and source input cannot contain a zero data byte.

## Acceptance tests frozen before execution

- Reverse exact command strings including empty, length one and long inputs; assert byte for byte equality.
- Fixed closing bracket vectors: `[]`, `[+]`, nested matching, missing opening, first byte not closing, and depth and relative distance overflows.
- Every closing bracket in the two real compiler command streams must yield the independently calculated matching opening position. Compare BF generated reversal and BF backward probe to the oracle, not only each other.
- Random valid balanced programs, truncated inputs, multiple closing brackets and boundary lengths at 255 and 256, 65535 and 65536 where executable within resource budget.
- Independently retest the earlier forward probe on selected fixed and compiler vectors.
- Audit all repository `.bf` files against the annotated source grammar and balanced brackets.
- Reproduce the six frozen raw AArch64 artifact bytes using the unchanged six cell kernel if the diagnostic executor resource envelope allows; report an unrun check rather than guessing.
- Distinguish unverified full host closure, input preflight, guest fuel, Android tests and same interpreter nested compilation. Never promote this component to a general loop executor.

## Draft test boundary

No acceptance tests execute until these first pass files and fixtures exist. Tests run as one bounded consolidated diagnostic batch, with failures repaired together and rerun before updating the evidence and archive.
