# Six cell static admission proof — diagnostic evidence

Date: 2026-10-24. **Status: COMPONENT DIAGNOSTIC PASSED; FULL STAGE A NOT VERIFIED.**

## Implemented component

`src/six_cell_static_safety_gate.bf` is a standalone annotated Brainfuck program. Its executable content consists only of the eight original Brainfuck commands. It reads already-normalized guest command bytes in a diagnostic record format: for each source instruction, its literal ASCII byte followed by guard byte `A5` hexadecimal; then a zero command byte and another `A5` guard at the end. The source length and nesting depth are not limited to one byte or a fixed number of instruction records. The actual executor still has finite physical resources and must be run with an independently declared resource budget.

The component emits one byte: `01` means **static six-cell safety admission**, and `00` means rejection. This status is diagnostic metadata, never guest stdout, and does not claim conformance with the `BFIO` or `BHIO` protocols. Its frame stack uses twelve Brainfuck host cells per active lexical loop frame. It checks the exact original eight-instruction alphabet, properly nested matching brackets, guest pointer movements remaining at addresses zero through five, and each loop body returning to its starting guest pointer address. Input bytes are validated in sequence; the output is issued only at the terminal decision or on detected failure.

The loop-entry pointer invariant is intentionally restrictive. If a loop body restores the pointer, each iteration begins with the same pointer value. By induction, the single linear source scan covers the intermediate pointer travel of every iteration; every recorded pointer movement must remain within the six-cell range. A loop whose body moves the pointer without restoring it is rejected even when it could be safe or never execute at runtime. This is a *safe subset admission proof*, not the full COCK guest semantics. The current six-cell interpreter has not been modified and cannot independently handle arbitrary pointer traps.

## Consolidated executed diagnostic batch

| Check | Result |
| --- | ---: |
| Fixed guest examples including unmatched brackets and loops | 20 / 20 |
| All representable nonzero one-byte source commands | 255 / 255 |
| Seeded randomized finite source strings | 700 / 700 |
| Malformed completion guards and truncated records | 160 / 160 |
| Admission of original and compact 515/452-command mini compilers | 2 / 2 |
| Frozen raw AArch64 output regression through the previous BF-in-BF kernel | 6 / 6 |
| All repository authored BF files and fixtures checked for annotation grammar and bracket balance | 20 / 20 |
| **Total** | **1,163 / 1,163** |

The six raw-code regression artifacts have precisely the pre-existing bytes. These are **not** Android ELF objects or APKs. The gate itself produces one status byte; it does **not** generate AArch64 bytes. Binary test inputs, reference outcomes, SHA-256 and test counts are preserved in `fixtures/six_cell_safety/` and `docs/six-cell-static-safety-evidence.json`.

Local execution used an outside-repository C Brainfuck diagnostic evaluator (`/tmp/cock_bf_diag`), with an outside-repository Python fixture/test driver and reference oracle. Neither external implementation was added to the repository. They do not certify an independently qualified bootstrap executor, nor strict end-to-end BF-only drafting provenance.

## Reproduction example

With a separately installed, independently verified evaluator that implements the declared host cell, EOF, tape and binary I/O behavior, run from the COCK root:

```text
cock-bf-diagnostic src/six_cell_static_safety_gate.bf 50000000 < fixtures/six_cell_safety/valid_nested.input.bin > /tmp/cock-safety-result.bin
```

The expected single output byte is `01`. The compiler fixtures are `mini_compiler.input.bin` and `mini_compiler_compact.input.bin`; both yield `01` within the stated host diagnostic budget. The physical test environment must independently report exact input counts, stream closure and host status.

## Deliberately unresolved capabilities

- The input grammar uses `00` as the end marker, so an actual NUL source byte is **not representable as a command**. The BF-authored complete annotated-source preflight must reject it before this diagnostic handoff. A `00 A5` record followed by extra bytes can produce `01`: the fixture `trailing_unverified.input.bin` confirms that physical host stream closure is still **NOT VERIFIED**. Do not accept the gate's success as a sealed-source proof.
- This does not enforce guest instruction fuel, cancellation, dynamic tape growth, or runtime pointer-error statuses. It does not rule out nontermination for an admitted program such as `+[+]`.
- The checker returns a Boolean, not normative original source byte offsets or `COCK-FRAME-v1` structured errors. A future BF-authored coordinator must bind it to trusted exact source length, status authority and the actual kernel invocation before calling it production admission.
- General COCK programs with pointer-moving loops or more than six cells may be perfectly valid but are rejected by this restrictive gate. Rejection here is `UNSUPPORTED_CAPABILITY`, not evidence of a malformed general-language program.
- The mandatory **COCK interpreter executing itself and the actual compiler in a bounded nested chain** remains unproved. Android tooling, device launch and debug APK work remain deferred.

**Next priority:** improve runtime guest trap/fuel enforcement and BF-owned source handoff rather than replacing a correct general Brainfuck program with this restrictive subset.
