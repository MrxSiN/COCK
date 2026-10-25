# Stage A atomic printable source admission evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date: 2026-10-24. Status: **diagnostic component verified locally; Stage A NOT ACCEPTED.** Android stays deferred at the user's request.

## Deliverable and scope

Two new tracked source files contain only annotated Brainfuck executable instructions:

- `src/stage_a_atomic_subset_gate.bf` admits a single normalized raw arithmetic source record of at most 255 bytes, requires exactly one final output instruction, checks a mandatory `A5` completion guard, buffers the complete source on its Brainfuck tape, and releases `01` plus the original command stream on success. Any rejected source produces only `00`.
- `src/stage_a_atomic_printable_gate.bf` adds a checked unsigned eight-bit arithmetic result and admits the source only when its result falls in printable ASCII `0x20..0x7E`. It preserves all source commands and their order rather than replacing them with lookup results. The computed byte itself is not transmitted; the compiler must still compile the admitted program.

The input development record is `u8 byte_count | exactly byte_count literal normalized command bytes | A5 guard`. It is deliberately **not** `COCK-FRAME-v1`, `COCK-BUILD-INPUT-v1` or any public protocol extension. The one-byte count is a bounded first-slice interface, not a global source or APK limit. The validators accept only `+` and `-` arithmetic followed by one final `.` command. Both permit a zero-arithmetic `.` token syntactically, but the printable validator rejects its zero result. The raw single-record format does not carry original annotated source offsets.

## Consolidated executed diagnostics

- **1,366 / 1,366** local raw-subset gate cases passed: 256 single-byte inputs, 18 fixed examples, 900 deterministic randomized bytes, 160 randomized positive arithmetic cases, 16 altered-guard cases, 12 length mismatches, and 4 deliberately appended-tail probes. The last four establish the *known closure gap* rather than successful closure verification.
- **1,620 / 1,620** local printable-subset gate cases passed: **256 / 256** arithmetic results spanning every possible byte value, 256 single-byte malformed/unsupported cases, 750 randomized byte strings, 320 randomized arithmetic strings, 14 fixed boundaries, 12 invalid completion guards, 9 mismatched length cases, and 3 deliberately appended-tail probes. The result computation preserves modulo 256 arithmetic; printable boundaries 31/32 and 126/127 were checked.
- **6 / 6** existing AArch64 raw-output artifact comparisons passed after the new printable gate: `tiny_app_a`, `tiny_app_b`, and `held_out` were each compiled by the **actual original or compact BF compiler** interpreted through the previously introduced BF-in-BF reference. The resulting exact byte arrays match the original six frozen artifacts (264, 272, 280, 140, 144, 148 bytes).
- **18 / 18** checked-in `.bf` files passed the external annotation grammar and bracket audit, including the two new modules.

The local diagnostic evaluator was compiled outside the repository from a conventional test program. Outside-repository Python also assisted during diagnostic source editing and supplied literal test records and comparisons; **no foreign executable source was included in the COCK repository**. The stricter development-process provenance rule is therefore **NOT CERTIFIED**, despite the repository source-language audit passing. This evaluator is not a separately independently qualified bootstrap, and the external coordinator is not BF-authored production build orchestration. The tests are diagnostic, not end-to-end COCK conformance acceptance. Input acceptance reference decisions and randomized seeds are externally computed in the diagnostic tool, not claimed to be an in-repository BF oracle.

## Important failures not closed by this work

1. **Trusted host closure:** a valid guarded record followed by extra bytes is accepted by the gate because standard Brainfuck input cannot reliably prove that no additional data remains. The intentionally appended-tail tests document this gap. Only independent exact host byte-count and successful stream closure can authorize an accepted invocation. An intercepted status byte, successful trailer, and absence of more visible data are not sufficient.
2. **Annotated-source admission:** the new gate takes already normalized source. The existing `annotated_source_stream_gate.bf` and `annotated_source_normalizer.bf` remain separate BF tools, but no single BF-owned multi-stage authority with reliable closure and source-offset errors has yet been implemented.
3. **Complete COCK guest semantics:** this is a deliberately restricted arithmetic input gate. It cannot admit pointer movement, loops or guest input, and does not replace a compliant full interpreter or runtime trap/fuel oracle.
4. **Self-hosting:** the BF-in-BF reference successfully ran the original and compact compiler in one layer. A COCK-owned complete interpreter and the required **outer interpreter, inner interpreter, actual mini compiler** full bounded test remain unfinished.
5. **Android:** no ELF shared object, native OS entry bridge, emulator, APK package, signing or device execution has been generated or verified in this slice.

## Reproducibility and storage

The new files are `src/stage_a_atomic_subset_gate.bf`, `src/stage_a_atomic_printable_gate.bf` and the inert evidence in `docs/`. Their executable command alphabets consist entirely of the original eight Brainfuck commands. Diagnostic runner source and compiled executables remain outside the repository. The unchanged frozen raw artifacts are retained under `artifacts/`; this ZIP is a source-development workspace, not an installable Android artifact.
