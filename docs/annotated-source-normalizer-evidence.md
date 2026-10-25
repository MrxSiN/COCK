# Brainfuck authored source normalization evidence

Diagnostic date: 2026-10-24. Stage A acceptance: **NOT YET MET**. Android testing deferred because Docker/KVM/network are unavailable.

## Implementation and trust boundary

`src/annotated_source_normalizer.bf` filters any input byte stream to the original eight Brainfuck instructions in their encountered order, using eight independently expressed BF equality checks. It is annotated pure BF executable source: 2053 source bytes and 872 executable instructions; SHA256 `0246930a44280f9fde0fe91100a17dd8eefcffe333cd6b6a82e7d933c4eeaec1`.

This operation is a safe source transformation **only after** Part 1 annotated source preflight proves no command glyph is present in comment text, the supplied source bytes are exact and immutable, and independent host read-count/process/stream closure is successful. None of those facts is established by this filter's output. It terminates input on BF's EOF-zero and so cannot distinguish malformed embedded NUL from early EOF. It emits commands while reading, which must not be sent to execution as a production-authoritative stream before whole-source preflight and independent closure. It does not report first invalid original offsets and is not a production source loader or build coordinator.

The separate existing `annotated_source_stream_gate.bf` provides component-level syntax and bracket acceptance for its provisional guarded record transport, but lacks host source closure, original offsets, an in-process atomic handoff and normalizer coordination. These are **not** a completed normative preflight when run separately by the external diagnostic harness.

## Consolidated actual diagnostics

The new source was drafted after recording its complete file inventory and fixed acceptance vectors in `docs/annotated-source-normalizer-plan.md`. The test batch began after drafting the file and passive fixtures. Tests used `/usr/local/bin/cock-bf-diagnostic`, a local *nonqualifying* BF evaluator, with an external independent diagnostic harness; that harness was not placed in the repository or used to produce release artifacts.

| Diagnostic class | Pass | Checked behavior |
|---|---:|---|
| Frozen fixture byte comparisons | 8/8 | Empty, all 8 glyphs, LF/CRLF, whitespace, legal/illegal annotated examples |
| Individual byte projection | 256/256 | Every possible byte, with zero treated as an explicit unsupported raw-input boundary |
| Seeded valid annotated inputs | 300/300 | Command stream equality, arbitrary safe comments, LF/CRLF, tabs and spaces |
| All repository BF sources normalized | 11/11 | Exact command stream equality for each source |
| Actual compiler through BF-in-BF reference | 6/6 | Three apps through old and compact mini compiler, all six frozen machine-code outputs equal |
| Deliberately invalid annotated sources rejected | 3/3 | Separate BF syntax gate rejects embedded zero, forbidden comment instruction and inline comment |
| BF syntax gate followed by normalizer, same repository sources | 11/11 | Each existing BF file accepted and normalized identically on the diagnostic path |

**Total:** 595/595 component diagnostic cases. No case failed. This includes repeated checking of the same 11 repository files through two independent flows; these are not 595 independent semantic capabilities. The observed 3.79-second elapsed test period for the first group and 6.34 seconds for the additional source-gate group are diagnostic harness times and not compiler throughput benchmarks.

The compiler regression path was *host-orchestrated*. It fed this BF-produced command stream into `src/bf_in_bf_reference.bf` running the original and compact `.bf` mini compilers, then independently byte-compared the resulting raw AArch64 words with existing artifacts. That proves the new BF-owned normalization yields the existing compiler input bytes under diagnostic conditions; it does not turn the reference interpreter into a complete COCK-conformant self-hosted compiler.

## Explicit negative safety result

An invalid comment containing a BF command is rejected by the separate BF preflight, but this filter alone emits the command. Similarly, embedded `00` is not a detectable invalid byte inside its raw EOF-zero input mode. This is why the filter is a **projection** and cannot replace a preflight, trusted exact input authority, or a BF-owned verified handoff. Its output must stay provisional if transport closure is missing.

## Mandatory remaining gates

- BF-owned integrated preflight with exact source-byte offsets and Part 2.5 precedence; trusted exact byte count and host stream/process closure; deterministic no-commit after any failure.
- COCK-specific BF-in-BF tool interpreter implementing required guest semantics and budgets, executing the actual mini compiler through that interpreter (third-party single-layer diagnostic execution alone does not satisfy this).
- One bounded inner BF-in-BF executing the same actual compiler, matching exact output; prior attempt was resource-budget limited.
- BF-generated Android `ANativeActivity_onCreate` bridge/guest context/ELF and separately proven load/install/run; SDK, emulator and device still unavailable.

No SDK, emulator, APK, signing, Android code execution or production publication is claimed.
