# Stage A sixteen bit eight cell general loop interpreter evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Result: 1,160/1,160 local differential executions passed; 73 exact-byte fixture pairs saved, including all six real compiler applications. Both actual BF mini compilers now execute in this new interpreter and produce all six frozen raw AArch64 artifacts. This is not Stage A acceptance.** Android remains deferred.

## BF implementation and input contract

`src/source_pc_16bit_eight_cell_loops.bf` is an annotated eight-instruction BF program containing **25,296 executable BF commands**, SHA-256 `ca1d8ca3e3a3769a45d10a4875012fde11e397abe05227f8db9d13ebed662bd7`. It extends the preceding retained-source eight-cell executor with arbitrary nested nonzero `[` and `]` guest loops. Entire declared source is lexically and bracket-checked before any guest command. The interpreter scans source records forward or backward for a matching bracket at runtime, retaining guest cell state and remaining fuel across that movement.

Request: `u16le declared_normalized_source_command_count | u16le guest_original_instruction_fuel | exactly N normalized eight-command source bytes | guest comma input bytes`. The caller must provide physically complete input and separately establish trusted closure. Output: raw guest output bytes followed by one **provisional unframed diagnostic** byte, `00` success, `04` left pointer trap, `05` right pointer trap, `06` no remaining guest fuel, `0D` invalid or unbalanced source. Invalid source causes no guest output; fuel or runtime traps may be preceded by guest output. Guest tape: **eight distinct bytes**, with checked pointer bounds. Eight operations and nested loops are executed; the closing bracket on a nonzero cell branches to the instruction *after* its opening partner. Every executed guest command glyph incurs one fuel unit. The admitted bracket nesting depth is 255. Source length and fuel are 16-bit quantities; actual host tape and time limits remain finite.

## Verified local tests

| Scope | Result |
| --- | ---: |
| Fixed and randomized differential execution against a separate eight-cell oracle | **1160/1160 passed** |
| Saved exact input/output pairs created and independently replayed for differential tests | **67/67 passed** |
| Complete original and compact BF mini compilers on all three native-code examples | **6/6 passed directly through this new interpreter** |
| All exact-byte saved fixtures, including full compiler inputs and success byte | **73 fixture pairs** |
| Repository executable-source annotation and BF bracket grammar audit | **50/50 passed** |

Test seed: `20261025`. Fixed cases include full eight-byte-pointer boundary, binary NUL and FF input, EOF-to-zero, nested forward skip, nested backward nonzero loops, loop fuel, malformed suffix before any output, 255-bracket valid nesting and 256-bracket invalid nesting, and 255/256/515/1024/2049 source-length boundaries. The run also included exhaustive 256 one-byte source symbols, 550 randomized balanced-source candidates, 260 arbitrary-byte sources, and 60 wide-source trials. Historical eight-cell and six-cell compiler files remain unchanged.

## Complete mini compiler integration results

| Compiler | Input | Source commands | Raw AArch64 bytes | Diagnostic outer BF evaluator operations | Outcome |
| --- | --- | ---: | ---: | ---: | --- |
| original | tiny_app_a | 515 | 264 | 5,565,693,665 | Match |
| original | tiny_app_b | 515 | 272 | 5,710,276,126 | Match |
| original | held_out | 515 | 280 | 5,853,687,441 | Match |
| compact | tiny_app_a | 452 | 140 | 3,920,606,248 | Match |
| compact | tiny_app_b | 452 | 144 | 4,019,991,824 | Match |
| compact | held_out | 452 | 148 | 4,123,625,285 | Match |

Each native result was compared byte for byte against `artifacts/*.aarch64.raw` with a final separate interpreter status byte `00`. The outer grouped-operation counts are **diagnostic BF evaluator instruction counts**, not guest fuel or native throughput. The original compiler used 35,752 guest command executions on the first app, and the compact compiler used 23,910 by an independent reference trace; both fit the 65,535 maximum guest-fuel record. All six test requests use a provisioned 65,535 fuel budget. Output is still bare AArch64 instruction bytes: no ELF container or APK.

## Explicit negative host boundary probes

- `02 00 02 00 2B 2E 58` declares two source bytes `+.` with unconsumed trailing `X`: observed **`01 00`**, so complete physical-input closure was not established.
- `02 00 02 00 2B` declares `+.` but physically supplies only `+`: observed **`0D`**. EOF becomes zero and the component cannot independently authenticate that a physical byte was absent.
- `00 00 00 00 2B 2E` declares an empty program with extraneous trailing bytes: observed **`00`**. Guest stdin is not independently delimited or closed.

The new source preflight is for normalized BF command bytes; it does **not** incorporate the archive's annotated comments grammar and original-byte source-offset diagnostics. Its terminal status byte is not a COCK-FRAME-v1 authoritative result. A trusted input byte-count, stream/process completion and BF-owned frame routing remain requirements.

## Remaining Stage A blockers

The new single-layer integrated interpreter genuinely produces all six native-code payloads, but the mandatory **same interpreter → same interpreter → actual BF mini compiler** chain is **NOT TESTED / NOT VERIFIED**. Its eight guest cells cannot presently host an interpreter that needs more tape, and fuel/source-length bounds likewise constrain nested execution. A scalable checked/dynamic guest tape and expanded fuel architecture are still required. Strict BF-only *development-process* provenance is **NOT CERTIFIED** because temporary non-BF source-layout, oracle and C diagnostic evaluator programs were used **outside** the repository; no conventional-language executable source has been committed to the workspace. No independently qualified bootstrap has been shown. Full preflight/host closure authority, production ELF/native Android entry, APK signing and Android device testing remain incomplete or deferred.

**Next engineering priority:** extend this now compiler-capable eight-command interpreter with a checked scalable guest tape and wide execution fuel, while preserving the six full-compiler fixture comparisons and integrated source preflight. Then attempt the complete inner interpreter itself running the actual compiler, under one identical implementation at both levels.
