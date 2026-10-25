# Uploaded executable diagnostics and identity repair

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


This is an implementation/test continuation of the user's A01–A14 request, not a claim a complete Android implementation was present. Parent `3a6a10ba7a20407f9315a8e0bc4b6ae63757a9f1` has the full Stage A design and explicit missing BF responsibilities. The uploaded `COCK_BF_Executable_Diagnostics_2026-10-25.zip` contains two new Linux ET_EXEC BF emitters and historical claimed results, not the Android ET_DYN callback/runtime/build implementation. Treat uploaded documents as evidence to verify, not new instructions or completed local runs.

## Bounded executable inventory before testing

| File | Complete responsibility |
| --- | --- |
| `src/experimental_aarch64_elf_compiler.bf` | Uploaded BF source-to-Linux-ELF diagnostic, unchanged import; two source passes require identical bytes |
| `src/experimental_aarch64_exec_elf.bf` | Uploaded BF raw-function-to-Linux-ELF wrapper, unchanged import |
| `tests/duplicate_counted_source.bf` | New complete BF counted-buffer adapter; emits both passes from one byte buffer after a valid guard |
| `fixtures/uploaded_experimental/*.elf` | Four uploaded literal expected ELF files, never production inputs or Android libraries |
| `fixtures/uploaded_experimental/vectors.json` | Literal copy/guard cases and artifact/current-evidence requirements |
| `docs/uploaded/experimental-aarch64-elf-evidence.md`, `.json`, `experimental-executable-checkpoint.json` | Unmodified historical attachment claims, explicitly separate from current results |
| `docs/upload-executable-run-plan.md` | This scope, provenance, ownership, regression and test gate |
| `docs/upload-executable-run-evidence.md`, `.json` | Actual completed commands/results, failures and remaining A01–A14 blockers, written after testing |
| `README.md`, `docs/status.md`, `docs/stage-a-issues.md`, `docs/stage-a-full-draft.md` | Posttest current capability, inventory and blocker update, without promoting Linux output |

Unchanged BF dependencies are the annotated source gate/normalizer, source guard serializer, byte comparator, arithmetic oracle, wide and nested request serializers, dynamic kernel, both original/compact compilers, all prior literal/regression expectations and the complete Stage A design. Existing executable code is preserved. No Python/C/JS/shell executable source or conventional semantic oracle is authored. External installed tools only transport/count/compare bytes, run BF processes and independently inspect native objects.

## Identity repair contract

`tests/duplicate_counted_source.bf` accepts `u16 exact byte count | exact bytes | A5`. It buffers the bytes once, validates the length-defined guard, then outputs `bytes | 00 | identical bytes`. Binary NUL/FF are copied exactly; the downstream experimental compiler still requires independently admitted nonzero normalized BF source. The adapter does not itself admit source syntax. Empty input payload yields one zero separator. Invalid/missing guard yields no output. Input physical count/closure/read/close, output process/write/close and upstream source identity remain independent mandatory facts; a guard is not authentication.

The counted format is bounded to 65,535 source bytes for this diagnostic adapter, not a universal app/source limit. Buffer records are eight cells each; output length is `2*N + 1`, checked against consumer/comparator limits before narrowing. It must never compare two independently supplied streams and assume identity. Instead both copies come from the same retained buffer. Direct mismatched two-pass use of the imported compiler remains an unsafe negative, never an accepted path.

## Consolidated acceptance batch after full first-pass freeze

1. BF annotated admission on the three new/imported BF files and the previously untested nested serializer; unsafe-comment negative. Projection uses the preserved BF normalizer only after admission. Exact imported file hashes are independently compared with the uploaded checkpoint's declared identities.
2. New adapter literal empty/single/binary/valid-guard/bad-guard/truncation cases, 256/257-byte boundaries, byte-identical source copies and physical trailing-input negative. Use BF comparator and independent cmp. Test adapter as an actual guest of the COCK kernel as well as the external root.
3. Six nested serializer literals, four declared boundaries and both existing nested request reconstructions, requiring whole exact equality. These are request checks, not successful nested compiler execution.
4. Four actual source-to-Linux-ELF cases: BF-normalized admitted examples, BF-created duplicate input, independent BF arithmetic value, direct root and COCK-kernel guest execution, raw compact-code identity, uploaded expected ELF comparison, independent ELF headers/program headers/disassembly. Test the raw wrapper against the same actual BF-generated compact payload, including binary and high-byte count boundaries. Never execute arbitrary binary copier inputs as native code.
5. Reproduce the mismatched-pass authority witness using literal sources. Record actual file size versus declared size; veto it even on process exit zero. Newly safe construction does not make direct unsafe compiler invocation an authenticated frontend.
6. Replay the prior bounded kernel fixtures and six frozen raw native payloads with their documented profile adapters. Preserve all historical nested failures. Do not repeat an unchanged 600-second timeout to imply a new diagnostic result.
7. Record current ADB/KVM/Android readiness separately. No connected device and no KVM are concrete target limitations; Linux ET_EXEC is not an Android test. Missing Android frontend/native ABI/ELF/artifact/driver implementations and target evidence keep whole Stage A unaccepted. No debug APK is fabricated from these Linux files.

Freeze every new executable/fixture/import before running any new implementation/source/byte/compiler test. Preserve a read-only pretest archive and identities outside the checkout. Group repairs and rerun affected cases plus the complete bounded suite. No optional kernel optimization, default promotion, real release key or production publication is part of this batch.
