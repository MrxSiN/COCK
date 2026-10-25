# Chunked normalized source preflight and original command offsets

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Date:** 2026-10-24. **Status:** local component diagnostics passed; Stage A **NOT ACCEPTED**. Android tests deferred.

## Implementation

`src/chunked_preflight_offsets.bf` contains **7,010 executable Brainfuck commands** in an annotated Brainfuck source. SHA256: `ba5c1a2cd6da45a773f7100a32c4642204b8a58984d554ede127a0f3a0b9d8e3`. The component reads a sequence of `(one-byte positive chunk count, exact raw command bytes)` records, a zero count, then a compulsory `A5` byte. It writes exactly **three bytes**: diagnostic status plus little-endian unsigned 16-bit **normalized command-byte offset**. No source bytes, guest stdout or partially decoded program are emitted.

Statuses use the existing COCK numeric error vocabulary where applicable: `00=OK`, `01=INVALID_SOURCE_BYTE`, `02=UNMATCHED_OPEN`, `03=UNMATCHED_CLOSE`, `0A=CHECKED_INTEGER_OVERFLOW`, `0B=MALFORMED_FRAME`. An offset of `FFFF` means not applicable; otherwise the offset refers to the normalized source command stream, **not the original annotated `.bf` file**. With complete source bytes, the earliest invalid command byte wins over bracket errors; otherwise first unmatched closing has precedence over earliest remaining opening. In this diagnostic interface the terminal guard and budget failures take priority over the source result.

The current implementation maintains 16-bit source positions and an 8-bit nesting-depth counter, explicitly rejecting 65,536 source commands or 256 live bracket levels. They are *component-specific representation limits*, not limits on COCK applications. The existing chunked interface admits an entire 515-command original mini compiler or 452-command compact compiler in one session.

## Executed diagnostics

- **935/935** exact-byte local diagnostic cases matched the independent reference model, including 256 exhaustive single-byte inputs, 320 seeded legal-alphabet streams, 320 seeded arbitrary-byte streams, fixed cases, long source positions, cross-chunk loops and both complete compiler streams. **One case intentionally confirmed that appended trailing bytes are NOT detected**; it is an expected limitation observation, not a successful complete-source security check.
- **2/2** additional long-record checks passed: 65,535 normalized commands returned `00 FFFF`, and 65,536 returned `0A FFFF` under a raised diagnostic outer evaluator instruction budget.
- **41/41** saved binary input/output pairs were rerun against the final new component with exact stdout and host process success checks.
- **6/6** unchanged original and compact raw AArch64 machine-code artifacts reproduced byte for byte by `bf_in_bf_six_cell.bf`, using already saved test input bytes and the diagnostic outside-repository BF evaluator. The new preflight is **not yet integrated into that compiler invocation**.
- **36/36** repository `.bf` sources passed the grammar/comment/bracket static audit. No additional foreign executable source was stored in the COCK repository.

The `docs/chunked-preflight-offset-evidence.json` file records source hash, seed, count and case names; inert binary fixtures are stored under `fixtures/chunked_preflight_offsets/`.

## Known blockers and nonclaims

- **Host closure:** `00 A5` followed by an extra byte is not detectable through the Brainfuck input model. The independent host must establish actual byte count, exit, read/write results and stream closure before permitting interpreter execution. The trailer is not authentication.
- **Annotated input:** this program consumes already-normalized BF commands. It does **not** validate Part 1 comment lines, reconstruct original annotated-source byte offsets, parse COCK-FRAME-v1, or forward a trusted source stream to the interpreter.
- **Runtime protection:** it is not integrated into the general program-counter interpreter, which independently showed invalid-source output leakage when used directly. An external diagnostic coordinator is not a production BF-owned dispatcher.
- **Resource model:** checked 16-bit offsets and 8-bit depth are a development diagnostic representation, not a project size policy; full dynamic logical resources are needed for production.
- **Provenance:** an off-repository Python authoring aid and C evaluator were used during development and comparison; strict BF-only *development-process* authorship is **not certified**. The in-repository executable source is annotated `.bf` only. The locally compiled evaluator is not the independently qualified root bootstrap.
- **Stage A:** mandatory same-interpreter nested compiler execution, target ELF, APK and device proofs are **NOT VERIFIED / NOT RUN**. Android was intentionally deferred.

## Reproduction

With an external binary-safe BF evaluator, execute `src/chunked_preflight_offsets.bf` using any matching `fixtures/chunked_preflight_offsets/*.input.bin` file as binary stdin, verify process exit and compare raw stdout to the exact corresponding `*.expected.bin`. This test alone cannot attest input transport closure or certify final guest execution. Do not accept the BF program's self-reported success without independent host observations.
