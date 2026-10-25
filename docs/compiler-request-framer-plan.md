# Compiler request framer slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status before test: DRAFTED / NOT RUN.

## Purpose

Replace the outside-repository procedural compiler request builder in the diagnostic compiler execution chain with a small BF-authored byte transformer. This is NOT source preflight, trusted file acquisition, end-to-end BF tool orchestration or nested self-interpretation.

## Inventory

- `tests/compiler_request_framer.bf`: all executable framing logic in annotated eight-command BF.
- `fixtures/compiler_request_framer/vectors.json`: frozen case descriptions and reference output hashes.
- `fixtures/compiler_request_framer/*.input.bin`: exact raw source and application input records.
- `docs/compiler-request-framer-evidence.md` and `.json`: post-draft diagnostic evidence.
- `docs/status.md`, `README.md`: post-test outcome notes.

## Input and output interface

Input: a *previously admitted normalized BF* compiler command stream, followed by literal ASCII `!` as a separator, followed by normalized arithmetic app bytes terminated at external EOF. Input source has no `!` or NUL bytes. The separator is diagnostic-only, not BFIO or BHIO. Compiler/app byte lengths and physical closure must already have been checked by an independent trusted host. The BF framer does not authenticate them.

Output: for each compiler command emit `01` and that exact command byte, followed by `00`, followed by the app bytes. Each instruction forms a one-byte source chunk for `src/bf_in_bf_six_cell.bf`. There is no whole-source size ceiling in the framer; the per-chunk data size is one. The intentionally simple encoding trades transport overhead for a constant-memory BF implementation. It is a new BF-authored diagnostic handoff, not a new wire/ABI contract.

## Acceptance vectors

- Original compiler source with each of the three existing admitted app sources; output exact original six-cell request semantics and byte-identical frozen 264, 272, 280 byte AArch64 payloads.
- Compact compiler source with the same three applications; byte-identical frozen 140, 144, 148 byte native payloads.
- No compiler commands and no app data; valid terminated empty program record.
- Repeated original BF instruction bytes and nested bracket bytes preserved byte-for-byte.
- At least one synthetic compiler program exceeding 255 original BF commands.
- Compiler source exactly 1, 255, 256, 515, 1024 BF commands to prove that the stream is chunked rather than truncated.
- Root evaluator must report successful completion and actual emitted byte counts. Inspect byte stream independently and compare to expected precomposed literal bytes.
- Audit strict tracked BF source grammar, comment lines and bracket balance.

## Known and deliberately excluded behaviors

- Malformed annotated source, embedded NUL, missing separator and forged/trailing bytes are not accepted by this diagnostic contract. BF comma maps EOF to NUL and the framer cannot attest true host read completion or detect missing delimiters reliably. The host must reject these before execution. Such inputs may demonstrate unsafe behavior, never a conformance pass.
- App NUL input is unsupported for this raw relay; app `0xFF` is supported only if received before an eventual EOF, with actual bytes preserved until a zero byte.
- One-byte chunks can increase outer interpreter cost. Do not infer faster builds.
- The still-unbounded six-cell interpreter is not a safe arbitrary-guest executor, and `BF-in-BF -> same BF-in-BF -> actual compiler` remains unverified.
- Android SDK, packaging and device proof are deferred.
