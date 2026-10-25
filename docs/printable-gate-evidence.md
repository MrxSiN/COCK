# Printable source admission extension — executed diagnostic evidence

**Date:** 2026-10-24. **Status:** Component diagnostic passed; Stage A mandatory self-hosting and Android gates remain **NOT IMPLEMENTED / NOT RUN**.

## Implemented BF source

`src/printable_subset_gate.bf` extends the preceding `raw_subset_gate.bf` and leaves it unchanged as the prior passing baseline. It reads a declared single-byte source length, exact raw arithmetic source and an `A5` completion guard, and emits one provisional `01` admission or `00` rejection byte. Accepted raw sources have only `+` or `-` commands followed by exactly one final `.`, and their modulo-256 output must be printable ASCII inclusively `0x20..0x7e`. A BF-authored unary saturation comparison checks the true computed arithmetic cell, not a source filename or predetermined emitted byte.

The source has **831 executable BF commands** and 3,391 total source bytes. Its SHA-256 is `63fe76d9c0eba41bb3d5c5079c356018a78ace552315edb7fc0d7ab15f013e5b`. The earlier source and native artifacts are preserved. No foreign executable source or test runner was added to the repository.

## Consolidated diagnostic results

| Evidence | Observed result |
| --- | --- |
| All eight in-repository `.bf` sources: lexical annotation rules and matching brackets | 8 / 8 passed the independent static inspection |
| Fixed authored vectors actually executed in local diagnostic BF evaluator | 18 / 18 passed |
| Distinct fixed host-boundary conditions (too-large length in this one-byte slice and trailing data after the guard) | 3 **NOT RUN** as host adapter tests; classified as required host rejection in fixtures |
| Every possible result byte, represented with an in-budget source | 256 / 256 passed |
| Independent BF arithmetic oracle for the same exhaustive 256 byte cases | 256 / 256 matched expected guest bytes |
| Additional randomized raw source, suffix and grammar cases | 700 / 700 passed; fixed seed `20261024` |
| Three existing BF examples, admitted and compiled as raw source diagnostics | 3 / 3 matched the previously recorded AArch64 raw files |

The three already recorded raw candidates remain 264, 272 and 280 bytes. They are **not ELF files, shared objects or signed APKs**. The comparisons used an existing standalone mini compiler invoked directly by the local diagnostic evaluator; **this is not** the required `root BF executor -> BF-in-BF -> mini compiler` self-hosted production path.

## Reproduction of an executed printable boundary example

With the local nonqualifying evaluator, decimal 32 addition commands followed by one output command give source bytes length 33, then `A5`; the expected gate output is hex `01`. Decimal 31 addition commands followed by one output command give `00`. Both were executed and checked in the diagnostic batch. The full data fixtures are in `fixtures/printable-subset-vectors.json`.

## Trust and remaining acceptance blockers

The diagnostic evaluator is a temporary, outside-repository program installed for local engineering, **not** the independently supplied standards-only bootstrap required for the production correctness chain. The source `u8` count is a deliberately bounded **per-invocation diagnostic profile**, not a universal app/source limit. Neither EOF-filled `00` nor a valid trailer proves the producer closed successfully: the current physical host adapter cannot independently certify trailing-free closure, so the three host-only fixtures are not counted as passed adapter tests. The gate rejects comments and whitespace, so it is not the full Part 1 annotated source preflight. The emitted admission byte is not a `COCK-FRAME-v1` status frame and cannot authorize publication.

The mandatory next production gates are (1) a BF-authored full annotated-source validator with actual byte-length/closure authority, (2) a BF-in-BF interpreter that **executes the actual mini compiler**, (3) one bounded inner interpreter executing that compiler with identical output, and (4) BF-produced Android loader bridge/ELF and real device acceptance when available. Android SDK/emulator installation is deferred at the user's request. No optimizations or platform compatibility are claimed.
