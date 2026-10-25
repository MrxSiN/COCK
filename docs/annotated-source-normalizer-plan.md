# Annotated source normalization bounded slice

Status when inventory frozen: DRAFT, NOT TESTED. No Android SDK or device capability is claimed.

## Complete first pass inventory

- `src/annotated_source_normalizer.bf` is the Brainfuck authored projection from one prevalidated annotated source byte stream to its eight command sequence.
- `fixtures/annotated-source-normalizer-vectors.json` is passive expected output data, including a deliberate rejection boundary.
- `docs/annotated-source-normalizer-evidence.md` and `.json` will record actual diagnostic results and limitations only after consolidated testing.
- `README.md` and `docs/status.md` receive status updates only after tests.
- `COCK_Stage_A_Engineering_Workspace.zip` packages the resulting files and earlier unchanged artifact candidates.

## Deliberately narrow interface

Input is the exact, complete *already admitted* annotated source bytes as raw BF stdin. Output is the eight command subsequence only, in original order. The component does not identify comments, validate syntax, verify input length, record original byte offsets, or report authoritative success. Those tasks remain with the strict annotated source preflight and trusted physical closure interface. Because legal Part 1 comments are forbidden from containing any Brainfuck command glyph, a simple eight glyph filter is semantics preserving AFTER successful source admission. The raw stdin path is a temporary diagnostic mode, not an accepted production build interface. Source preflight and physical closure MUST happen first, and emitted bytes must be quarantined until checked.

Any attempted use of this tool to normalize malformed source is unsafe and explicitly unsupported: for example a forbidden command in a comment would be emitted. A zero byte terminates this diagnostic BF read path, so malformed embedded zero cannot be reliably recognized by the tool. Source validity and exact byte count cannot be inferred from its output. Each byte in the output must still be bound to a validated, immutable source snapshot.

The initial algorithm uses eight independent equality checks against original ASCII command byte values 43, 44, 45, 46, 60, 62, 91, 93. Its outer evaluator must provide wrapping unsigned byte cells and zero on EOF. It is intentionally a baseline, with no optimization or output buffering before independent acceptance.

## Acceptance vectors and test batch to run after first draft

- Validate legal annotated LF and CRLF inputs, comment syntax, spaces, tabs, code and all eight command glyphs in original order.
- Exercise each possible nonzero byte as a diagnostic projection oracle without treating invalid byte examples as admissible COCK source.
- Run seeded random valid annotated source inputs against an outside repository independent extraction oracle for the diagnostic path only.
- Run exact example annotated inputs through this BF normalizer and the already existing BF in BF diagnostic compiler to compare frozen raw AArch64 bytes.
- Verify deliberate malformed source is rejected by the BF annotated source gate even though this narrow normalizer would project glyphs, proving that the two components cannot be replaced by the projection alone.
- Reaudit all repository Brainfuck source files for annotated grammar and matching brackets.
- Preserve full source and output hashes and record actual test failures; no Stage A acceptance without external closure, COCK native interpreter and full nested compiler evidence.
