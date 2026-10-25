# Dynamic guest tape with checked budget and clear loops — diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Status:** component diagnostic passed, **not Stage A acceptance**. Android remains deferred.

## Implementation

`src/bf_in_bf_dynamic_budget_clear.bf` is a Brainfuck-authored executable source assembled from the existing BF budgeted dynamic-tape executor and the existing BF exact clearing-loop dispatcher. It implements `+`, `-`, `<`, `>`, `.`, `[-]`, and `[+]` on a right-growing logical guest tape with byte-wrapping cells. The two loop constructs are admitted only as the literal three-command patterns. This component **does not implement arbitrary loops, input commands, original-command fuel, or complete preflight**. It remains separate from both full-mini-compiler-capable six-cell interpreters. No prior compiler source or artifact was changed.

The diagnostic input is one byte specifying `maximum_logical_cells − 1` (0 to 255), followed by trusted source command bytes and a NUL terminator. The output is guest stdout bytes followed by **one unframed status byte** (`0` success, `4` left boundary, `5` configured logical cell budget, `13` unsupported). This output is diagnostic and must not be confused with binary-safe `COCK-FRAME-v1` status. Its one-byte budget is a prototype representation restriction, not a universal COCK tape cap. The current interpreter's physical allocator is delegated to the root evaluator and its OOM timing is host dependent.

## Executed batch

- **630/630** model-checked cases: 30 fixed and 600 reproducible random cases, seed `20261025`, covering clearing loops, modular arithmetic, pointer travel, output bytes, unsupported commands and guest logical errors.
- **80/80** byte-for-byte differential comparisons against the preserved `bf_in_bf_dynamic_budget.bf` on the common linear subset.
- **7/7** additional budget-boundary cases passed. They include a single-cell `><` trap, all 256 addressable logical cells, failure on the 257th rightward address, clearing on the highest admitted cell and clearing after rightward growth.
- **6/6** unchanged native-code artifact comparisons: the separately preserved `bf_in_bf_six_cell_preflight.bf` executed the original and compact mini compilers on three distinct application inputs, and all generated raw AArch64 bytes exactly matched frozen files. **These tests establish no compiler capability in the new dynamic-clear component**.
- **40/40** Brainfuck source grammar and balanced-bracket audits passed. The new component contains **1,410 executable Brainfuck commands**.
- **18** fixed-case input/output fixture pairs are saved as inert binary files under `fixtures/dynamic_budget_clear/`. The JSON record includes the source SHA-256, cases, observed status distribution and frozen artifact hashes.

The source program and byte comparison were exercised by an **outside-repository C diagnostic Brainfuck evaluator** and an outside-repository diagnostic reference oracle. These are not a qualified self-hosting bootstrap, BF-native test coordinator or Android test. Repository-authored executable source remains `.bf`, but strict provenance of external drafting aids is not certified.

## Known negative boundaries

1. **No trusted stream closure:** an input whose valid NUL terminator is followed by unrelated bytes still returns success. An OS read-count/closure authority is mandatory.
2. **Not preflighted:** `+.[]` emits the guest `01` byte before `13` unsupported status; `+.[-` also emits partial output. The status byte is not independent completion authority. An accepted compiler path must preflight the entire complete source first.
3. **Not fuel aware:** collapsing a clearing loop can change guest-command cutoffs. This mode must not claim `COCK` instruction-fuel conformance. There is no protection against arbitrary unmatched or unsupported loop sources except the diagnostic rejection behavior.
4. **Not self-hosted compiler:** the new component does not run the 515-command or 452-command actual mini compiler. The older six-cell implementation runs both but cannot interpret itself due to limited guest memory.
5. **No target proof:** AArch64 outputs remain raw instruction words, with no Android ELF/APK/device result. Android tooling stays deferred by user request.

The next required architecture milestone is **dynamic tape plus arbitrary bracket dispatch plus preflight plus guest fuel in one interpreter**, followed by the full same-interpreter nested mini-compiler execution. Do not promote this clear-loop component as a general interpreter.
