# General program counter interpreter diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Date:** 2026-10-24. **Status:** component diagnostic passed; Stage A NOT ACCEPTED.

`src/bf_in_bf_pc_dispatch.bf` implements general guest bracket execution using a real program counter, together with all eight guest BF commands, pointer movement, binary I/O, and before-command fuel checks. Both a zero-valued opening bracket skip and a nonzero closing bracket return jump to the first command after its matching opener. Evaluated opening and closing commands count as guest fuel. Source command streams are **required to have passed complete-source preflight independently**; the component does not perform that preflight or prove stream closure.

## Tested bounded contract

- Source: one length byte, up to **127** raw normalized BF commands, then one guest fuel byte, then ordinary binary input data. Source loading uses exact length but does not independently authenticate closure.
- Guest tape: 16 zero-initialized cells, wrapping modulo 256. Rightward access to the seventeenth cell returns diagnostic status `05`; movement left from cell zero returns `04`.
- Fuel: one-byte allowance from 0 to 255. The command that would exceed fuel is not executed; status `06`. A valid zero-command source completes with fuel zero.
- Output: ordinary guest bytes followed by **one extra diagnostic terminal status byte**. The status byte is not a substitute for authoritative `COCK-FRAME-v1` completion.
- Implementation: 508,212 annotated BF source bytes and 501,519 actual BF executable command glyphs; SHA256 `a1f42a11055f2f12f19a9fe1cf75eac5bed6dd4b26306091e204ae0ee1d62cbc`.

## Consolidated diagnostic test results

- **583/583** seeded/fixed/nested interpreter comparisons against an independent diagnostic reference model: {'fixed': 175, 'seeded': 360, 'nested': 48}.
- **256/256** binary-input round trips for `,.`, covering every byte from `00` through `FF`.
- **20/20** raw executable binary input/expected-output fixtures recorded in `fixtures/pc_dispatch/`.
- **6/6** unchanged original and compact compiler outputs reproduced by the *previous* `bf_in_bf_six_cell.bf` implementation and matched against frozen AArch64 candidate files. The new bounded dispatcher does **not** run those compiler sources.
- **34/34** source-format and balanced-bracket static audits across the repository BF sources.

## Explicit negative and unknown outcomes

- Input containing `+.X` produced `01 0D`, i.e. a guest output byte **before** unsupported-source status. This is a demonstrated nonconformance to COCK complete-source preflight, so externally unvalidated sources must **never** be passed to this interpreter.
- Source-length byte 128 is rejected with status `0D` under the component's 127-command limit; that diagnostic does not replace a scalable production length encoding.
- No authenticated physical input closure; no source-original byte-offset reporting; no support for programs over 127 commands, tape addresses over 15, or fuel over 255. No bounded same-interpreter nested actual compiler execution.
- A disposable outside-repository **Python authoring aid** assembled repeated BF instruction sequences. All executable files **inside** this repository remain BF, but the master specification's stricter BF-only development-process provenance is **not certified**.
- The evaluator at `/tmp/cock_diag_bf` is an unqualified diagnostic implementation, not the independently installed production bootstrap. Android SDK, emulator, ELF, APK and device tests remain **DEFERRED / NOT RUN**.

## Reproduction

Given an independently installed, binary-safe BF executor compatible with the documented outer machine, execute `src/bf_in_bf_pc_dispatch.bf` with `fixtures/pc_dispatch/nested_transfer.input.bin`, and compare raw stdout with `nested_transfer.expected.bin`. Repeat for all named fixtures in `docs/pc-dispatch-evidence.json`. The host must separately report process outcome, byte counts and stream completion. There is no claim that a C evaluator's self-reported success is independent Android or COCK production validation.

The previously verified `bf_in_bf_six_cell.bf` and six raw AArch64 candidates remain unchanged.
