# Dynamic tape logical budget diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Status: LOCAL COMPONENT DIAGNOSTIC PASSED. STAGE A NOT ACCEPTED. Android deferred.**

## Implementation

`src/bf_in_bf_dynamic_budget.bf` extends the separate dynamic linear Brainfuck interpreter with a **configurable logical guest tape ceiling**, checked at the exact rightward guest movement. Each twelve-cell guest tape record carries a copy of the remaining address budget. For a valid movement, the next record receives the decremented budget. When it is zero, the guest right move is suppressed and the component emits diagnostic status `05` rather than changing the logical pointer. Left movement at the origin remains status `04`, and extra-address cells are logically initialized to zero. This source implements only `+ - < > .` and therefore is **not** a full COCK runtime.

The diagnostic input starts with one `u8` indicating **maximum additional cells beyond logical cell zero**. A value of `00` means a one-cell budget; `FF` permits up to 256 cells. This finite field is a limitation of this *diagnostic input interface*, not a global platform/source/tape limit. The remaining input is a pre-admitted raw sequence of the five supported instruction bytes, ending with an untrusted zero-byte delimiter. The output is guest bytes followed by one development status byte; this is **not** a `COCK-FRAME-v1` result authority. The module is only safe to invoke behind complete-source validation and trusted physical input closure.

## Executed tests

- **548/548** fixed and seeded randomized differential cases on the first full rerun.
- **1468/1468** additional extended diagnostics, including right growth to the exact budget and trapping on the immediately following move for *every* budget from 1 through 256, plus roundtrips and additional seeded randomized programs.
- **15/15** saved exact-byte input and output fixture pairs rerun successfully.
- **6/6** original and compact mini compiler outputs independently rerun through the **unchanged six-cell compiler-capable preflight interpreter** and compared byte for byte with previously frozen AArch64 candidates. This explicitly does **not** show the new dynamic-budget interpreter running the compiler.
- **39/39** repository Brainfuck source grammar and bracket audits passed.

SHA-256 of new BF source: `41a971997e787383b7eeac3300ea3e0522611ac4fe2fa6cd63eeaa05b5700db8`. Executable BF commands: **946**. Local C evaluator is an outside-repository diagnostic executable; its commands and resource limit do not represent COCK guest fuel or a certified independent root bootstrap.

## Corrected defects before the passing rerun

1. The first right-movement draft left the moved-to guest record's active marker on a denied movement. That allowed a subsequent command to execute after the logical budget should have trapped. Clearing the active marker before branch selection corrected this.
2. The right-movement branch initially ended on the active flag instead of the cleared movement flag, creating incorrect BF loop control flow. The branch exit was corrected before the full tests.

Both defects were found by diagnostic tests; none of their failed cases are reported as passing results.

## Outstanding acceptance work

The one-byte diagnostic budget field is not the scalable checked integer/tape budget contract required for the complete `COCK` profile. Arbitrary loops, guest input, original-command fuel, source preflight, authoritative error offsets, independent host-stream closure, source-level nested self-interpretation, a verified Android ELF and APK are still not implemented here. In particular this interpreter **cannot execute either 515-command or 452-command compiler**, and the same-interpreter nested compiler proof is still **NOT VERIFIED**. Since a tool outside the repo assisted drafting and coordinated diagnostics, strict BF-only development-process provenance is not independently certified.
