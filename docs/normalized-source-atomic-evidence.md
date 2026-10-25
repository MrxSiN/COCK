# Atomic normalized source handoff evidence

Date: 2026-10-24. **Diagnostic component only — Stage A remains unaccepted.** Android remains deferred.

## Implemented component

`src/normalized_source_atomic_gate.bf` buffers an entire bounded normalized eight-command source record on its own Brainfuck tape, verifies the eight-command alphabet, rejects premature closing and unmatched opening brackets, checks the required `A5` record guard, and **only after validation** emits the one-byte acceptance marker `01` followed by exactly the admitted command bytes. Any rejected record emits exactly `00` and no source bytes. It does not interpret or compile the source. The implementation uses original Brainfuck instructions with compliant inert annotations; no conventional source is placed in the repository.

The development record is `u8 length | length literal source bytes | A5`. A single record can contain 0 to 255 bytes. That is a **provisional per-invocation diagnostic interface** with a narrow encoded length; it is not `COCK-FRAME-v1`, a published ABI, or a permanent COCK source-length ceiling. A future full-size capability needs a separately verified repeated-chunk or complete-snapshot format with checked wide lengths. The record guard detects ordinary truncated-input substitution of EOF zero bytes, but cannot prove complete stream closure or authenticate a malicious sender.

## Executed diagnostic results

- **1,135/1,135** fixed, per-command length-boundary, seeded normalized-source fuzz and random full-byte source comparisons passed against a standalone external reference. Seed: `20261024`. For accepted records the byte-exact output was `01` plus the exact normalized input; for any invalid source or guard the full output was `00`. This caught and fixed an initial test-batch implementation defect: the hand-written guard comparison subtracted 185 instead of 165. The complete batch was rerun after repair and passed.
- **6/6** positive end-to-end diagnostics passed. For each of `tiny_app_a`, `tiny_app_b`, and `held_out`, the BF annotated-source gate admitted the annotated source, the BF normalizer produced its command stream, the new atomic gate admitted/released that stream, and the existing BF-in-BF reference ran the actual original and compact BF compilers. Their generated raw AArch64 byte arrays exactly matched all six unchanged frozen output artifacts.
- **4/4** additional annotated-source negative diagnostics passed (unsafe comment, inline comment, embedded NUL and unmatched opening bracket); the diagnostic coordinator did not call the compiler on those source failures.
- **5 targeted transport probes** verified that malformed suffixes, incomplete payloads, absent guards and wrong guards emitted `00`; however, a valid record with trailing bytes emitted exactly the same accepted output as the clean record. This is an explicit known limitation requiring trusted out-of-band closure.
- **16/16** tracked `.bf` modules, including the new one and the BF oracle, passed an outside-repository static check for compliant safe annotations, only eight executable command glyphs, and balanced brackets.

The source, the original and compact compilers, and the six old raw AArch64 artifacts remain available. The current component uses a locally installed *diagnostic* root BF evaluator rather than an independently qualified Stage A bootstrap. Outside-repository Python organized test inputs, launched the existing BF modules and compared literal outputs; it did not execute production transformations or become repository executable source. This is not evidence of a BF-authored test runner or trusted host router.

## Nonclaims and next gate

**Not yet accepted:** no single BF-owned transaction presently combines strict annotated lexical admission, source mapping and this normalized release step with host-verified complete-source closure; the diagnostic coordinator is external. No original-source byte offsets or complete status precedence are emitted. This new component does not implement the COCK interpreter, and it does not establish the required full bounded nested BF-in-BF execution of either real mini compiler. No Android SDK, emulator, ELF, APK, signing or device run is claimed.

The next appropriate bounded slice is a BF-owned sealed-source/session coordinator or a complete interpreter/compilation chain. It should reuse this pass/fail buffering property, expand beyond the single-u8 record by a supported input-session contract, and implement independent host-closure checks; no previously failing input may leak compilable instructions.

Reproducible input/output hashes and test scopes: `normalized-source-atomic-evidence.json`.
