# Six cell Brainfuck interpreter with runtime guest fuel

**2026-10-24 — STANDALONE DIAGNOSTIC COMPONENT PASSED; STAGE A NOT ACCEPTED.**

## What was implemented

`src/bf_in_bf_six_cell_fuel.bf` is a new, independently runnable **eight-command Brainfuck executable** that interprets a restricted guest Brainfuck program as data. It dispatches all eight guest commands and uses a per-guest-original-command **execution fuel counter**. It charges `[` or `]` when executed, does not charge skipped source commands, charges a trapped pointer movement, and checks fuel *before* a command can alter guest state. Guest byte cells wrap modulo 256. It produces explicit fuel, left-boundary and rightward logical-budget diagnostic statuses, and buffers guest output with a counted partial-result contract.

The new interpreter is **not** a patch to the previously verified `bf_in_bf_six_cell.bf`. The old interpreter remains the only demonstrated BF-in-BF runner of the complete 515-/452-command real compilers. The fuel-aware prototype handles at most 32 source commands, six guest tape cells, 16 stdin bytes, 16 buffered stdout bytes and an unsigned one-byte fuel budget. These are **explicit provisional per-invocation engineering budgets**, not global COCK limits. It rejects excessive requests with status 13 rather than silently shortening work. A production implementation must be scalable and satisfy the complete source/ABI contracts.

The local development interface is `u8 fuel | u8 length | exact source bytes | A5 | u8 stdin length | exact data bytes | A5`. It requires an independently attested exact host byte count/closure. It does not implement `COCK-FRAME-v1`, `COCK-BUILD-INPUT-v1` or full Part 1 annotated source admission. Only original BF instruction byte values are admitted as guest source; syntax validation of the whole provided source, followed by bracket validation, precedes any guest effects.

Diagnostic output is `u8 status | u8 executed_original_commands | u8 output_count | u8 diagnostic_source_position | output bytes`. `FF` means the position is not applicable or unsupported by this diagnostic (including unmatched opening). This position is the **normalized guest command index**, not the original annotated-source byte offset. Diagnostic status numbers follow COCK's status vocabulary where applicable: 0 OK, 1 invalid byte, 2 unmatched open, 3 unmatched close, 4 left boundary, 5 logical budget, 6 fuel, 11 malformed record, 13 unsupported capacity. This four-byte header is **not** a normative BFIO result frame. A nonzero result may carry explicitly counted earlier output, never a false successful completion.

## Consolidated observed tests

| Verified diagnostic | Passing cases |
| --- | ---: |
| Fixed, 256 exhaustive binary-byte and 135 seeded randomized executions, plus malformed-transport negatives | **425 / 425** |
| Additional fuel-priority and error-offset vectors | **13 / 13** |
| Existing six frozen AArch64 code outputs through the preserved compiler-capable BF-in-BF interpreter | **6 / 6** |
| Repo BF-only syntax/annotation and bracket audits | **22 / 22** |

The final runtime-fuel diagnostic total is **438 / 438**. Seed `20261024`; full results, source digest, byte counts, individual test names, command-budget settings and timings are in `six-cell-fuel-evidence.json`. Literal request/expected-result bytes are retained under `fixtures/six_cell_fuel/`.

Representative exact result bytes (hex):

| Input | Guest fuel | Result hex | Explanation |
| --- | ---: | --- | --- |
| `[]` | 1 | `00 01 00 FF` | only opening bracket executed |
| `+[-]` | 3 | `06 03 00 03` | fuel exhausted before closing bracket |
| `++[-]` | 7 | `00 07 00 FF` | exact full-loop charge |
| `<>` | 1 | `04 01 00 00` | left boundary at source index zero |
| `>>>>>>` | 7 | `05 06 00 05` | sixth right move exceeds six-cell tape |
| `,.` with `FF` input | 2 | `00 02 01 FF FF` | arbitrary binary input/output preserved |
| invalid `+.x` | 0 | `01 00 00 02` | source error wins over zero guest fuel |
| `+[+]` | 5 | `06 05 00 03` | guest fuel stops an otherwise nonterminating loop |

One preliminary reference fixture expected the `+[+]` cutoff at source position 2; the actual next command is `]` at position 3. The **fixture**, not the interpreter, was corrected, and the case rerun successfully. A transport-offset diagnostic was also corrected so guard errors emit `FF` rather than misleading position zero, then the consolidated suite was executed against the revised source.

## External test boundary and cost

Tests used the temporarily compiled, outside-repository C Brainfuck evaluator `/tmp/cock_diag_exec` with 8-bit wrapping cells, EOF-zero input, bracket jumps and an **outer executable instruction limit of 1,800,000,000**. The 438 positive comparisons use an independently implemented outside-repository diagnostic reference, not an independently qualified COCK BF-only oracle. This evaluator and diagnostic harness are neither shipped nor checked into the repository. This is **not an independently certified standard root bootstrap**, not a qualified release test, and not evidence of BF-only development-process provenance; Python-assisted BF source layout was used outside the repository.

The prototype is intentionally not optimized. The BF interpreter source is approximately **3.88 MB** with **3,839,140 executable commands** and has substantial dispatch/validation overhead. This cost is a reason **not** to replace the smaller compiler-capable interpreter prematurely. It establishes semantic test vectors and checked failure behavior, not measured performance improvement.

## Still unimplemented

- No fuel, logical-boundary traps, or diagnostic status integration in the existing compiler-capable six-cell BF-in-BF interpreter.
- No full `COCK` dynamic tape, original annotated-source offset reporting, canonical result framing, secure host source/stream closure, cancellation, or arbitrary-length source/input/output support.
- No complete bounded **BF-in-BF → inner BF-in-BF → actual mini compiler** proof; the current fuel-aware component cannot host either complete compiler.
- No ELF, APK, `NativeActivity` callback, emulator/device execution or signed app proof. Android testing is deferred.

**Next integration action:** move the independently tested fuel/trap semantics into a redesigned scalable interpreter that still runs the complete original/compact compiler and supports one bounded nested self-hosting level. Preserve the previously verified six raw machine-code candidates during that work.
