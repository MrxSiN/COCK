# Chunked atomic compiler handoff evidence

Date: 2026-10-24. Status: **COMPONENT DIAGNOSTIC PASSED / STAGE A NOT ACCEPTED**.

## Actual implementation

`src/chunked_atomic_compiler_handoff.bf` is 1,529 executable original Brainfuck commands. Its authored `.bf` source reads repeatable `u8 count | count raw source bytes` chunks, a zero length marker, and a required final `A5` guard. Its Brainfuck byte classifier validates only the original eight-command alphabet; its BF bracket-depth engine checks pair balance across chunk boundaries. The entire accepted source is buffered in BF guest tape memory; no loader instruction is released before completion. Accepted output is status `01`, then (`01`, source command) pairs, then the loader's zero end marker. Rejected output is precisely one status `00` and no source commands.

The output is **not** a complete build-input, BFIO, or BHIO protocol. The diagnostic host checker removes the leading status and mechanically forwards the exact remaining loader stream together with a separately validated arithmetic application input. This outside-repository step is **not** claimed to be the mandatory BF-owned production orchestration or a trusted source-closure adapter. The component neither parses annotations nor reports original source-error offsets.

## Consolidated test results

| Verification | Observed result |
|---|---:|
| Fixed, boundary and randomized exact-byte source admissions | **387/387 PASS** |
| Actual original and compact BF compiler via COCK six-cell BF-in-BF kernel | **6/6 exact raw AArch64 artifacts** |
| Repository BF annotation grammar and balanced-bracket audit | **25/25 PASS** |
| Invalid full-input cases leak source commands | **No observed leakage in covered cases** |
| Depth 255 balanced brackets | Accepted |
| Depth 256 and 257 | Rejected |
| Full source 515 / 452 commands | Both accepted, across 1-, 200- and 255-byte chunks |
| 1,024-command source | Accepted and emitted without truncation |
| Source trailing bytes after a valid A5 guard | **HOST CLOSURE BLOCKER**: BF component accepted prefix, host MUST reject |

The 387-case source check includes 180 seeded valid randomized command sequences and 180 randomized malformed or arbitrary command sequences, plus 27 fixed/negative/compiler cases. Seed `20261024`. The largest observed outer-evaluator operation count among those cases was 153,240,412. The local batch completed in approximately 11.16 wall seconds; this is a one-off diagnostic observation, not a controlled performance benchmark.

Output identity of all six frozen AArch64 candidates remains unchanged:

| Compiler | Program | Bytes | SHA256 |
|---|---|---:|---|
| Original | tiny_app_a | 264 | `04008592e9c873d3e8e9eaebeaed4000c55c85e78ff1bce5d2006c03b43365d3` |
| Original | tiny_app_b | 272 | `860d6f0bd7df32d0e93fc50268c25180ef2694b1df3f32c68fdbd23cb2d31624` |
| Original | held_out | 280 | `bbe379ca1beca74c941aebf057be95facc470a46b06f72933e05f9488c2de9c8` |
| Compact | tiny_app_a | 140 | `2a252722e1679156d109c8994f0fd0e9eb2f211a68e1f444c5a631ac9529601f` |
| Compact | tiny_app_b | 144 | `36af586b0929f05ef8bff362928d9e61ad494fe89a72eb2f2a88e902d845fbe6` |
| Compact | held_out | 148 | `76ae6e5ba3a154be3af547a0b8fc0d84b032188d86009f56da98ebe95e5fc12a` |

All candidate bytes were re-emitted using `src/chunked_atomic_compiler_handoff.bf` for instruction source admission followed by the unchanged `src/bf_in_bf_six_cell.bf` running the unmodified compiler. Original BF interpreter, both compiler source files, and all frozen binary artifacts were checked against their pre-slice ZIP contents and remained byte-identical.

## Reproduction and external boundary

For a test of the complete original compiler source using its frozen 200-command chunks, invoke the installed **diagnostic-only** external Brainfuck evaluator on `src/chunked_atomic_compiler_handoff.bf`, feed bytes in the documented length/chunk/guard format, verify process success and exact output bytes, then independently compare its output to status `01`, 515 one-byte source records and final `00`. To execute the actual native-code generator, remove the checked leading status from that output, append separately validated exact application-source bytes through a declared outside-repository diagnostic transport, and run `src/bf_in_bf_six_cell.bf` through the same evaluator. The full per-vector expected actual byte hashes and outer command counts are in `chunked-atomic-compiler-handoff-evidence.json`.

This run used `/tmp/cock_diag_root`, a locally built outside-repository evaluator with 8-bit cells, EOF-zero guest input and a 65,536-cell outer host tape. Its presence does NOT establish independently qualified bootstrap conformance. An outside-repository Python program generated *inert test records*, invoked the BF programs and independently compared bytes; none of that foreign-language code was incorporated into the repository or used as the production semantic transformation. The new component itself was drafted by adapting an existing BF-authored validator algorithm, using a mechanical outside-repository file editor. Certification of the specification's stronger BF-only development authorship/process remains incomplete.

## Explicitly unfinished gates

- Complete exact-byte annotated-source preflight, original byte-offset diagnostics and trusted host read count / last-byte / physical process closure.
- Full end-to-end COCK-owned build orchestration; app source relay and status separation were external diagnostic operations, not production modules.
- Arbitrary program support under the full dynamically growing COCK guest tape, exact fuel / pointer-boundary traps, and interrupt handling. One-byte nesting-depth representation makes depth above 255 unsupported by this intermediate adapter.
- Full required `COCK BF-in-BF -> second same COCK BF-in-BF -> real mini compiler` nested execution evidence. No same-implementation double-depth compiler run passed here.
- Android AArch64 shared library, native callback bridge, debug APK signing and emulator/device execution are deferred and **NOT RUN**.

A source record with valid content and A5 followed by extra bytes was accepted by the BF component. This is **negative evidence**; a compliant independent host MUST refuse such a non-closed stream. No APK, signed artifact, production release or completed Stage A milestone is claimed.
