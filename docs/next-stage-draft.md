# Next Stage A draft: reproducible nested proof inputs

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status: **DRAFT COMPLETE / UNTESTED**. This is a bounded development slice under Parts 22–23 of the master prompt. It prepares the missing dedicated BF nested-input driver; it does not repair the interpreter's execution cost or complete Stage A. The user requested drafting on 2026-10-25; implementation execution is deliberately deferred to the consolidated batch in [the acceptance contract](next-stage-acceptance.md).

The starting checkpoint is `a6fc6f9da9643e449b7f5239b0d48abab9cf7c51` on `codex/dynamic-kernel-candidate`. The last main checkpoint remains `defd60ff21a97c006a8e9a0b847f7146aaacb7b5`. Five bounded nesting attempts timed out. Their evidence and expected bytes remain authoritative historical inputs; this draft does not change those outcomes.

## Scope and decisions

The executable deliverable is one handwritten, annotated BF serializer: it takes independently counted interpreter, real compiler and application-input streams and constructs the exact two-level diagnostic request. Existing `tests/wide_request.bf` remains the general one-level serializer. The dedicated driver removes caller arithmetic for an aggregate nested guest-input length: each of the three payload lengths is supplied separately, and the driver places both headers. There is no second interpreter, compiler, comparator, source parser or native generator in this slice.

The resulting chain is external root evaluator executing outer kernel, outer kernel executing the identical inner kernel, inner kernel executing the actual compiler. The supplied interpreter bytes must be the BF-produced normalized projection of the exact kernel used as the root source. Identity is independently checked in the test batch. Calling the driver alone never executes this chain.

This is test infrastructure with provisional diagnostic transport. It does not introduce a BFIO/BHIO session, source ABI, document revision or production completion authority. It performs no syntax admission or semantic compilation. Literal noncommand bytes are permitted in serializer-only tests; those streams must never be presented as admitted compiler source.

Android remains AArch64 / `arm64-v8a` / API 35 with a planned NativeActivity callback and printable single-byte log observation. The SDK is installed. The Google x86_64 image advertised an ARM64 native bridge, but neither stable framework execution nor loading COCK ARM64 code was proved; ATD has no such bridge. There is no available validated Android execution target and no BF ELF/APK producer. See [current Android evidence](cloud-android-environment.md). This host-only serializer cannot establish A01 or Android usability.

## Frozen file inventory

This inventory precedes new executable source. All listed source and fixture content must exist before the batch opens.

| File | First-pass responsibility |
| --- | --- |
| `tests/nested_request.bf` | Complete three-payload request serializer, unsigned two-byte counters, binary-transparent transport |
| `fixtures/nested_proof/vectors.json` | Literal serializer expectations, sealed boundary data references, nested acceptance inputs and veto cases |
| `docs/next-stage-draft.md` | Scope, ownership, exact interfaces, file inventory, draft state |
| `docs/next-stage-acceptance.md` | Ordered consolidated batch, commands, budgets, expected results and stop rules |
| `docs/development-roadmap.md` | Dependency map for remaining Stage A and later B–F work; no later implementation claim |
| `README.md` | Discoverable draft and current-state links |
| `docs/status.md` | Separate five-state entry for this draft |
| `docs/next-stage-draft-checkpoint.md` | Physical pretest archive identity and documentary-only review record; written after archiving the other seven files |

Unchanged dependencies: `src/source_pc_dynamic_tape.bf`, both real `mini_compiler` sources, `src/annotated_source_stream_gate.bf`, `src/annotated_source_normalizer.bf`, `tests/source_guard_records.bf`, `tests/wide_request.bf`, `tests/byte_compare.bf`, `tests/oracle.bf`, the independent small BF interpreter, and all stored regression/native expectations. Existing nested fixture files remain byte-for-byte inputs, not regenerated goldens.

No empty future source, foreign executable source, script, CI recipe, generated native implementation or new optimizer is inventoried. The roadmap is a design handoff, not a bulk implementation of Stages B–F. Before any later capability, freeze its own exact files and full source draft.

## Driver interface

Every integer below is unsigned little endian. The fixed recipe is 18 bytes:

| Recipe offset | Bytes | Meaning |
| --- | ---: | --- |
| 0 | 4 | Outer guest original-command fuel |
| 4 | 2 | Outer logical guest-cell capacity |
| 6 | 4 | Inner guest original-command fuel |
| 10 | 2 | Inner logical guest-cell capacity |
| 12 | 2 | Normalized interpreter byte count N |
| 14 | 2 | Normalized compiler byte count M |
| 16 | 2 | Compiler stdin byte count A |
| 18 | N | Exact interpreter bytes |
| 18 + N | M | Exact real compiler bytes |
| 18 + N + M | A | Exact application-input bytes |

The complete expected stdout is:

```text
N:u16 | outer_fuel:u32 | outer_capacity:u16 | interpreter:N
M:u16 | inner_fuel:u32 | inner_capacity:u16 | compiler:M | app_input:A
```

Physical input length is `18 + N + M + A`; stdout length is `16 + N + M + A`. Each individual payload count may be 0–65,535, and total physical length can exceed 65,535. No sum is stored in a wrapping two-byte counter. These are diagnostic format bounds, not global application limits. Capacity zero preserves the kernel's meaning of 65,536 logical guest cells; the serializer copies fuel and capacity bits without interpreting them.

The driver emits no success byte and cannot report physical EOF, trailing data, read failure or process completion. The trusted mechanical caller must seal the input, attest counts/read/close independently, wait for process exit, and check exact stdout length/closure. EOF-zero BF input makes truncation intrinsically ambiguous. Driver stdout is provisional even if it resembles a complete packet. Unknown physical authority is **UNKNOWN / NO-COMMIT** for any production artifact.

The driver has a fixed 27-cell working tape, cells 0–26, and no guest interpreter. Cells 1–18 retain the recipe header; 20–21 hold one remaining count, 22 the byte, 23–24 copy scratch, 25 borrow flag and 26 loop flag. Each copy loop preserves NUL/FF, borrows into the high count byte and stops only at a zero pair. No input byte selects a host command, path or executable.

## Draft gate and state

The first-pass driver, literal expectations and all inventory documents are complete. A documentary review may inspect source text, file identities, tape paths, contracts and the diff; it must not execute the new source, source admission, a byte test, compiler, benchmark or device check during this draft. The pretest archive identity is recorded separately in [the checkpoint](next-stage-draft-checkpoint.md).

| State | Current meaning |
| --- | --- |
| DRAFTED | YES: all inventoried first-pass content is present |
| IMPLEMENTED | First-pass executable BF written; correctness UNVERIFIED |
| TESTED | NOT RUN for this slice |
| OPTIMIZED | NO |
| INTEGRATED | NO: candidate branch only; no default compiler changes |

No nested runtime retry is scheduled by this draft. The next batch first verifies the new driver and reconstructs the two historical nested requests exactly. A further full nested run requires a written changed-resource invocation under the acceptance contract. An unchanged 600-second timeout is not new evidence; a larger wall budget is not an optimization or a pass. A source redesign requires its own grouped repair inventory and pretest checkpoint. The Part 23 failed mandatory gate still forbids optimization and promotion.
