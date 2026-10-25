# Nested compiler capable BF interpreter diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date: 2026-10-24. Status: **NESTED SIX CELL KERNEL DIAGNOSTIC PASSED / FULL STAGE A NOT ACCEPTED**.

## What was actually demonstrated

The externally installed diagnostic Brainfuck evaluator started Daniel B Cristofani's independently attributed BF-in-BF reference (`src/bf_in_bf_reference.bf`). That interpreter executed the *unchanged* COCK-owned `src/bf_in_bf_six_cell.bf` source as an inner Brainfuck guest. That inner COCK kernel then executed the input application Brainfuck program. Five exact-byte tests completed successfully:

| Inner application source | Expected result | Observed result | Outer root BF commands |
| --- | --- | --- | ---: |
| `+.` | `01` | `01` | 3,887,442,225 |
| `+[-].` | `00` | `00` | 11,299,482,319 |
| `,.` with input `FF` | `FF` | `FF` | 3,770,808,042 |
| `,[-].` with input `00` | `00` | `00` | 6,532,634,845 |
| `>++<+>.` | `02` | `02` | 13,396,734,166 |

The result is **two real Brainfuck interpreter layers**; the outer is the independently authored reference and the inner is the real COCK compiler-capable six-cell kernel. The outer and inner are **not the same interpreter implementation**. The final guest in these five passing cases is small; none is a complete compiler.

## New BF authored transport implementation

`tests/nested_reference_transport.bf` accepts independently admitted source bytes as u8-count-prefixed chunks, then a zero-length source terminator, then independently admitted binary input bytes in further u8-count-prefixed chunks and a zero input terminator. It emits the exact source bytes, the independent reference interpreter's literal ASCII `!` delimiter, and the exact binary guest input bytes (including `00` and `FF`). This driver has only Brainfuck executable instructions and does not choose a compiler, interpret the guest or implement application logic. It is a **diagnostic physical byte framer**, not `COCK-BUILD-INPUT-v1` or `COCK-HOST-IO-v1`.

Nine out of nine byte-identical transport fixtures passed. They include a 601-command synthetic source; embedded `00`, `21`, and `FF` in a binary data relay; the 8,907-command six-cell interpreter source as literal transported source bytes; and the complete original and compact mini compiler input requests. BF source emission happened in the new BF driver, not in the external diagnostic test harness. The harness independently supplied inert, length-known fixture bytes and compared the outputs.

## Required nested compiler proof NOT completed

The compact compiler source, inside the unchanged COCK six-cell kernel running under the BF reference, was actually attempted. It produced **zero output bytes**, exited with diagnostic watchdog status `124` at **12 seconds**, and did not produce the expected 140-byte raw AArch64 candidate. It is **NOT VERIFIED**, not a pass. A separate early 13-second attempt had the same result. The original full compiler under two interpreter layers was transported but not executed in this batch.

The mandated full chain is specifically **root standard BF evaluator → COCK interpreter → second copy of the same COCK interpreter → actual mini compiler**, with exact matching output. This has not been achieved. The existing six-cell interpreter uses more than six working host cells in its own instruction implementation, and cannot safely run a second copy of itself with its current six-cell guest tape. A future implementation needs a dynamically expandable or otherwise proven sufficiently addressable guest tape, not just an increased diagnostic timeout.

## Baseline preserved

The unchanged `src/bf_in_bf_six_cell.bf` directly executed both unchanged mini compilers on the three existing apps. All **6/6** outputs exactly matched the frozen 264/272/280-byte original candidates and 140/144/148-byte compact candidates, including their recorded SHA-256 digests. Every **26/26** `.bf` file passed the Part 1 line-level annotation grammar and bracket-balance static audit.

## Negative evidence and trust limits

Two deliberately malformed transport inputs were probed against the BF framer:

- Appending extra bytes after the last zero input-chunk marker produced the same successful output as the closed, valid prefix.
- Dropping the final zero input-chunk marker likewise produced the same output because `,` writes zero on physical EOF.

Both show that **independent physical read counts, source-length authority, complete input and process/pipe closure are required**. The BF transport driver cannot treat zero returned at EOF as a trusted terminator. The positive exact-byte cases were run from externally sealed fixture byte arrays; they do not establish production input admission. There is no claim of source-grammar rejection, guest fuel or pointer-trap conformance, an Android ELF or a signed APK.

The root evaluator `/tmp/cock_diag_root` is a local diagnostic executable compiled outside the COCK repository. It has not been certified as the mandated independent standards-only bootstrap. Python outside the repository authored inert fixture transport records, coordinated tests and inspected outputs, but no Python/C/shell executable source was placed into the COCK workspace. This does not certify the stricter development-process BF-only authorship claim. The separately attributed reference interpreter remains subject to CC BY-SA 4.0; see `docs/self-host-reference-credits.md`.

## Files and reproducibility

- `tests/nested_reference_transport.bf`: BF-authored diagnostic transport driver.
- `fixtures/nested_kernel/vectors.json`: exact fixture inventory.
- `fixtures/nested_kernel/*.input.bin`: counted source plus counted binary guest input.
- `fixtures/nested_kernel/*.transport.expected.bin`: exact output of the BF transport driver.
- `fixtures/nested_kernel/*.result.expected.bin`: expected small guest output or frozen compiler output as applicable.
- `docs/nested-kernel-evidence.json`: observed per-vector passes, root guest instruction counts, hashes and recorded timeout.
- `docs/nested-kernel-slice-plan.md`: scope and acceptance inventory frozen before tests.

Reproduction on a host with an independently installed declared-compatible standard BF executor: execute `tests/nested_reference_transport.bf` with each counted input fixture, and compare the exact stdout bytes to its frozen transport fixture. Then execute `src/bf_in_bf_reference.bf` on that verified transport stdout for each `nested_run=true` vector, compare to `result.expected.bin`, and independently check the executor exit and complete stdin/stdout closure. Never interpret the transport success as a source-preflight, production or same-implementation self-hosting certificate. Android remains deferred at user request.
