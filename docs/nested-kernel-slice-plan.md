# Nested compiler capable interpreter diagnostic slice

Status: planned inventory and frozen acceptance vectors before first test batch.

## Target

Demonstrate a nested BF interpretation chain with the existing COCK six-cell kernel as the *inner* BF interpreter, rather than the restricted arithmetic interpreter. The independently attributed BF reference supplies the outer interpreting layer. This is NOT same-implementation self-hosting and does not replace the mandated six-cell → six-cell → mini-compiler proof.

## Bounded file inventory

- `tests/nested_reference_transport.bf` — new BF-only, byte-exact, chunk-counted diagnostic transport writer. Its output is `inner_BF_source || 0x21 || inner_stdin`; no compiler transformations.
- `fixtures/nested_kernel/` — inert exact input and output binary fixtures and a JSON vector list.
- `docs/nested-kernel-evidence.md` and `.json` — observed results, hashes, limits and negative claims.
- `README.md` and `docs/status.md` — capability status; all previous sources and raw code artifacts must remain unchanged.
- `COCK_Stage_A_Engineering_Workspace.zip` — updated archive after testing.

## Transport

Input consists of 0 or more source chunks (`u8 count` nonzero followed by exactly that many ASCII BF opcodes) followed by a zero count, then 0 or more binary payload chunks (`u8 count` nonzero followed by exactly that many literal bytes) followed by a zero count. No protocol version claimed. BF output concatenates the source bytes, a literal ASCII `!` separator, and exactly the payload bytes. An independent host must supply exact input length, check actual process/transport closure, and reject additional or truncated bytes; the BF adapter does not establish those facts. The two zero chunk terminators are *not* source bytes or data bytes. This adapter does not validate annotation grammar or brackets; only already admitted normalized source is eligible.

## Exact planned positive cases

1. Source `+.` and inner six-cell request `01 + 00`: direct reference executes six-cell kernel which emits `01`.
2. Source `+[-].` and inner request: emits literal `00`.
3. Source `,.` with raw guest byte `FF`: emits literal `FF`.
4. Source `,[-].` with raw guest byte `00`: emits literal `00`.
5. Source `>++<+>.` with zero guest input: emits literal `02`.
6. Source and payload packets with 0x00, 0x21 and 0xFF bytes: exact transport relay (not source admission).
7. A source longer than 255 bytes: exact chunking without truncation.
8. Existing compact and original compiler inner input fixtures: byte-identical transport request with BF adapter, but full nested compiler execution only if it completes within diagnostic resource budgets.

## Negative / blocked

- Appended bytes following a terminal zero count are invisible without trustworthy host closure. The adapter must not be claimed as production source preflight.
- Six-cell kernel cannot execute itself under its six-cell guest tape model because its source uses greater pointer travel. This slice does not claim the mandatory same-interpreter nesting.
- No SDK, emulator, Android ABI, signing or APK claim.

## Test phases

Complete the first draft and inert fixtures, then run one consolidated test batch, collect results, repair as needed, and rerun frozen compiler-regression hashes. No optimization is authorized without a passing baseline.
