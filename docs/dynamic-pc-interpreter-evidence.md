# General program counter and checked dynamic guest tape — local evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Result:** LOCAL DIAGNOSTIC PASSED. **Stage A not accepted.** Android remains deferred.

`src/bf_in_bf_pc_dynamic_prototype.bf` is executable annotated eight-command Brainfuck. Its dynamic records preserve guest instruction bytes while the program counter scans forward or backward and carries tape bytes through a separate right-growing storage area. It executes arbitrary balanced loops in the tested bounded profile; no specially hardcoded clear-loop implementation is needed.

## Development-only invocation contract

Input is exactly one unsigned byte `N`, followed by `N` complete normalized BF source bytes, one unsigned guest-fuel byte, one unsigned maximum-logical-cell-count byte, and then unframed guest stdin. The source budget is 255 commands, the fuel budget is 255 executed original commands, and the current tape budget is 1 to 255 logical cells. These are **prototype record widths**, not universal COCK application limits. The output is exact raw guest bytes followed by one unframed diagnostic status byte (`00`, `01`, `02`, `03`, `04`, `05`, `06`, and `0D` where applicable). The final byte is not an authoritative `COCK-FRAME-v1` result record. An independent trusted host must report the exact source and physical stream closure. Extra trailing source/input bytes beyond the declared request cannot be authenticated by this BF code alone.

The semantic implementation validates every normalized source command before guest execution or output; first illegal source byte takes precedence over unmatched close, then unmatched open. A successful source loads the original command sequence and executes it using pre-execution fuel checks, modulo-byte arithmetic, deterministic left and logical address-budget traps, nested bracket dispatch, binary guest input and output, and zero on guest EOF. Physical allocation failure timing is host-dependent.

## Consolidated observed tests

- **1,616 / 1,616** independent semantic-oracle differential cases passed (seed `20261025`) under the declared input record. These include randomized finite or fuel-bounded programs, malformed sources, loops, tape travel, binary data, preflight precedence, and exact fuel cutoffs.
- **22 / 22** saved binary input/expected-output fixture pairs passed using the outside-repository compiled diagnostic BF evaluator.
- **6 / 6** frozen original and compact AArch64 raw outputs remained exact through the unchanged compiler-capable `bf_in_bf_six_cell_preflight.bf`. The new dynamic interpreter itself cannot admit the 515- or 452-command compiler source.
- Maximum-length tests at source length 255, 255 logical cells, and fuel 255 completed. The initial external limit of 50 million *grouped diagnostic evaluator operations* stopped six of those stress cases, so they were rerun with a declared 1.2 billion grouped-operation limit and passed. This is not guest fuel and not an Android measurement.
- The new BF source and existing repository source files underwent independent line-grammar and bracket checks. External drafting and test aids remained outside the repository and are not claimed as compliant BF-only development-source provenance.

The source and binary fixture hashes, exact cases, and limitations are recorded in the adjacent JSON report. No speedup, fully native compiler, production signing or Android functionality is claimed.

## Remaining mandatory work

The source-length and fuel representations must be widened beyond single-byte bounds to run the actual AArch64 compiler. The current dynamic-tape implementation is also not demonstrated to execute its own interpreter source, so the mandatory same-interpreter nested compiler proof is **NOT VERIFIED**. Original annotated-source byte offsets, independently established source/read/process closure, `BFIO`/`BHIO` trusted routing, complete COCK protocol status, physical allocation failure behavior, and Android target verification still require separate work. The original and compact mini compilers and earlier verified diagnostics have not been modified.
