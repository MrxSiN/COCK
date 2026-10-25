# Integrated full compiler source preflight — local diagnostic evidence

**Engineering status:** Component diagnostics passed. Stage A is **NOT ACCEPTED**. Android remains **DEFERRED**.

## Implemented change

`src/bf_in_bf_six_cell_preflight.bf` is a new annotated eight-command Brainfuck interpreter variant. The previous `src/bf_in_bf_six_cell.bf` remains unchanged. The new kernel adds a per-source-command presence marker to the existing chunk loader, including for literal source NUL bytes. It inspects **every completely loaded normalized source command** before running any guest command. It checks the original eight-command alphabet, matching opening/closing brackets, first-invalid-byte precedence over unmatched brackets, and its declared 255-level nesting representation. Only after passing validation does it execute the unchanged interpreter dispatch algorithm.

The existing 12-outer-cell-per-instruction record layout is retained. Temporary fields propagate validation state through the records and are cleared before valid guest execution. An invalid command reports status `01`, an unmatched opening bracket `02`, an unmatched closing bracket `03`, and a nesting-depth overflow `0A`; such rejected source emits **no prefix guest output**. On admitted source, output is the original unframed raw guest stdout, with no extra status byte.

**This is normalized-source preflight only**, not the full annotated Part 1 original-source preflight. The single-byte error status is a development diagnostic; it is not a framed `COCK-FRAME-v1` status authority or a claim of independent host completion. An input containing extra bytes after an already-complete logical request cannot be authenticated by this BF program alone.

## Completed diagnostics

The locally installed outside-repository C Brainfuck diagnostic evaluator executed a consolidated test batch. There were **446 passing cases with zero observed differential failures**:

- 25 fixed cases covering empty source, binary input and EOF, byte wrapping, nested and clearing loops, pointer travel within the restricted six-cell tape, lexical precedence, malformed suffixes, literal NUL bytes, unmatched brackets, and depth 255/256 behavior.
- 415 additional seeded randomized malformed/finite program executions or admissible bounded programs; deterministic seed `20261024`. Cases beyond the declared six-cell semantics or explicit diagnostic termination budget were excluded from positive oracle comparisons.
- Six complete unmodified BF-authored mini compiler executions: original and compact compilers each run on all three established application inputs. All six raw AArch64 byte streams matched the **previously frozen** binary artifacts in the existing archive exactly. Outputs are 264, 272, 280, 140, 144 and 148 bytes respectively.

For the compiler cases the external BF evaluator used a high outer-executor instruction limit of 5,000,000,000 commands. **This is an outer interpreter limit, not COCK guest fuel**. An initial attempted 500-million-command limit stopped before completion and is not counted as a pass. The complete successful runs used between 834,563,852 and 1,230,986,552 executed outer BF instructions, depending on input.

25 paired non-executable binary input/expected-output fixtures are kept under `fixtures/six_cell_preflight/`. The JSON record includes exact output hashes, source hash, source-command count, case records, and observed local duration. All test coordination and the layout drafting aid remained **outside** the repository; strict BF-only development-process provenance is not independently certified.

## Explicit acceptance gaps and known limitations

1. Guest memory is **six logical cells**, with no runtime bound enforcement in this interpreter. Programs moving left of guest address zero or right beyond address five **must not** be admitted. The older conservative static safety gate remains separate; no arbitrary guest trust claim is made.
2. There is **no guest original-command fuel** or cancellation. A verified bounded tool input and external resource limit are still prerequisites.
3. Input is a provisional sequence of positive one-byte source chunk lengths, source bytes, a zero-length terminator, then unframed guest stdin. The BF interpreter cannot independently prove host byte counts, stream end, read error or process closure. **Part 2.7 host authority remains unimplemented**, as do the production `BFIO` / `BHIO` transport boundaries.
4. Original annotated-source byte offsets and full comment grammar are **not** supplied by this kernel. The prior annotated-source validation components are not magically integrated with it.
5. The six-cell guest tape still cannot execute this interpreter's own source. The required **same interpreter → same interpreter → real mini compiler** nested self-hosting proof remains **NOT VERIFIED**.
6. The emitted AArch64 files are still **raw machine words**, not Android ELF shared objects, debug or production APKs. No emulator or device test was performed.
7. Single-byte diagnostic errors are not authoritative framed status records and can numerically coincide with a valid raw guest byte; callers must know the independently verified invocation outcome.

**Next meaningful work:** replace the fixed six-cell guest tape with checked scalable storage in a general-loop, preflighted compiler-capable interpreter. Then run the actual compiler and test bounded same-implementation nested self-hosting; keep this and the old kernel as separate regression baselines.
