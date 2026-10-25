# Atomic normalized command handoff slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Scope: one complete restricted normalized Brainfuck source record, with one unsigned byte length, exactly that many literal data bytes and an A5 completion guard. The BF-authored admission component must buffer all source characters, check each against the original eight-command alphabet and validate bracket depth before publishing any command byte. It emits one leading pass/fail status byte; success additionally emits the original command stream, failure has no extra stdout bytes. An external host still owns factual exact byte counts and stream closure, because a guard alone cannot establish no extra trailing bytes.

Files inventoried before batch: `src/normalized_source_atomic_gate.bf`; inert `fixtures/normalized-source-atomic-vectors.json`; `docs/normalized-source-atomic-plan.md`; `docs/normalized-source-atomic-evidence.md` and `.json` after tests; README/status updates after test; workspace ZIP after acceptance of component diagnostics.

Baseline negative vectors: empty, one plus, single output, all eight glyphs, balanced and nested brackets, prefix-closing and unterminated opening, an invalid suffix after valid prefix, embedded NUL, embedded non-ASCII, invalid guard, truncated payload and trailing bytes. Validate 255-byte count boundary, compare BF result to an independent external reference in diagnostic mode and retain prior raw AArch64 code candidates. Do not treat a standalone input guard as host closure or an in-band byte as authoritative session success. This is a one-record constrained development interface, NOT BFIO/BHIO and NOT a general source length restriction.

Implementation may reuse the original BF tape operations but cannot execute a guest or emit a command before successful admission. The accepted output is `[01] + command bytes`; rejected output is `[00]`. No test is to run before initial source, fixtures and plan are complete.
