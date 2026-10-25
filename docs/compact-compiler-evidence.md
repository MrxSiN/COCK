# Compact arithmetic compiler diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date: 2026-10-24. **Component diagnostic passed, Stage A acceptance remains unverified.** Android, NDK, SDK, emulator and device work remain deferred at user direction.

## Implemented new component

`src/mini_compiler_compact.bf` is an additional authored eight-command BF compiler. It consumes the already-admitted normalized Stage A single-cell arithmetic subset with a final output command, and writes source-dependent **raw AArch64 instruction words**. It emits one 32-bit AArch64 add or subtract per source arithmetic command, then one end-of-function unsigned-byte reduction rather than reducing after every command. This local rewrite is equivalent for a straight-line, no-guest-fuel, no externally observable intermediate-value arithmetic run because reducing at the end modulo 256 gives the same low byte even after 32-bit register wrapping. It is NOT enabled for full COCK guest semantics or active guest-fuel limits. Neither raw output is an ELF shared object or APK.

## Batch results

- **7/7 fixed emission and arithmetic vectors passed.** Separate fixed fixtures include subtraction, wrapping and zero arithmetic output. Nonprintable results in those particular fixtures are emitter diagnostics only, not valid printable Stage A application admissions.
- **1,200/1,200 seeded variable-length sources passed** exact independent raw instruction-byte expectations, with plus and minus runs through 191 arithmetic commands; deterministic seed `20261024`. This proves native byte emission correspondence for the inspected patterns but not actual native execution.
- **3/3 compiler-through-third-party-BF-in-BF reference interpretations passed**, with byte-identical raw outputs compared against direct diagnostic runs.
- **5 AArch64 words matched the installed Clang assembler's ELF object text**, for init, increment, decrement, end mask and RET. Clang was used solely for independent verification, not for COCK production code generation.
- **3/3 original raw-code artifact regressions passed**, byte for byte against the pre-existing 264-, 272-, and 280-byte candidates; original compiler code and artifacts were not replaced.
- **12/12 repository BF sources passed source syntax and balanced-bracket audits.** This is an independent diagnostic audit, NOT the BF-authored production preflight gate.
- **10/10 raw-source admission gate examples passed** in independent direct BF diagnostics: 3 printable apps admitted and 7 malformed/unsupported/nonprintable sources rejected. These are two separate local component invocations, not a production-validated coordinated compiler pipeline.

## Byte-size comparison

| Source | Original raw AArch64 | Compact raw AArch64 | Reduction |
| --- | ---: | ---: | ---: |
| tiny_app_a | 264 B | 140 B | 46.97% |
| tiny_app_b | 272 B | 144 B | 47.06% |
| held_out | 280 B | 148 B | 47.14% |

Every size here is a directly observed binary length. No APK, installed footprint or OS cold-launch size is measured.

## BF-in-BF interpretation runtime diagnostic

13 standalone fresh process invocations per generator and example were recorded: the first 3 and the remaining 10 are reported separately to avoid disguising cached or incremental behavior. There was no cache or retained running compiler across these samples. Times are **diagnostic external root evaluator process plus BF reference interpreter plus BF-authored compiler**, not native AArch64 target runtime and not an Android compilation benchmark. Median wall clock seconds:

| Input | Original first 3 | Compact first 3 | Original next 10 | Compact next 10 |
| --- | ---: | ---: | ---: | ---: |
| tiny_app_a | 0.421 | 0.247 | 0.431 | 0.240 |
| tiny_app_b | 0.455 | 0.260 | 0.425 | 0.271 |
| held_out | 0.452 | 0.275 | 0.428 | 0.265 |

Raw samples, hashes, exact test names and target machine-word bytes are retained in `docs/compact-compiler-evidence.json`.

## Candidate binary receipts

| Program | Generator | Bytes | SHA-256 |
| --- | --- | ---: | --- |
| tiny_app_a | compact | 140 | `2a252722e1679156d109c8994f0fd0e9eb2f211a68e1f444c5a631ac9529601f` |
| tiny_app_a | original | 264 | `04008592e9c873d3e8e9eaebeaed4000c55c85e78ff1bce5d2006c03b43365d3` |
| tiny_app_b | compact | 144 | `36af586b0929f05ef8bff362928d9e61ad494fe89a72eb2f2a88e902d845fbe6` |
| tiny_app_b | original | 272 | `860d6f0bd7df32d0e93fc50268c25180ef2694b1df3f32c68fdbd23cb2d31624` |
| held_out | compact | 148 | `76ae6e5ba3a154be3af547a0b8fc0d84b032188d86009f56da98ebe95e5fc12a` |
| held_out | original | 280 | `bbe379ca1beca74c941aebf057be95facc470a46b06f72933e05f9488c2de9c8` |

## Remaining mandatory gates and explicit negative claims

1. Complete annotated-source admission from true complete original bytes with original offsets, trusted length and closure, bracket matching and error precedence is **NOT IMPLEMENTED**. The existing printable gate consumes only restricted pre-normalized raw-source records and cannot certify its own host close.
2. The local outside-repository diagnostic BF executor is not independently qualified as the Stage A root. The imported BF interpreter is independently BF-authored but does not supply COCK source preflight or complete locked traps and guest fuel.
3. **One level of reference BF-in-BF executing a compiler passed.** A **second inner interpreter running the entire compact or original mini compiler has NOT passed**. Earlier full nested tests stopped on an outer execution budget/time limit. The existing original `src/bf_in_bf.bf` remains limited to arithmetic guest programs.
4. The compact compiler alone does not implement complete native guest-entry ABI, target ELF, Android `ANativeActivity_onCreate`, debug packaging or device observation. Raw AArch64 machine words are candidates only.
5. While deferring the Android target, no release, APK-signing or production capability is claimed. The original regression baseline remains available without modification.

Consolidated diagnostics used outside-repository Python strictly for test inputs, independent byte inspection, host process invocation and inert evidence recording; it was NOT added as executable source to the COCK repository and does not implement COCK production compilation or application transformations. All produced candidate native instruction bytes were emitted directly by the BF-authored compiler and merely persisted by the host.
