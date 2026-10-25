# Bounded arithmetic guest fuel executor evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Date:** 2026-10-24. **Status:** LOCAL DIAGNOSTIC COMPONENT PASSED; STAGE A NOT ACCEPTED.

## New component

`src/bounded_arithmetic_fuel_executor.bf` is an annotated eight-command Brainfuck executable. It executes the restricted single-cell arithmetic guest profile using explicit instruction fuel rather than merely filtering a static source. It consumes an unsigned one-byte fuel value followed by repeated `(command byte, A5 guard)` records and a terminating `(00, A5)` record. This is a temporary diagnostic record grammar, not `COCK-FRAME-v1` or `COCK-BUILD-INPUT-v1`. The physically trusted host must independently attest complete bytes and closure. The supported admitted language consists of `+` and `-` arithmetic commands and one final `.` output command; there are no guest loops, pointer travel or guest input operations. The arithmetic cell wraps modulo 256. The diagnostic can produce binary zero and FF, but **printable-only Stage A application admission remains the responsibility of the separate source gate**.

The executor checks that sufficient guest fuel remains **before** carrying out each admitted original command, including the final output command. Its output is *one diagnostic status byte*, plus *one actual guest output byte* only upon success: `00` success, `06` insufficient guest fuel, `0B` malformed record guard and `0D` unsupported operation or malformed restricted command sequence. This is **not** the normative framed status format, nor the full COCK status/phase/source-offset contract. On the accepted subset, all commands are charged one fuel unit. A fuel trap has no guest output byte.

The current fuel field is only 8-bit (zero to 255). It is a bounded development interface, **not** an application-source or resource-policy cap; multi-byte budgets must be implemented before this is used for larger execution workloads. Guest-code source may have more than 255 commands but cannot finish within this fuel field. Source bytes and frame guards still require a separate preflight with independently checked source length and closure.

## Diagnostics run

- **1,279 / 1,279** exact-output cases passed under `/tmp/cock_bf_diag`, a local outside-repository diagnostic evaluator not independently qualified as a root BF executor. The suite contains 17 fixed guest cases, 3 damaged-guard cases, 256 per-byte arithmetic cases, 800 seeded randomized arithmetic programs, 200 seeded malformed-source programs and 3 additional truncated/EOF records. The seed is 20261024.
- **6 / 6** unchanged historical raw AArch64 artifact regression checks passed when the *separate, preserved* six-cell BF-in-BF kernel ran both existing mini compiler variants over the three application fixtures. This regression only protects prior outputs; it does not demonstrate integration of the new fuel executor into that compiler path.
- **21 / 21** repository `.bf` source files passed a static annotation character and bracket audit; this is not a host-qualified BF-authored source preflight.
- The new executable contains **6,356** BF commands and **7,444** source bytes; its SHA256 is `4ecf8c43b1f83d6ae34f0450c41592e1ee228350ccfa7ec997f273956fe68b40`.

## Representative exact-byte tests

| Scenario | Input source | Fuel | Output bytes |
| --- | --- | ---: | --- |
| Empty guest output value | `.` | 1 | `00 00` |
| Zero fuel on the output command | `.` | 0 | `06` |
| Trap before final output command | `+.` | 1 | `06` |
| Complete arithmetic execution | `+.` | 2 | `00 01` |
| 8-bit wrapping underflow | `-.` | 2 | `00 FF` |
| Last admitted command within fuel budget | 254 plus commands then output | 255 | `00 FE` |
| One instruction too many | 255 plus commands then output | 255 | `06` |
| Unsupported pointer movement | `>.` | 2 | `0D` |
| Wrong completion guard | `+.` | 5 | `0B` |

In this table `00 01` means diagnostic success `00`, then the *literal guest byte* `01`. Invalid programs are never claimed to have executed under full COCK semantics.

## Observed unsatisfied requirements

1. **Full-source preflight ordering is not implemented inside this executable.** Deliberately malformed source `+X.` at fuel 0 yields a fuel status `06` before reaching `X`; under COCK's complete-input source preflight, the illegal source byte must be detected and reported *before guest fuel is considered*. Therefore the new component **MUST NOT** receive untrusted, unchecked source. It is usable only behind the complete-source BF preflight gate when that authority is independently completed.
2. **Independent stream closure is missing.** A valid `+.` source with trailing `FF` after its terminal record was accepted and returned `00 01`. This is a negative boundary demonstration, not a successful closure test. Actual byte count and exact end-of-stream must be enforced outside this BF diagnostic and combined with BF-authored semantic validation.
3. This is a restricted single-cell *execution substrate*, **not a replacement for** `src/bf_in_bf_six_cell.bf`. It does not execute either full 515-command or 452-command mini compiler, track original source offsets, return a full trace, support guest loops or dynamic tape, or provide exact fuel in the existing compiler execution path. Actual six-cell runtime boundary and logical-budget traps remain unimplemented. Bounded full nested interpreter-to-compiler execution is still not verified.
4. Source drafting used a temporary outside-repository Python BF-layout emitter and independent diagnostics. No foreign source was added to the repository and only BF commands execute in the new module, but the stricter BF-only production/development authorship requirement remains **not certified**.
5. No Android SDK, emulator, ELF, APK, installation, signing, or device trial occurred. Those activities remain deferred by user request.

## Reproduction

From the repository root, use an independently provisioned binary-safe BF evaluator with sufficiently large execution budget to execute `src/bounded_arithmetic_fuel_executor.bf` against `.input.bin` records in `fixtures/bounded_arithmetic_fuel/`; compare exact stdout bytes to the corresponding `.expected.bin` file. Diagnostic output status is not a substitute for a completed process/transport closure check. The full machine-readable summary is `docs/bounded-arithmetic-fuel-evidence.json`. The original frozen raw code artifacts are in `artifacts/`.

**Next required implementation:** integrate fuel checks at the six-cell BF-in-BF guest dispatch boundary while preserving guest instruction offset/loop semantics, or introduce a demonstrably equivalent COCK-authored executor. Then verify both complete-source precedence and bounded nested self-interpretation using the real compiler. 
