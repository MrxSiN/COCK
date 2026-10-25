# Whole source bracket pairing evidence

**2026-10-24 — Local diagnostic passed, Stage A NOT ACCEPTED. Android deferred.**

## Implementation

`src/whole_source_bracket_pairs.bf` is an annotated eight-command BF tool. It reads one already validated normalized command stream with a zero terminal marker, maintains a dynamically located BF-only stack of opening-bracket command positions, and emits each matching pair on encountering a closing bracket. Records are **four bytes per pair**: `u16 open command position`, `u16 close command position`, both little endian and zero based. One final diagnostic status follows: `00` complete, `02` unmatched opening bracket, `03` unmatched closing bracket, `0A` command-position overflow.

The implementation uses sixteen outer tape cells for each live bracket stack frame, with a mobile BF instruction-pointer loop. It avoids external per-bracket prefix selection and source reversal. No conventional executable source is included in the repository.

## Measured local results

| Check | Result |
| --- | ---: |
| Fixed reference vectors | 9 / 9 |
| Real BF source files including both compilers | 5 / 5 |
| Seeded valid generated programs | 400 / 400 |
| Seeded arbitrary normalized sequences | 80 / 80 |
| Source length and checked sixteen bit position boundaries | 8 / 8 |
| Distant opening and closing bracket pairs | 4 / 4 |
| **Bracket emitter total** | **506 / 506** |
| Existing original and compact compiler raw code | **6 / 6 unchanged** |
| Repository annotated BF syntax and bracket audit | **33 / 33** |

The original BF mini compiler has **515 commands with 30 matched pairs**; the compact mini compiler has **452 commands with 27 matched pairs**. Both complete streams were processed in single invocations and every emitted pairing was independently checked. The included binary fixture directory preserves input and expected output bytes for these and other representative programs.

The checked representation accepted **65,535 commands** in a single normalized input but returned status `0A` for a 65,536-command sequence. This is a component format limit, not a universal COCK source or app-size policy. The active BF source plus frozen compiler candidates were tested using a locally compiled outside-repository diagnostic evaluator, not an independently certified root bootstrap.

## Defects found and repaired

The consolidated run initially revealed a nesting-condition scratch-cell collision. A later test found a stale opcode retained when a popped stack frame was reused by a following loop. Both defects were fixed in the BF source, and the **entire 506-case batch passed on the revised code**. No originally observed failures were counted as passing without rerun.

## Open safety and self hosting gates

- The zero terminal byte is an experimental diagnostic convention, **not** trusted stream closure. A nonzero byte appended after the marker is ignored. A source `X` is also silently treated as a non-bracket byte. Two independent negative probes exposed those acceptance failures.
- The component expects BF-authored normalized-source preflight and independent exact-byte host read and pipe closure. It does not validate raw annotated comments, original source byte offsets, or the frozen `BFIO` transport.
- The emitted pairs are **provisional until successful full-source admission and verified producer completion**. A later malformed bracket can follow already emitted pair bytes. This tool must not authorize publication or guest execution by itself.
- It does not execute guests or implement dynamic guest tape dispatch, original-command fuel, deterministic trap precedence, or the mandatory **same COCK interpreter → same COCK interpreter → actual mini compiler** proof.
- An external Python drafting aid was used outside the repository to assemble repetitive BF instructions; external C evaluated the emitted BF and an independent Python model computed comparison results. No foreign-language executable source was added to the project, but strict development-process BF-only provenance remains **uncertified**.
- Android tooling and device tests remain deferred, without any APK signing or loading claim.

## Reproduce

With a compatible external standard BF executor providing binary I/O and a sufficient outer instruction allowance, run `src/whole_source_bracket_pairs.bf` with the exact bytes in `fixtures/whole_source_bracket_pairs/original_compiler.input.bin` and compare its raw stdout against `original_compiler.expected.bin`. Perform the same check for the compact compiler. Treat the final status as diagnostic data; authoritative completion still requires independent process and stream-close facts.

Machine-readable individual results, exact SHA256 identities and the negative observations are in `docs/whole-source-bracket-evidence.json`.
