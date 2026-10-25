# Annotated source streaming admission evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Diagnostic date:** 2026-10-24. **Result:** BF-authored lexical and bracket component passed 589/589 initial tests after repair plus 924/924 extended tests. This is **not** full COCK source preflight and does not complete Stage A acceptance.

## What was implemented

`src/annotated_source_stream_gate.bf` implements the Part 1 line-level annotated `.bf` source grammar for the selected **provisional development record interface**. It admits whitespace and eight-command code lines, printable ASCII hash-comment lines with no BF command glyphs, LF and CRLF, and balanced bracket nesting across records. It rejects invalid source bytes (including NUL, UTF-8/BOM and illegal comment text), stray CR, premature closing brackets, unmatched opening brackets, and nesting-depth overflow. Its checked-in executable logic consists solely of original Brainfuck instructions. An outside-repository one-time Python authoring aid expanded low-level Brainfuck instruction blocks during drafting; strict all-BF development-process provenance is therefore **NOT VERIFIED** and this component must not be promoted as proof that every authoring transformation was BF-owned. It emits one byte `01` or `00`, with no executable side effect from the admitted source. It does **not** emit normalized program bytes or source offsets.

**Input transport**: zero or more records of `u8 count | count literal bytes | A5`, count 1–255, followed by the `00 A5` terminal record. That record syntax is development-only, not `COCK-FRAME-v1`, `COCK-BUILD-INPUT-v1` or `COCK-HOST-IO-v1`. Arbitrarily many records are possible, subject to external resource budgets. The bracket-depth 255 limit is a declared *current implementation* bound, not a global COCK application/source cap. The terminal `A5` guards against EOF-zero substituted missing bytes, but **not** unobserved trailing stream data or a failed source read/producer exit.

## Consolidated diagnostics and repairs

The first batch ran 589 test cases. Six initially hit the default 300-million outer-instruction diagnostic limit on large implementation `.bf` sources, without yielding a semantic comparison, and one test had an incorrect chunk partition. The partition was repaired; a declared 5-billion outer-instruction diagnostic limit allowed the complete **589/589** rerun to pass. The larger batch initially uncovered a separate implementation defect: stale source-processing state could let a corrupted nonterminal guard pass. The flag was explicitly reset before every record guard comparison, and the complete suite reran. Two incorrectly specified adversarial test fixtures were also corrected in the course of that review. Final outcome: **924/924** extended cases passed, including:

- all 256 possible literal source bytes after a code prefix, and all 256 bytes after a comment prefix;
- seeded randomized annotated and malformed inputs, split CRLF and cross-record bracket handling;
- zero-length source, EOF/truncated/mutated guard records, nesting-depth 255 and 256 boundaries;
- the annotated source of every currently present Brainfuck implementation module;
- intentionally trailing extra bytes after a valid terminal record, confirming that the BF Boolean result alone **does not** detect a failed physical closure condition.

A separate source audit found **11/11** repository `.bf` sources legally annotated, command-only outside comment lines, and balanced as executable Brainfuck. **6/6** local replayed original/compact raw AArch64 outputs matched the existing frozen artifacts byte for byte. Neither compiler was edited for this slice. Source SHA-256: `dbb91920aab5a304e15efd22a194c495f1934cca85067c65a61188c7b896387a`. Extended test elapsed wall time: 5.443 s (includes diagnostic process launches and 924 heterogeneous cases; not a compilation-throughput benchmark).

## Reproducibility boundary

Execution used a locally installed outside-repository **diagnostic** Brainfuck evaluator, `/usr/local/bin/cock-bf-diagnostic`, with an outer-executor instruction budget environment value `COCK_DIAG_STEPS=5000000000`. Example when a test harness supplies **fully counted record bytes** on stdin:

```text
COCK_DIAG_STEPS=5000000000 cock-bf-diagnostic src/annotated_source_stream_gate.bf < records.bin > verdict.bin
```

That command is documentation for invoking an installed tool, not checked-in shell logic. An outside-repository differential reference and test harness supplied expected values and byte records; they are **not** BF-owned build orchestration, source serialization or proof of the independent root bootstrap. The source files and passive fixture JSON live inside the repository; outside code was not checked in.

The diagnostic interpreter's source/OS/pointer/fuel behavior is not yet qualified as the Stage A standards-only root evaluator. The Boolean output is provisional until a separately trusted host validates exact byte length, file-read/pipe/process completion and **no trailing bytes**. No case in this batch verifies physical host router closure. A bad source suffix is caught by this component if present in the supplied declared records, but the separate byte-count authority preventing undisclosed suffixes is not built. Production preflight additionally needs original source-byte error offsets, the Part 2.5 precedence rules, and BF-authored normalized-source handoff before guest execution.

## Status and next dependency

**Component:** DIAGNOSTIC PASSED for its declared subset and transport. **Full Part 2.7 source preflight:** NOT IMPLEMENTED. **COCK-owned BF-in-BF interpreter executing the real mini compiler:** NOT IMPLEMENTED. **Full nested interpreter/compiler proof:** NOT VERIFIED. **Android ELF/APK/device:** DEFERRED at user request. No Stage A milestone is accepted on this evidence alone.
