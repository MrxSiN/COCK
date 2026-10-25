# Dynamic tape and wide fuel candidate evidence

**Status: component diagnostics pass; mandatory nested execution gate is BLOCKED. Not optimized, not integrated, not an accepted Stage A compiler.** The previous compilers, kernels, tests and six native artifacts remain unchanged. This candidate is saved on `codex/dynamic-kernel-candidate` for review.

## Implemented scope

`src/source_pc_dynamic_tape.bf` is a handwritten, annotated eight-command BF interpreter. It accepts a two-byte normalized source count, four-byte original-command fuel, two-byte logical capacity, source bytes and guest stdin. Capacity zero denotes 65,536 cells. Other capacities are their unsigned count. It performs complete normalized lexical/bracket preflight, all eight commands, nested loops, binary I/O, EOF-zero, modulo-byte cells, pre-effect fuel checks, and checked left/right moves.

Sixteen-cell records separate opcode, source-PC prefix, guest-pointer prefix, guest value, capacity marker and scratch fields. Capacity markers are prepared eagerly. Thus memory scales with the larger of source count and requested capacity, rather than a hardcoded eight-cell switch. This is a capacity-backed logical growing tape, not demand-paged physical allocation. The invocation widths are prototype constraints, not universal app-size or language limits. Highest explicit pointer-boundary fixture: index 256.

The output is guest bytes followed by a provisional status byte: `00` success, `04` left, `05` right, `06` fuel, `0D` invalid normalized source. This is not a new published protocol/ABI, authoritative BFIO/BHIO output, or a full annotated-original-offset frontend. Exact physical counts and closure remain external prerequisites; no production publication is authorized by this diagnostic byte.

## Draft and provenance

The inventory and literal vectors were written before implementation tests. All seven new BF files were complete before the test gate opened. The immutable pretest archive is `/workspace/test-results/dynamic-kernel/pretest-draft.tar`, SHA-256 `1163de71778b7f57ee4f1169d10c876916f4f2cf983ffbe5787f21cc9195563c`. The current kernel still matches the archived kernel exactly.

The annotated kernel is 12,118 bytes, SHA-256 `cd59d94bbf9dee3faea5c19ee62f2c5c910d13e01100769e29cbfeea8104ec82`. BF-owned projection produced 7,248 commands, SHA-256 `491fc291ad26316452416210d430b1cc5b78669ad1d1805133124bacfdc8c130`. The seven interpreter/test-tool implementations remain identical to the draft. The held-out input was selected and annotated afterward as planned; no source optimization was performed.

All new framing, comparison, fixture production and interpreter logic is BF. No Python/C/layout-generator or conventional semantic oracle was authored for this slice. The earlier external Python diagnostic scripts were not used. Installed POSIX tools supply physical counts, concatenate literal byte fixtures, compare/hash results and schedule invocations. The externally installed Tritium seed provides execution; its compiled backend's internal temporary host code is part of that external executor, not COCK-authored production logic. Historical development-process purity remains uncertified.

## Completed checks

Groups overlap and must not be added into a count of independent capabilities.

| Group | Outcome |
| --- | --- |
| New BF source grammar/bracket admission | 7/7 accepted by the preserved BF gate |
| Postdraft annotated held-out example | 1/1 accepted; normalized bytes match the originally selected literal |
| Deliberately unsafe comment | Rejected by the same BF gate |
| Literal kernel vectors | 30/30 exact byte matches |
| 257-cell growth and 256-cell trap | 2/2 exact matches |
| 256-level balanced nesting | Accepted; supersedes the older prototype's byte-sized depth rejection |
| Stored legacy request replays | 73/73 under the new profile: 72 unchanged expectations and one explicitly changed depth expectation |
| Independent BF common-profile comparisons | 19/19, including the postdraft ASCII held-out program |
| BF binary comparator self-tests | 5/5, including binary zero/FF and short/long actual streams |
| Additional BF comparator checks | 41/41; overlaps kernel/compiler groups |
| Real original/compact mini compilers | 6/6 frozen native payloads and success bytes matched |
| Postdraft held-out compiler outputs | 2/2 exact matches |
| Seed execution controls | Interpreter 32/32, DynASM JIT 32/32, compiled backend 33/33 |

The old BF source files and artifacts were unchanged against `defd60f`; this is not a fresh grammar audit of every historical multi-megabyte BF file. Repository inspection found 58 BF files: 50 unchanged legacy files, seven new implementation/test tools and one postdraft held-out example. No foreign executable source was introduced. New source admission used `tests/source_guard_records.bf` and `src/annotated_source_stream_gate.bf`. The kernel's guarded stream was 36,356 bytes, exactly three bytes per source byte plus the guarded terminator.

The core vectors include preflight before output, malformed suffixes, NUL and non-ASCII rejection, binary comma/EOF, zero fuel, trap priority, exact loop fuel, multi-byte fuel borrows, and a program requiring exactly 131,582 original guest instructions. The old `excess_depth` fixture has 256 balanced bracket levels: its former `0D` result reflected a one-byte depth limitation. The new independently specified result is `00`; the old fixture itself was not modified.

## Held-out and native inspection

After draft freeze, a new printable arithmetic source was selected: 34 additions, one subtraction, one final output. Its canonical annotated file is `examples/heldout_mixed_ascii.bf`, 418 bytes with SHA-256 `bccc0a4403154d03f7a584804676680922b6eac4ddfc5cf65ebf73d8f38cd241`. BF source admission accepted it, and BF-owned normalization exactly reproduced the originally selected 36 command bytes, SHA-256 `9ad47b43525e4bb901d44c5da726f1ddb5dd5d8503642587d48f6afefdacd134`. The independent BF arithmetic oracle returned `21` hex, ASCII exclamation. The new kernel and the independent small BF interpreter both produced `21 00`.

Both actual compiler sources were then executed as guests of the candidate. Original output: 288 native bytes plus status; compact output: 152 plus status. Literal expected data was composed from the previously frozen 34-addition prefix, the independently specified subtraction/mask words and frozen return words. This construction is a test expectation, not a production generator. Actual instructions were emitted by the unchanged BF compilers; no source-name table or host compiler supplied their output. The preserved BF printable-subset gate independently accepted this normalized held-out source and rejected `+.` for its nonprintable output. These remain separate component checks, not an integrated production frontend or an Android observation.

NDK LLVM independently decoded a short generated function as `mov w0, #0`, `add w0, w0, #1`, `uxtb w0, w0`, `ret`. It also disassembled the held-out native payload. To inspect raw bytes, `llvm-objcopy` made an inspection-only relocatable container outside the checkout. Extracting its `.text` reproduced the BF producer bytes exactly. This is not a BF-generated Android ELF, NativeActivity callback, loadable application or device execution proof. See `dynamic-kernel-native-inspection.txt` and `dynamic-kernel-heldout-disassembly.txt`.

## Mandatory nested execution failure

The complete normalized candidate was supplied as a guest of the same candidate, with 16,384 outer guest cells and 4,294,967,295 fuel units. Its guest stdin contained a complete real original or compact compiler request. The embedded 7,248-command inner source and its stdin were independently compared byte-for-byte with their BF-produced inputs. Expected results include native payload, inner status and outer status.

| Seed backend | Real compiler/input | Wall limit | Exit | Observed output |
| --- | --- | ---: | ---: | --- |
| Interpreter | compact / tiny_app_a | 300 s | 124 | none |
| Interpreter | original / tiny_app_a | 300 s | 124 | none |
| DynASM JIT | compact / `+.` | 600 s | 124 | `00 00 80` |
| DynASM JIT | original / `+.` | 600 s | 124 | `00 00 80` |
| Compiled backend | compact / `+.` | 600 s | 124 | `00 00 80` |

The final three runs reached only the initialization prefix; none emitted a complete source-dependent compiled result or both terminal statuses. Their expected short result was 18 bytes. They are **timeouts, not passes**, not guest-fuel violations, and not evidence of full nested self-hosting. Interpreter output was buffered; unbuffered physical stdout was used for JIT/compiled diagnostics. Partial producer output remains outside committed application artifacts. The short `+.` input is a raw compiler-component diagnostic outside the default printable Android observation profile; it is not counted as an admitted Android application test.

The design repeatedly traverses source and guest prefix chains for each guest command. Static cost scales with those positions and compounds under nesting. This identifies a performance concern; no measured speedup or definitive complete profile is asserted. The recorded single-layer compiler batch took 0.077–0.153 seconds per invocation, including process/setup costs under concurrent load; those figures are not an optimization benchmark.

Per Part 23, a failing mandatory nesting gate blocks optimization and integration. The candidate is retained for review, and the existing baseline remains available. Next work must resolve the nested execution budget/cost and rerun the exact checked outputs before promotion. Increasing a budget requires an explicit recorded invocation; partial prefixes cannot substitute for success.

## Invocation repairs and remaining boundaries

The first 30 vector invocations did not execute because `/usr/bin/time` was absent; Bash `time` replaced it, preserving the underlying command status, and all 30 were rerun. A mechanical comparison-header formatter initially emitted escaped text instead of binary count bytes. The BF comparator rejected all 41 malformed packets; the physical byte encoding was corrected and all 41 comparisons passed. No BF algorithm or expected semantic result was weakened.

A physically truncated source returned `0D`, while an extra unconsumed byte after `+.` left raw output `01 00`. These do not authenticate physical closure or the caller's source/input partition. Complete annotated offsets, authoritative framing, allocator-failure injection, root-bootstrap certification and historical purity remain unresolved. Android is NOT RUN: no BF-produced ELF/APK exists and the previously tested emulator is not a stable runtime. No signing, release or production publication is claimed.

## Reproduction

From `/workspace/COCK`, the component invocation is:

```text
/workspace/tools/bin/tritium -r -b -z -B -O1 -fno-negtape src/source_pc_dynamic_tape.bf
```

Provide one exact binary request on stdin. Frozen growth and held-out input/expected pairs are in `fixtures/dynamic_kernel`. Compare full stdout and process status, not a prefix. `tests/byte_compare.bf` reads `u16 expected length | expected bytes | u16 actual length | actual bytes`; physical counts must come from actual closed files. The independent external `cmp` is an additional veto.

For the failed nested compact reproduction, using the preinstalled external seed:

```text
timeout 600 stdbuf -o0 /workspace/tools/bin/tritium -q -b -z -B -O1 -fno-negtape -mem 2097152 src/source_pc_dynamic_tape.bf
```

Use `fixtures/dynamic_kernel/nested/compact.input.bin` as stdin and compare only a completed successful result with `compact.expected.bin`. Current evidence expects a blocked time budget on this host, not a passing smoke entry point. Compiled-mode reproduction replaces `-q` with `-r -c`; the old interpreter mode uses `-r`.
