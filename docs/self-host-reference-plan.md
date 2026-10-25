# Stage A bounded reference interpretation slice

State before drafting: Stage A own BF interpreter does not support pointer traversal or loops. Android is deferred. This slice adds a separately licensed Brainfuck-authored *reference interpreter*, not an assertion that the existing COCK interpreter is complete.

## Inventory before bulk draft

- `src/bf_in_bf_reference.bf` — annotated BF source adapted only by line-level annotations from Daniel B Cristofani's independent 423-command BF self-interpreter; CC BY-SA 4.0 source and credit are explicit. Its source is a BF interpreter, not foreign-language executable code.
- `docs/self-host-reference-plan.md` — this inert scope, obligations and test inventory.
- `docs/self-host-reference-credits.md` — source citation, licensing, compatibility exclusions.
- `fixtures/self-host-reference-vectors.json` — inert vectors and named tests.
- `docs/self-host-reference-evidence.md` — completed evidence after the batch.

## Accepted diagnostic transport for this slice

The reference interpreter consumes actual BF *guest program text* followed by an ASCII `!` separator and raw input bytes for that guest. This is the reference interpreter's legacy diagnostic convention; `!` is input framing data, not a ninth BF instruction or a new COCK compatibility protocol. An outside-repository independent analyzer supplies the complete, already validated BF instruction stream and exact guest bytes. Source legality, count, closure and authoritative status remain unresolved in this path.

## Planned tests

1. Direct independent reference interpreter executing the actual `mini_compiler.bf` instruction stream and each of three distinct example sources, compared exactly with previously frozen candidate AArch64 bytes.
2. Basic nested BF interpretation with reference source interpreted by a second copy, running a small loop and an arithmetic source, compared against independent direct BF diagnostic results.
3. Reference and direct-output equality for known loop and pointer fixtures and binary guest output cases, with independently marked limitations.
4. Negative test that demonstrates an invalid annotated source can bypass reference preprocessing (expected limitation; must not be counted as a passing preflight).
5. Full compiler through nested reference interpreter: attempt only under a fixed external evaluation budget; report timeout/budget as NOT VERIFIED, not a passing result.
6. Pure-BF repository audit; source attribution and exact program identity; output checksums; revised status documentation.

## Acceptance boundary

This slice may demonstrate the mini compiler through BF-in-BF and bounded *small-guest* nested interpretation. It cannot establish Stage A L0/L1 until the COCK-authored source gate and interpreter satisfy the complete source, bracket, resource and termination contracts, and **one bounded nested inner interpreter executes the actual full mini compiler with matching output**. The reference interpreter is a third-party BF-authored diagnostic code path with explicit CC BY-SA obligations; do not equate importing it with an independently established COCK-compliant production interpreter.
