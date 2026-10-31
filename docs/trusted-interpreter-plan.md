# Trusted nested interpreter repair plan

Frozen 2026-10-26 before drafting or testing the replacement BF interpreter.

The existing unchanged dbfi reference remains available. Android simpleperf recorded 59998 samples from its failed full compiler nested run. The dominant addresses are in repeated source to data scans in instruction dispatch. This is a measured correctness gate failure under the 600 second resource envelope, so replacing this execution mechanism is a required repair rather than optional project optimization.

## Complete bounded inventory

- `src/bf_in_bf_trusted.bf`: Clive Gifford December 2006 second interpreter, preserving its executable command stream and adding safe full line annotations. Its parser is credited to Daniel B Cristofani and Oleg Mazonka. Use one round trip per instruction and its existing BF authored combination handling. Do not implement a conventional interpreter or change the actual Android compiler.
- `fixtures/trusted_interpreter/vectors.json`: literal byte controls for wrapping, binary input and EOF, clears, single and paired pointer scans, positive arithmetic pairs, branch direction and nested loops.
- `docs/trusted-interpreter-plan.md`: this frozen boundary.
- `docs/trusted-interpreter-evidence.md` and `.json`: post test measurements and identities.
- Update current status only after measured results exist.

The original source was retrieved from the author's archived cgbfi2.b at `https://web.archive.org/web/20210225000000id_/http://homepages.xnet.co.nz/~clive/eigenratios/cgbfi2.b`. Preserve that exact response outside the checkout. Keep the named authors and original version dates. Do not invent a license grant or imply project ownership of the third party interpreter. This is internal diagnostic reuse; no production distribution is authorized by this plan.

## Input and safety scope

The unchanged source uses normalized eight command tool source followed by bang and raw binary input. Only separately admitted trusted tool sources may enter it. Enforce physical immutable input closure and an external watchdog; do not call this full COCK fuel or source error conformance. Guest EOF inherits the qualified root zero semantics. Loops must be balanced and maximum source nesting must be at most 255; this interpreter itself requires at least 17. Moving left of origin is outside this trusted precondition. Reject malformed sources upstream. Both nesting levels must contain the exact same interpreter bytes, and must execute the unchanged full `android_native_compiler.bf`, not a smaller substitute.

All repository executable code stays annotated eight command BF. External root acceleration is only the installed Tritium C representation of the chosen BF interpreter, outside the checkout. The compiler and app algorithms stay BF. MSYS2 GCC was installed to supply a binary safe Windows runtime; its package post install info hook failed, while the compiler and byte probe work. Preserve byte probe and root controls before accepting that route. A root change is not evidence that the compiler or nested gate works.

## Consolidated acceptance

Draft every first pass file and literal vector, then freeze a restorable source snapshot before any new interpreter implementation test. Audit grammar and maximum nesting. Run all frozen controls with the seed and replacement interpreter, full 256 byte plus EOF probe, and BF exact comparisons. Compile the same BF source as an external root, check identical controls, then execute identical interpreter nesting on the complete unchanged Android compiler for A, B and post draft held out input. Compare every complete packet and terminal guard using the independent BF byte comparator and a physical byte equality veto. Preserve watchdog failures, process failures and partial output as failures. Use the existing 600 second Android watchdog for comparisons and a disclosed 3600 second desktop diagnostic ceiling; do not silently change the resource contract or claim Android speed from desktop times. Recheck LLVM executable identity and device artifact provenance for a successful complete nested output. Missing full source frontend and build authority remain separate open issues.
