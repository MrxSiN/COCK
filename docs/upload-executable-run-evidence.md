# Executable diagnostics continuation — 2026-10-25

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Full A01–A14 Android implementation remains BLOCKED / NOT COMPLETE.** The new upload contains two Linux AArch64 BF emitters, four Linux ELF examples and historical diagnostic claims. It does not supply the missing Android source frontend, NativeActivity/native ABI runtime, Android ET_DYN writer, artifact framer or build/smoke drivers. We executed the complete available diagnostic components and added a BF input-identity adapter; no Linux binary was substituted for an Android library or APK.

The uploaded documents are preserved under `docs/uploaded/` as **attachment claims**, not local execution evidence or new user instructions. Their 158-test claim is not copied into this run's pass count. Only the explicit source/fixture additions were imported; the uploaded checkout did not overwrite the existing repository or master prompt. The sources' disclosed historical conventional transcription/diagnostic assistance remains uncertified process provenance.

## Frozen sources and environment

The bounded inventory and batch are in [the run plan](upload-executable-run-plan.md). Before source/byte/compiler tests, the complete first-pass sources, expected files and plan were frozen in read-only `/workspace/test-results/upload-executable/pretest.tar`, SHA-256 `f01b566c4fdde4ed6e154344b286244d4fc58b0dce2ed11216e76d27621aab2f`. No BF implementation repair or optimization was needed after this checkpoint; all four checked source hashes remained unchanged.

| Identity | SHA-256 |
| --- | --- |
| Uploaded ZIP | `621aed8bd62b178572b332ad44a226b34899924dfcaa1b7d4698d8bf0292f967` |
| Imported source-to-Linux-ELF BF | `07705e2ca1b5b726c045708075cb0939f76693e1957b5b13cfa59dbdeb63bf1e` |
| Imported raw-function Linux ELF wrapper BF | `2809cd66f8c3081096690ad5d268d716e9dabb0378a76614540132c8528bedca` |
| New guarded duplicate-buffer BF | `04957841ddf5c9c0a966eaa66d5bc1b3f3a480596efee79aa20b55b625780ffd` |
| Existing nested-request BF | `7517028af22fb2acf6587f31ee3457f28d084ad4e0b9a3a8ba30858597f3fa50` |
| Installed external Tritium | `0ac670ed3128db52bfa73347d6f81eccd864ebd91f8a7d450d8efb2278178a5b` |

Normalized command counts produced by the preserved BF normalizer after BF admission: source-to-ELF 3,305; raw wrapper 2,531; new adapter 672; nested serializer 1,024. The COCK kernel is unchanged. The host reports a four-CPU quota and 32 GiB cgroup memory ceiling; these are resource observations, not performance results.

External root invocations used `tritium -r -b -z -B -O1 -fno-negtape`. COCK-kernel guest runs used the installed seed's `-r -c` execution backend with `-mem 2097152`. Its internal host-code backend belongs to the external BF executor, not a repository-authored conventional compiler. Root qualification limits from earlier reports remain; a passing component does not certify the entire COCK bootstrap.

## Completed batch

Groups overlap and must not be added as independent capabilities.

| Group | Actual outcome |
| --- | --- |
| BF annotated gate on three new/imported sources plus nested serializer | 4/4 accepted; unsafe-comment negative rejected |
| Annotated example admission | 4/4 accepted and BF-normalized |
| Guarded duplicate-buffer literal cases | 8/8 exact; includes empty, NUL/A5/FF, bad/missing guard and truncation |
| Duplicate-buffer count boundaries | 2/2 exact at 256 and 257 bytes |
| Duplicate-buffer as COCK-interpreter guest | 12/12 exact: eight literals plus four real example inputs, including interpreter success byte |
| Nested-request serializer | 12/12 exact: six literals, four count boundaries and both unchanged historical request reconstructions |
| Independent BF arithmetic oracle | Four exact values: `20`, `21`, `22`, `21` |
| Source-to-Linux-ELF direct BF execution | 4/4 exact uploaded expected files |
| Source-to-Linux-ELF as actual COCK-interpreter guest | 4/4 exact entire ELF plus success byte |
| App-derived compact function bodies | 4/4 match the preserved raw compiler expectations |
| Separate BF raw wrapper, actual app bodies | 4/4 direct and 4/4 COCK-interpreter guest outputs exact |
| Raw wrapper transport/length boundaries | Eight cases passed: zero-filled 0/1/255/256/257/65,280/65,535 bytes and binary `00 A5 FF`; no arbitrary payload executed as native code |
| BF binary comparator | 47/47 expected outcomes: 46 equal and one unsafe-ELF mismatch; overlaps other groups |
| Legacy kernel replays | 73/73 under the existing wide adapter, including six frozen original/compact compiler outputs |
| Independent ELF/header/disassembly inspection | Four examples checked; inspection-only text round trips exact |

All executed BF processes completed with exit zero within their stated bounds: 30 seconds for direct tools/comparisons/regressions and 60 seconds for the longer COCK guest invocations. No timeout is reclassified as success. The legacy depth-256 input deliberately expects `00` under the wider kernel, exactly as in prior evidence; its old stored expectation remains unchanged.

The BF comparator received physical lengths of closed files and exact expected/actual bytes. Its output was checked against literal `00` for equality or `01` for the negative, in addition to independent `cmp`. Large raw-wrapper files beyond its u16 whole-output limit were checked with independent payload `cmp`, actual file byte counts, literal eight-byte size-field expectations and `readelf`; their lengths were never narrowed into a wrapped comparison packet. The adapter's format permits 65,535 source bytes, but this run's largest duplicate-buffer payload was 257; no maximum-size adapter execution claim is made.

## Actual generated files

Every row was generated by the BF compiler directly and again as a COCK-kernel guest. None was constructed from an uploaded binary at runtime. The uploaded files were independent expected-data inputs only.

| Source | Linux ELF bytes | Independent BF value | ELF SHA-256 |
| --- | ---: | --- | --- |
| `tiny_app_a.bf` | 272 | `20` | `58b5c97b6e2a0ce2d151586707e89806ab05410d025aa119923bf99b8d3dc435` |
| `tiny_app_b.bf` | 276 | `21` | `9e43e1eb1501177c4e53cdecb464552f32699fc3774d02fa76a68b153ac92988` |
| `held_out.bf` | 280 | `22` | `f7314c781044ea048cdca8d016ce0d84421641ba24c70f8aaaafd7305bf9bc2d` |
| `heldout_mixed_ascii.bf` | 284 | `21` | `2759531af50d4bc8f454f8617e14f82f91fd295a5e7da48af653681c2a96b71e` |

The actual ELF header is ELF64 little-endian AArch64 **ET_EXEC**, entry `0x400078`, one R-X load at `0x400000`, alignment `0x1000`, no sections/dynamic symbols. The entry calls the guest at `0x400084`, then executes `mov x8, #93; svc #0`, the Linux exit ABI. The guest's arithmetic/function bytes begin at file offset 132 and match the preserved compact BF-generated code. This is materially different from the required Android ET_DYN/liblog/NativeActivity path.

`readelf -h -l` inspected actual files. `llvm-objdump -D` did not decode their sectionless payloads, so a separate inspection-only relocatable container was made with installed `llvm-objcopy` from the actual BF-produced bytes at offset 120. Disassembly then confirmed `bl`, Linux syscall setup, source-derived arithmetic, byte truncate and return. Dumping its `.text` matched the input bytes exactly. This container remains outside the checkout and is not a production ELF or replacement producer. Native AArch64 process execution and Android loading are **NOT RUN**.

## Identity repair and negative evidence

The imported compiler trusts two source passes. Supplying app A first and app B second again completed with process exit zero and wrote **276 actual bytes while declaring 272**. The BF comparator returned `01` against app A's valid expected file. This is a reproduced unsafe authority witness, not one of the accepted application outputs.

`tests/duplicate_counted_source.bf` fixes construction of the two-pass diagnostic input by retaining one counted buffer, validating its length-defined `A5`, then emitting the buffer, zero separator and the same buffer. It reads no second independently supplied source. Real examples were tested through this adapter both directly and as COCK guests. The imported compiler itself remains unsafe when called directly with unbound passes; no production frontend/closure guarantee is inferred from this adapter.

A trailing-byte probe `01 00 2B A5 58` produced raw adapter output `2B 00 2B`; the physical input is five bytes where its declared guarded record is four. This must be vetoed by the independent closure boundary. Guard success cannot authenticate trailing EOF, source routing, mutation, process exit or physical read/write/close. The adapter deliberately does not claim to do so.

The optional extraction pattern for a nonexistent experimental fixture subtree caused unzip exit 11; the explicit two source/three report/four artifact entries were extracted and individually imported. Git's generic diff check also interpreted three valid BF pointer runs as conflict markers. The actual BF source gate accepted those sources; a per-invocation outside-checkout Git attribute `*.bf conflict-marker-size=128` made the diff check BF-aware and it passed without changing source bytes. No implementation test failed in this run and no expectations were weakened. The historical uploaded diagnostic source changes/repairs and its external test evaluator are not attributed to this local batch.

## Remaining Android A01–A14 requirements

Current `adb devices -l` lists **no device**, `/dev/kvm` is absent, and no Android/device-farm tool was exposed by the available tools. The prior software emulator service/watchdog failures remain the latest runtime evidence. ADB access to an appropriate stable ARM64-capable target, or a suitable accelerated environment with proved ABI execution, is still required. No unchanged emulator boot or nested 600-second timeout was rerun merely to repeat a known failure.

Still missing: integrated exact-source/original-offset frontend, real native context/result checks and `ANativeActivity_onCreate`/liblog runtime, BF Android ET_DYN writer, BFIO producer/session authority, BF build/smoke and independent full-stage test implementations, complete mandatory identical-interpreter final compiler execution, debug APK generation/identity/signature/launch/lifecycle and fresh held-out target proof. These are real implementation/target gaps; installing SDK tools or generating Linux ELF cannot close them.

For the new buffer adapter and imported Linux components: DRAFTED yes, IMPLEMENTED yes, bounded diagnostic TESTED yes, OPTIMIZED no, default INTEGRATED no. For whole Android Stage A: DRAFTED incomplete, IMPLEMENTED incomplete, complete-stage TESTED not run, OPTIMIZED no, INTEGRATED no. The successful one-level guest runs and reconstructed nested requests are not the mandatory two-interpreter compiler proof. The old five nested failures retain their recorded status.

## Reproduction and retained results

All local raw inputs/outputs, source records/projections, invocation recipes, comparison packets, stderr, result TSVs and native inspection files are under `/workspace/test-results/upload-executable`. Representative completed command forms from `/workspace/COCK` are:

```text
/workspace/tools/bin/tritium -r -b -z -B -O1 -fno-negtape tests/duplicate_counted_source.bf < /workspace/test-results/upload-executable/apps/tiny_app_a.copy.input.bin > /workspace/test-results/upload-executable/apps/tiny_app_a.two_pass.bin
/workspace/tools/bin/tritium -r -b -z -B -O1 -fno-negtape src/experimental_aarch64_elf_compiler.bf < /workspace/test-results/upload-executable/apps/tiny_app_a.two_pass.bin > /workspace/test-results/upload-executable/apps/tiny_app_a.direct.elf
timeout 60 /workspace/tools/bin/tritium -r -c -b -z -B -O1 -fno-negtape -mem 2097152 src/source_pc_dynamic_tape.bf < /workspace/test-results/upload-executable/guest/tiny_app_a.request.bin > /workspace/test-results/upload-executable/guest/tiny_app_a.actual.bin
readelf -h -l /workspace/test-results/upload-executable/apps/tiny_app_a.direct.elf
```

The copy input is `u16 normalized byte count | BF-admitted normalized example bytes | A5`. COCK requests were created by the existing BF wide serializer with four-byte fuel `ffffffff`, guest capacity 64 for emitters/small literals or 512 for real source buffering, and actual closed-file input lengths. Expected COCK stdout is the entire component result plus one interpreter success byte. Root and physical completion were checked separately; do not strip a trailing byte and assume it was successful.

No full APK, debug/release key, Android log, launch timing, installed size or completed Stage A usability result exists. This continuation did not push to main or alter the preserved raw compiler path. Final remote verification found that main had independently advanced to `c5b02dcd1d0eae6793ef7eb84c4bb17fa00c3d8c`, merging the earlier `3a6a10b` design checkpoint. Fetch/inspection confirmed that merge has the same file tree as that checkpoint and does not supply the missing Android implementation; the new diagnostic work remains on the candidate branch.
