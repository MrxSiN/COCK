# COCK nested arithmetic interpreter diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


## Result

- Nested BF in BF interpreter cases: **13/13 PASSED**.
- Original and compact compiler single layer raw artifact regressions: **6/6 PASSED**.
- Repository BF annotation grammar and bracket audit: **23/23 PASSED**.
- Two deliberately malformed source counterexamples still execute successfully and are **KNOWN FAILURES** of absent trusted source preflight; neither counts as an acceptance pass.

## Actual execution chain

The BF authored `tests/nested_arithmetic_driver.bf` emits the exact normalized command bytes of `src/bf_in_bf.bf` as one 103-byte guest-source record, a zero chunk terminator, and then forwards admitted arithmetic source input bytes. The diagnostic root BF executor runs this BF source and captures its output unchanged. The same diagnostic root then starts `src/bf_in_bf_six_cell.bf` on that captured raw byte stream; the six-cell interpreter executes `src/bf_in_bf.bf` as a guest, which executes the arithmetic program and emits one byte. The driver output was independently compared to exact source bytes, not assumed correct.

This nested chain uses **two COCK-owned interpreter sources** but they are *different interpreters*. It is not `six_cell -> six_cell -> mini_compiler`, and no fully nested AArch64 compile or Android claim follows.

## Exact nested output observations

| Guest input | Expected byte | Actual byte | Outer root BF commands | Result |
|---|---:|---:|---:|---|
| `empty` | `0x00` | `0x00` | 2,197,467 | PASS |
| `minus_one` | `0xFF` | `0xFF` | 6,075,300 | PASS |
| `one` | `0x01` | `0x01` | 23,419,918 | PASS |
| `two` | `0x02` | `0x02` | 44,667,002 | PASS |
| `cancel_three` | `0x00` | `0x00` | 72,505,506 | PASS |
| `cancel_two` | `0x00` | `0x00` | 59,817,404 | PASS |
| `net_three` | `0x03` | `0x03` | 112,775,138 | PASS |
| `cancel_four` | `0x00` | `0x00` | 96,015,358 | PASS |
| `minus_five` | `0xFB` | `0xFB` | 20,578,860 | PASS |
| `ten` | `0x0A` | `0x0A` | 215,813,962 | PASS |
| `mixed_one` | `0x01` | `0x01` | 147,129,452 | PASS |
| `space` | `0x20` | `0x20` | 697,195,742 | PASS |
| `letter_a` | `0x41` | `0x41` | 1,448,769,422 | PASS |

## Frozen compiler candidates remain unchanged

| Compiler | Input application | Bytes | SHA256 |
|---|---|---:|---|
| original | `tiny_app_a` | 264 | `04008592e9c873d3e8e9eaebeaed4000c55c85e78ff1bce5d2006c03b43365d3` |
| original | `tiny_app_b` | 272 | `860d6f0bd7df32d0e93fc50268c25180ef2694b1df3f32c68fdbd23cb2d31624` |
| original | `held_out` | 280 | `bbe379ca1beca74c941aebf057be95facc470a46b06f72933e05f9488c2de9c8` |
| compact | `tiny_app_a` | 140 | `2a252722e1679156d109c8994f0fd0e9eb2f211a68e1f444c5a631ac9529601f` |
| compact | `tiny_app_b` | 144 | `36af586b0929f05ef8bff362928d9e61ad494fe89a72eb2f2a88e902d845fbe6` |
| compact | `held_out` | 148 | `76ae6e5ba3a154be3af547a0b8fc0d84b032188d86009f56da98ebe95e5fc12a` |

## Observed safety counterexamples

These tests are **negative evidence**, not passes. The raw driver and nested interpreter have no complete-source validation before execution.

| Input bytes | Observed | Required safe behavior |
|---|---|---|
| `embedded_nul_and_suffix` (`2b2e002d`) | exit `0`, output `0x01` | Reject source before executing any guest operation |
| `invalid_unmatched_open_suffix` (`2b2e5b`) | exit `0`, output `0x01` | Reject source before executing any guest operation |

## Reproduction and resource accounting

From within the repository root, using an **outside-repository diagnostic-only** evaluator with the measured 8-bit wrapping, EOF-zero and growing outer tape behavior:

```text
/tmp/cock_diag_root tests/nested_arithmetic_driver.bf 1000000 < fixtures/nested_arithmetic/letter_a.input.bin > /tmp/cock-nested-request.bin
/tmp/cock_diag_root src/bf_in_bf_six_cell.bf 2100000000 < /tmp/cock-nested-request.bin > /tmp/cock-nested-output.bin
```

The expected final byte for `letter_a` is `41` hex. The root operation count for this case was **1,448,769,422**; this is **outer evaluator BF command count**, not the inner guest instruction count. Across the 13 nested cases, the maximum observed root command count was 1,448,769,422. This test batch is a diagnostic, not an independently qualified bootstrap or target runtime benchmark.

The complete local batch, including the six unchanged compiler candidate regressions, used 13.186 seconds of observed elapsed wall time on this local container. This is not a cold/warm performance baseline and is not comparable to the previous different hosts.

## Boundaries and unverified requirements

- `tests/nested_arithmetic_driver.bf` assumes independently admitted ASCII arithmetic input, and its raw relay terminates on physical EOF or a zero byte. It is **not binary-safe exact-source preflight** or a BFIO/BHIO transport authority.
- Its literal BF guest program is the short initial COCK arithmetic interpreter, not another copy of the six-cell interpreter. The full nested self-compiler requirement remains **NOT RUN / NOT VERIFIED**.
- Six-cell guest tape traps, full fuel and original source offsets, source-read/stream closure, and Android ELF/APK remain unimplemented or unsupported in this chain.
- The diagnostic evaluator was locally built from C source **outside** the COCK repository to inspect BF execution. It is not qualified as the externally installed independent root bootstrap. C/Python source, wrapper scripts and compiled executables were **not** included in the repository.
- An outside-repository Python aid generated the repetitive BF source-emission passage and inert fixtures. The emitted repository executable source is annotated eight-command BF, but strict BF-only drafting-process provenance is **not certified**.
- No code or artifacts of the original and compact mini compilers or the six-cell interpreter were modified for this slice.

## Test artifact inventory

- `tests/nested_arithmetic_driver.bf`: BF-authored nested input driver.
- `fixtures/nested_arithmetic/vectors.json`: source input identities and expected result bytes.
- `fixtures/nested_arithmetic/*.input.bin` and `*.expected.bin`: 13 literal source/result pairs.
- `docs/nested-arithmetic-evidence.json`: per-case actual results, step counts, SHA256, known negative counterexamples and audit results.
- `docs/nested-arithmetic-slice-plan.md`: frozen pre-draft interface/acceptance plan.
