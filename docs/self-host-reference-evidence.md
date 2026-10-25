# Reference BF in BF evaluation evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date: 2026-10-24. This is **diagnostic evidence only**, not accepted Stage A L1 or Android functionality. Android development remains deferred.

## Artifact source and tool boundaries

The new `src/bf_in_bf_reference.bf` is a 423-instruction independently authored Brainfuck interpreter, attributed and licensed as described in `docs/self-host-reference-credits.md`. Its annotated source passes the Part 1-safe comment syntax audit and has a command stream **identical** to the reference downloaded manually into the *outside-repository* diagnostic area. The original COCK-authored `src/bf_in_bf.bf` is still limited to arithmetic and has **not** been upgraded into a complete interpreter.

Root diagnostic tool: `/usr/local/bin/cock-bf-diagnostic`, a locally compiled, outside-repository BF evaluator with wrapping byte cells, zero-at-EOF input and variable tape. It has not received independent standards-only qualification. A temporary external differential program extracted BF commands from annotated source for these *tests*; this is **not** a BF-authored production preflight or transport authority. The interpreter's `program!input` delimiter is legacy reference test framing, not a COCK versioned wire protocol.

## Consolidated results

- PASS: the reference interpreter executes the **actual 515-command BF mini compiler** with each of the three prior input application command streams (`tiny_app_a`, `tiny_app_b`, `held_out`). Exact output matches the already frozen raw AArch64 candidate files: **264, 272, 280 bytes** respectively. No guest program output was substituted by a filename or lookup table.
- PASS: direct execution under the reference of 4 bounded guest programs (arithmetic, a bracketed pointer/loop program, one-byte NUL input/output and one-byte FF input/output).
- PASS: the same **4 small guest programs** executed through **two BF-in-BF layers** (reference interpreter executing a second copy of itself, which executes the test program).
- EXPECTED MISSING GATE: the reference alone processes the malformed guest source `+x.` and emits byte `01`; it does **not** provide COCK's Part 1 strict source preflight. A production loader must reject that original source before any guest command.
- NOT VERIFIED: the required **full nested self-interpreter executing the actual mini compiler**. The local diagnostic evaluation stopped after an outer 15-billion-step budget with only 2 of the expected 264 output bytes. A separate, outside-repository optimized native diagnostic evaluator was stopped at 25 seconds, producing zero bytes. Neither is a pass. No guessed full result, performance improvement or valid artifact was reported.

Of the 12 listed diagnostic scenarios, 11 positive expectations passed and one negative source-gate gap was deliberately demonstrated. Details, output SHA-256 values and wall times for each completed test are in `docs/self-host-reference-evidence.json`.

## Reproduction outline

- Validate exact original source input and normalize it to the eight Brainfuck commands for **diagnostic use only**; an outside-root test extractor was used and is not part of the production repository.
- Feed binary stdin consisting of the normalized mini compiler commands, ASCII `!`, and each example's normalized source command bytes to `/usr/local/bin/cock-bf-diagnostic src/bf_in_bf_reference.bf`.
- Compare stdout with `artifacts/<name>.aarch64.raw` using an independently installed raw binary comparison tool; do not compare printed text or presume NUL-safe terminal display.
- For the small nested fixtures, feed the reference interpreter's own command stream, then `!`, then the small guest program, then `!` and any guest input. Test outputs are recorded in `fixtures/self-host-reference-vectors.json`.
- Always bound external process time and memory. A timeout is a **host result**, not a guest COCK status.

## Current milestone distinction

This is working and testable **Brainfuck-in-Brainfuck compiler interpretation under a third-party BF-authored reference**. It is not the complete self-hosting target: required COCK-authority source-byte preflight, frame/status/trusted host transport, guest logical budgets and fuel, runtime trap provenance, complete nested execution of the compiler, and actual Android implementation/evidence are still missing. Do not promote a third-party interpreter's permissive parser to a COCK source authority. No compiled Android ELF, APK or signed release exists.
