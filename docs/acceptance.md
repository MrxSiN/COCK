# First development component inventory and acceptance vectors

Inventory frozen before first-pass BF source drafting:

- `src/mini_compiler.bf`: BF-authored raw AArch64 guest instruction generator.
- `src/bf_in_bf.bf`: initial small BF-authored evaluator of admitted arithmetic guest program, not yet capable of interpreting the compiler.
- `tests/oracle.bf`: separate BF-authored arithmetic oracle with distinct detection logic.
- `examples/tiny_app_a.bf`, `examples/tiny_app_b.bf`, `examples/held_out.bf`: annotated arithmetic programs.
- `fixtures/expected.json`: inert literal test expectations and known native instruction encodings.
- `README.md`, `docs/stage-a-decisions.md`, `docs/acceptance.md`, `docs/status.md`: inert documentation and evidence.

The source files are drafted together before opening component tests. No separate script, source-language generator or foreign-language test launcher is included in the repository.

## Declared vectors

| Input | Guest output | Native bytes | Verification |
|---|---|---|---|
| exactly 32 plus commands then one dot | `20` | 264 = 4 plus 32 x 8 plus 4 | compiler plus BF guest and independent oracle |
| exactly 33 plus commands then one dot | `21` | 272 | same |
| exactly 34 plus commands then one dot | `22` | 280 | held-out after draft |
| one minus followed by 33 plus then a dot | `20` | 280 | 8-bit wrapping subtract plus count |
| `+.` | `01` | 16 | independently check raw encoding |
| `-.` | `FF` | 16 | independently check byte truncate |
| `+x.` | rejects before guest effects | no output | future BF preflight **NOT IMPLEMENTED** |
| embedded `00` byte before `.` | rejects before guest effects | no output | future BF preflight **NOT IMPLEMENTED** |
| unmatched bracket | rejects before guest effects | no output | future BF preflight **NOT IMPLEMENTED** |
| BF compiler as guest of BF in BF | binary identity | exact matching compiler artifact | mandatory **NOT IMPLEMENTED** |
| outer BF in BF running inner BF in BF running compiler | binary identity | exact matching compiler artifact | mandatory **NOT IMPLEMENTED** |
| Android debug install and observed stdout/log | different printable bytes | BF native instructions | **NOT RUN** |

This is a component-level milestone, not Stage A acceptance. If independent original-code inspection or external BF evaluation is not available, record that explicitly. The first tested components cannot claim complete Stage A until all mandatory negatives, source and closure checks, selfhosting and device checks pass.
