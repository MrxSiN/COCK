# Stage A exact-source and completion draft

**Design only.** The integrated frontend, artifact framer and BF build driver named in the full inventory are not implemented. This document specifies their complete first-pass responsibilities without replacing missing code with prose. Frozen BFIO/BHIO definitions in the master prompt retain authority; no new public wire/profile version is introduced.

## One-source debug input

The invoking user selects exactly one source, one output root and the fixed Stage A target policy. The mechanical host opens the selected source under the allowed root, pins an immutable copied file or safe open handle, reads exact bytes, records actual count and read/close success, and passes those same bytes to the BF tool. Use one noninteractive sealed input; do not imply the buffered seed supports interactive BHIO.

The proposed narrow invocation record is `u64 source_size | u64 raw_source_budget | u64 command_budget | u64 native_byte_budget | u64 invocation_id | exact source bytes | A5`, all little endian. It is 41 plus source_size bytes. The five scalar fields are non-executable invocation parameters/physical count facts. The host may encode those facts and copy bytes; it may not parse or strip source, compute source semantics, generate native code, select modules or synthesize a successful producer result. The record is not a general build-input BFIO/BHIO session.

Before semantic admission, the BF frontend requires a nonzero invocation ID, checked representable `41 + source_size`, source_size within raw_source_budget, successful independent acquisition/closure, exactly the specified raw byte region, and its nonzero final guard. The guard detects truncation filled by EOF zeros; it does not authenticate a malicious producer or final physical closure. A true source read failure is HOST_READ_FAILURE phase transport. Oversize policy admission is GUEST_LOGICAL_BUDGET at preflight; an arithmetic overflow is CHECKED_INTEGER_OVERFLOW. Invocation budget exhaustion must never be presented as syntax error or silent truncation.

Every scalar is u64 at this interface. Any currently implemented downstream u16 address/count limit must be checked explicitly before narrowing and reported as an implementation capability limit, not a universal language/app limit. Do not guess a production default from prototype format widths. Initial configuration supplies per-job finite source/command/native budgets, plus independent outer memory/wall limits. Reject unsupported values before effects; record exact selected values in the invocation ledger.

## Source pass and original offsets

Retain the original raw bytes and a zero-based u64 original offset for each command. Exact empty source is syntactically valid. First validate all bytes/line forms in increasing original-byte order. Then perform complete bracket matching. Only after those passes apply the Stage A capability check. No guest input is consumed and no native payload is published on preflight failure.

Legal line forms follow Part 1 exactly: indentation is space/tab; a line starting with `#` after indentation is an entire printable-ASCII comment with no BF command character; a code line has only commands and space/tab; empty lines are allowed. Accept LF and CRLF, reject a bare CR as a forbidden line-ending control. An unterminated final code/comment line may be valid if every byte satisfies its line form. Reject NUL, DEL, BOM/non-ASCII, other controls, prose on code lines, inline comments and unsafe comment glyphs. For an invalid annotation character report its original byte offset; for prose or inline `#` on code lines report the first offending byte, not a later normalized position.

The first illegal-byte/line-form position wins even if an earlier bracket is unmatched. If all bytes are legal, the first unmatched closing bracket wins; otherwise report the earliest still-unmatched opening position. Balanced valid loops are syntactically legal even though the Stage A app capability rejects them. The source oracle must be independently structured, not a copy of the frontend's decision code.

After lexical/bracket acceptance, source records contain each normalized opcode and its original offset. Preserve command order and the complete immutable source identity. Admission is atomic: do not output an accepted command prefix while suffix validation is pending. Changed annotations may retain the same normalized stream, but they change raw source identity; do not reuse a provenance receipt for different bytes.

## Restricted app capability

For source size/command budgets that fit this invocation, require zero or more arithmetic operations followed by exactly one final dot, and computed modulo-byte output within `20..7e`. Zero arithmetic operations with one dot computes zero and is therefore unsupported under the printable policy. A final dot is a real original command and counts against command/execution budgets. Empty source is valid BF syntax but unsupported as a one-output Stage A application.

Return UNSUPPORTED_CAPABILITY at the first unsupported command's original offset for input, pointer movement or any balanced bracket instruction. If dot is followed by another command, report the following command's offset. For missing output or a nonprintable computed result, use the non-applicable offset `ffffffffffffffff`, with the independent diagnostic reason in the report. Malformed bracket sources retain syntax errors rather than capability errors. Arithmetic evaluation for admission must be BF-authored and verified against `tests/oracle.bf`; it is not a source-name lookup.

App native arithmetic is generated from every admitted arithmetic operation in order. Constant folding, compact final truncation and preserved per-operation truncation are separate documented compiler variants; do not silently switch semantics or implementation identity. Native generation does not grant general binary stdout, input, fuel, tape or loop support. Optional app execution-fuel behavior remains unsupported unless independently implemented; this loop-free profile uses finite compile-time command admission as its bounded-work policy.

## Native/artifact producer handoff

The BF build planner selects frontend, native generator, ELF writer and output framer, and binds the immutable source, policy, compiler/module identities and invocation ID across each. No external executable may implement the stage graph, select a success path from source semantics or supply app-specific native instructions. Single-source noninteractive operation avoids general multi-file routing, but still needs an actual BF-owned orchestration implementation before a usable build claim.

The artifact stage must retain the complete validated producer result in bounded tape or a BF-controlled staging spool before declaring success-path output. A producer failure before declaration may emit a terminal failure with no declared files; it cannot emit an empty successful artifact session. Never terminate a declared incomplete artifact with an early status and label the resulting invalid session complete. An interrupted/faulty stream after declaration is rejected with independent failure evidence.

Use one output declaration with nonzero file ID 1 and normalized relative path `lib/arm64-v8a/libcockstagea.so` (30 ASCII bytes). The full BFIO artifact-output grammar is mandatory for this selected draft. Emit declaration before any chunks, contiguous chunks beginning at offset zero, exactly one END with the actual final ELF byte count, and exactly one terminal status after END. Kind-05 payload is `file_id:u64 | offset:u64 | nonempty data`; kind-06 payload is `file_id:u64 | final_size:u64`. Chunk sizes are invocation buffer limits, not total ELF/app limits. Every frame has the exact version/kind/flags/u64 length/correlation fields and `A5` guard from Part 2.4.

The 30-byte-path declaration has payload length 46 and frame length 71. END has payload length 16 and frame length 41. Terminal status has payload length 36 and frame length 61. Check all u64 length/offset additions, duplicate declarations, wrong IDs, gaps, overlap, late chunks, repeated END/status and trailing bytes. A successful artifact-producing session cannot have an empty declared set. ELF validation may veto an otherwise valid frame stream.

The compiler terminal result is phase 2, not an app-execution result. On success its source offset is non-applicable. Application guest execution/input/logical-cell counters are zero because the app has not run; tool-interpreter counts, compilation work and predicted app behavior are recorded separately. Never present compile-time arithmetic evaluation as device execution. On preflight failure, return its error/phase/original offset and no finalized artifact; any prior staged bytes are discarded. On post-admission compiler/binary failure, emit the proper failure and abandon the candidate.

## Independent completion authority

The BF status authority must observe real tool-interpreter completion, every expected producer output and status, all required source/native/session checks, and no cancellation before issuing provisional OK. Guest output resembling BFIO/BHIO or `00` has no control authority. Root process exit, physical stdout/pipe/file write success, exact closed-file bytes, downstream package result and Android observation are separate facts.

The finalizer may expose a debug candidate only when its selected scope's required facts all agree. Complete bytes with nonzero process exit fail. Zero process exit with missing bytes fails. Good frames with appended bytes fail. Valid BFIO and unknown host close is UNKNOWN / NO-COMMIT. A failed or timed-out guest cannot authorize success by printing a status-looking sequence. A renamed path does not prove durability or output identity.

The permitted host can stage files and perform an OS rename under BF-selected paths after authorization, but it does not interpret program syntax or create production semantic receipts/hashes. Existing `sha256sum` is an independent identity verifier for development evidence, not a BF production hash implementation. A real production provenance/hash/finalization claim requires the corresponding BF-owned semantic implementation and independent physical evidence.

Retry from a fresh invocation/output stage after source mutation, read/write failure, timeout, cancellation or uncertain physical state. Never append to a failed partial stream or reuse its success/status. No real release key or production publication is part of this draft.
