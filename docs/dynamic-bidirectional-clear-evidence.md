# Dynamic bidirectional clearing loop diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status: **835/835 local guest diagnostic checks passed; Stage A NOT ACCEPTED**.

`src/bf_in_bf_dynamic_bidirectional_clear.bf` extends the preserved dynamic right growing twelve cell tape kernel. It recognizes exactly the original guest commands `[-]` and `[+]` as clearing loops, including zero iteration and wrapping unsigned byte behavior, on arbitrary addresses supported by the outer BF host. For the selected unrestricted guest fuel mode only, the two forms both leave the addressed byte at zero. Input and output retain the earlier diagnostic interface: exact trusted raw program bytes then zero delimiter, output guest bytes followed by status byte. This is **not** COCK FRAME status framing.

## Post draft consolidated test batch

- **15/15** frozen exact byte fixtures passed.
- **600/600** seeded random valid sources combining linear BF commands and both loop patterns matched an independent outside repository differential oracle.
- **60/60** growth cases passed for guest cells including positions 257, 300 and 720.
- **160/160** preserved older subset executions passed: 80 cases through this kernel and 80 through the frozen older clear loop kernel.
- **6/6** frozen raw AArch64 outputs reproduced by the **unchanged six cell compiler capable interpreter**. Those checks are preservation only, not evidence the new interpreter can run the compilers.
- **29/29** tracked BF source files passed static annotation and bracket audits.
- Current source SHA256 `0ac99e93314376c42e44f39c5929d6025699cf423752b9e0f66b9fd9ab82adec`; executable BF commands 1265.

## Release and architecture limits

This is a **restricted loop pattern interpreter**, not general nested loop execution. In particular the full mini compiler source cannot run in this interpreter because it uses other loop bodies and input. Complete annotated source preflight, original source offset error reporting, trusted actual byte counts and process stream closure, comma guest input, full guest command fuel, configured logical memory budget and physical I/O statuses are absent. **Do not** use it to process untrusted source or authorize published artifacts. A valid prefix may emit output before a later invalid opcode. No executor code or oracle in a foreign source language has been checked into the COCK repository, but the outside C diagnostic evaluator and Python test checker do not satisfy the stronger all BF development provenance rule.

The mandatory two level same interpreter run of the entire real mini compiler and Android ELF APK emulator and device acceptance remain **NOT VERIFIED / DEFERRED**. Future work should prioritize a general program counter and loop stack over expanding hardcoded loop pattern recognizers indefinitely.

## Negative probes actually observed

- `bad_suffix` received input `2b2e5b2b2b5d00` and emitted `010d` (exit 0). This is **negative evidence** and does not count as a passing COCK source preflight.
- `illegal_embedded_zero` received input `2b002e00` and emitted `00` (exit 0). This is **negative evidence** and does not count as a passing COCK source preflight.
- `trailing_after_zero` received input `2b2e005a` and emitted `0100` (exit 0). This is **negative evidence** and does not count as a passing COCK source preflight.
