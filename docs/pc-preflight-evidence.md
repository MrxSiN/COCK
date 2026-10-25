# Integrated general loop source preflight evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Status:** LOCAL COMPONENT DIAGNOSTIC PASSED. Stage A NOT ACCEPTED. Android testing DEFERRED.

## Change

`src/bf_in_bf_pc_preflight.bf` preserves the prior bounded program counter dispatcher and adds a complete in-memory normalized-source gate at a top-level Brainfuck instruction boundary **after source loading and before reading guest fuel or executing any guest command**. The new gate validates each of the eight admitted command bytes, balances nested brackets, checks the declared loaded-source byte count including embedded NUL, and prevents interpreter entry when validation fails. Its one terminal status byte replaces all guest output for malformed source.

The previous `src/bf_in_bf_pc_dispatch.bf` was preserved unchanged as a regression baseline. The integrated source still contains the same general nested loop dispatcher, sixteen guest cells, byte wrapping, input EOF zero, and before-command one-byte guest fuel enforcement.

Unlike the previous bounded dispatcher, the new executable rejects source `+.X` with **only hex `01`**, not `01 0D`, and rejects `+.[` with **only hex `02`**, without running its prefix.

## Real tests performed

- **431 of 431** exact stdout and terminal status comparisons against a separate temporary diagnostic reference model: 21 targeted cases and 410 seeded randomized cases with seed `20261024`, including invalid suffixes, NULs, unmatched brackets, nested loops, pointer boundaries, fuel cutoffs and binary guest I/O.
- **256 of 256** binary byte echo cases using `,.` and all values from `00` to `FF`.
- **19 of 19** committed binary input and expected output fixture pairs under `fixtures/pc_preflight/`.
- **20 of 20** previous program counter interpreter fixture pairs under `fixtures/pc_dispatch/`.
- **6 of 6** preserved raw AArch64 compiler artifact outputs re-executed through the **unchanged six-cell compiler-capable interpreter**, matching the frozen bytes exactly. The new bounded interpreter cannot yet execute those compiler programs.
- **34 of 34** tracked Brainfuck executable source files passed checked annotation-line syntax, instruction-only code lines and balanced source brackets.

The full first-pass differential batch exposed defects in loop-wrap injection placement, high-scratch marker overlap, residual counters after EOF, and scratch-state collision during status rewind. These were corrected; the results above are from completed reruns, not a count of earlier unsuccessful attempts. All test results are diagnostic and **not** an independent Android or root executor certification.

## Actual input/output interface

Input is a one-byte length `N` (currently `0..127`), exactly `N` normalized source bytes, a one-byte guest fuel allowance, and binary guest stdin. Output is guest bytes followed by a one-byte terminal status on execution success/failure. Source-preflight errors emit only one status byte. The test fixture files are literal inert byte data, not executable scripts.

The diagnostic status values use the existing numeric vocabulary: `1` illegal source byte, `2` unmatched opening, `3` unmatched closing, `4` left-boundary, `5` guest tape budget, `6` guest fuel, and `13` unsupported source capacity. Valid empty source with zero fuel returns `00`.

## Acceptance boundaries

- This source loader is bound to the existing one-byte length and 127-command implementation budget, not a global source or app limit. It does not validate the original annotated `.bf` line grammar or return original annotated-source byte offsets.
- A byte stream appended after the declared source and subsequent input cannot be proven closed by BF's EOF-as-zero semantics. A trusted host must independently attest exact actual reads and input/stream completion. This is **NOT VERIFIED**.
- The original full COCK guest tape and resource profile, scalable source storage, dynamic guest tape and broader fuel width are incomplete.
- The new source is 100 percent executable BF in the repository, but a **temporary outside-repository Python BF-layout drafting aid** helped construct the new code. Strict BF-only development-process provenance is therefore **NOT CERTIFIED**. A temporary outside-repository C evaluator is a diagnostic tool, not an independent certified bootstrap or a production generator.
- The mandatory **same COCK interpreter running itself running the actual mini compiler** remains **NOT VERIFIED**. No ELF, signed APK, emulator or Android device result was obtained.

See `docs/pc-preflight-evidence.json` for source identities and machine-readable result totals.
