# Bounded compact AArch64 generator slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Stage A component, Android and production packaging deferred.

## Inventory fixed before test execution

- `src/mini_compiler_compact.bf`: distinct BF owned native arithmetic lowering with a single final byte normalization.
- `fixtures/compact-compiler-vectors.json`: inert fixed and negative-invocation vectors.
- `docs/compact-compiler-plan.md`: bounded slice and immutable acceptance expectations.
- `docs/compact-compiler-evidence.md`: populated after the consolidated diagnostic tests.
- `docs/compact-compiler-evidence.json`: machine-readable local diagnostic facts.
- `README.md` and `docs/status.md`: update after consolidated checks.

## Source and target interface

Consumes the **same previously admitted normalized raw arithmetic input** as `mini_compiler.bf`: ASCII plus and minus operations, followed by exactly one final output operation. Source transport is zero-at-EOF, so a trusted upstream length, exact closure and Brainfuck-authored annotated-source admission remain prerequisites; this generator does not implement preflight, cannot distinguish source NUL from EOF, and does not directly accept arbitrary annotated BF text. The emitted artifact is *raw* AArch64 little-endian instruction bytes, never ELF/APK or a fully conforming native function ABI. No application-specific foreign-language code.

Emission formula: MOVZ W0 with zero; one ADD W0 W0 one or SUB W0 W0 one for each arithmetic source command, in source order; one UBFM W0 W0 zero through seven to implement modulo 256; RET. This moves an existing byte reduction after each command to a single final reduction. The reduction is valid only for this loop-free and no-fuel subset where intermediate w0 values are not externally observable and AArch64 32-bit wrap commutes with final modulo 256. No pointer movement, loops, input, traps or intermediate observable effects are admitted. Do not activate it for guest instruction fuel.

Instruction byte goldens from the existing encoder and to be verified independently by system AArch64 assembler: init 00 00 80 52, plus 00 04 00 11, minus 00 04 00 51, final reduction 00 1C 00 53, return C0 03 5F D6. Total bytes equal twelve plus four times the arithmetic source-command count. This is a policy-specific alternative generator, **not** a posthoc transformation performed by a host script and **not** a replacement for frozen O0 candidates.

## Acceptance test batch

1. Independent exact native instruction-byte verification for all five word patterns.
2. Compile the three existing admitted source examples; compare bytes with separately computed fixed expected operation sequence and check sizes.
3. Compile mixed plus and minus, zero-result, modulo-256 wrap and nonzero input programs, after independent source preflight; compare simulated native returned low byte with direct BF semantic interpreter for at least hundreds of randomized admitted sources.
4. Execute the new compiler itself through the reference BF-in-BF interpreter and compare output with direct reference evaluation for three fixed examples. A separate bounded nested attempt may report timeout rather than acceptance.
5. Preserve old `mini_compiler.bf` and its frozen output hashes; rerun exact matches for existing candidates.
6. Audit all authored BF source files for legal comment grammar, no non-BF code bytes and bracket matching.
7. Measure wall time and instruction bytes, with source/host hashes and exact budget; never claim global speed or self-host gate completion.

An accepted result is only a component diagnostic; complete COCK source preflight, closure, nested full compiler self-interpretation, Android code entry, ELF/APK, and independent root qualification remain absent.
