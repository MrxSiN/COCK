# Dynamic right growing tape with restricted clearing loop

**Status: LOCAL DIAGNOSTIC PASSED / STAGE A NOT ACCEPTED.** Android remains deferred. This milestone is deliberately narrower than a general Brainfuck loop interpreter.

## Implementation

`src/bf_in_bf_dynamic_clear_loop.bf` is an annotated eight-command BF program derived from the preserved linear dynamic-tape candidate. It retains the twelve-outer-cell guest-tape record and the right-growing storage behavior. For the first time in this dynamic-tape branch, it recognizes and executes a real BF loop **only if the guest source contains the exact adjacent three-command sequence `[-]`**. A nonzero eight-bit cell is cleared through the BF loop at that guest address, and an initially zero cell skips the body. Immediately following guest commands continue at the original guest cell. Unsupported `[` forms, stray `]`, and comma input return the diagnostic `0D` status. The origin-left trap remains `04`, and successful guest execution finishes with `00`.

The implementation has **1,155 executable BF commands**, 3,961 raw source bytes, and SHA-256 `f769ba84aebef0014c3550cf74130f2cbda0d7145d1d6d4b37d029167d0a53fc`. The original 801-command `bf_in_bf_dynamic_linear.bf` remains unchanged and available for regression.

## Consolidated diagnostics

- **14/14** declared exact-byte fixture cases passed, including zero-iteration and multiple-iteration loops, negative/wrapping values, repeated clearing, loop execution on a secondary cell, unsupported syntax, truncated loop lookahead and left-of-zero trap.
- **510/510** additional seeded differential runs passed against an independent outside-repository reference model. The set contains 500 finite randomized programs combining linear instructions and clearing loops, five address-growth cases at 6, 257, 300, 1000 and **7200**, and five negative probes. Seed used: `20261024`.
- **6/6** frozen original/compact AArch64 raw compiler outputs were independently rerun through the **unchanged** six-cell compiler-capable BF-in-BF kernel and matched frozen files byte for byte. This is a preservation regression and does not imply that the dynamic clear-loop interpreter runs either compiler.
- **28/28** repository `.bf` source files passed a static audit of the line-level safe-annotation grammar and balanced command brackets.
- The 510 additional guest cases used 212,353,499 outer Brainfuck commands reported by the diagnostic executable, in aggregate. These are outer execution counts, not source guest fuel or a device performance measurement.

The diagnostic root was `/tmp/cock_diag_new`, a locally built C evaluator outside the repository. The independent comparison model and test coordinator ran outside the repository. They do **not** constitute the qualified standard external bootstrap, nor satisfy the stronger BF-only development-process authorship criterion. No non-BF executable source was added to the repository.

## Known negative evidence and exact boundary

- Source bytes `2B 00 2E` (plus, embedded NUL, output) yield status `00` from this diagnostic interpreter. The forbidden source NUL is incorrectly treated as termination without complete-source validation. This is **a demonstrated missing safety requirement**, not an accepted negative test.
- Source `+.[+]` emits guest byte `01` before producing diagnostic error `0D`. COCK requires complete-source preflight before any guest effect; this component is unsafe on an invalid suffix.
- Source `+.\x00+` emits output `01` plus success `00`, without detecting bytes following the terminator. Only an independently trusted actual byte count and host transport closure can reject the excess data.

The interpreter still does **not** implement arbitrary loops, guest comma input, original-source offsets, dynamically configured logical-address traps, exact instruction fuel, complete-source preflight, physical host read/write error handling or `COCK-FRAME-v1` status records. `[-]` is not a generally fuel-preserving optimization: with a configured guest fuel limit its original command-level execution must be accounted for. No output of this candidate may be used as a production build publication authority.

**Milestone blocked:** The two-level same-implementation BF-in-BF execution of the actual compiler remains **NOT VERIFIED**. No ELF shared library, APK, emulator boot or Android device execution occurred.
