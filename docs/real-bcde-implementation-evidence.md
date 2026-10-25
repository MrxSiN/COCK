# Real BF implementation and actual execution evidence

This continuation adds **eight complete executable BF components**, not placeholder files or another design-only checkpoint. It follows the user's instruction to proceed with real code despite the previously recorded blockers. **Full Stage B, C, D and E implementation is still incomplete.** The implemented boundaries and remaining production work are stated separately below; no unavailable check is converted to a pass.

Parent: `56bb7e2` on `codex/dynamic-kernel-candidate`. Fetched main remains `b1250780e67e7988e30ec06469468abfb7be6c39`. No main promotion, release signing or publication occurs. The master specification and earlier kernel/compiler/native golden files are unchanged.

## Actual implemented sources

| Source | Real implemented behavior | Normalized BF commands | Direct cases | BF-in-BF cases |
| --- | --- | ---: | ---: | ---: |
| [stage_b_u64_add.bf](../src/stage_b_u64_add.bf) | Two full-width little-endian unsigned operands, checked carries/overflow and guarded admission | 1,303 | 10 | 2 |
| [stage_c_binary_input.bf](../src/stage_c_binary_input.bf) | Retained binary input, actual-byte consumption and EOF-zero reads with separate consumed count | 1,212 | 11 | 1 |
| [stage_d_crc32.bf](../src/stage_d_crc32.bf) | Actual reflected ZIP CRC-32 polynomial over arbitrary binary chunks, initial/final all-ones | 4,955 | 11 | 2 |
| [stage_e_bfio_envelope.bf](../src/stage_e_bfio_envelope.bf) | Exact v1 header/kind/flags, full u64 payload count, checked total-length overflow and final guard | 4,241 | 18 | 2 |
| [stage_e_text_body.bf](../src/stage_e_text_body.bf) | Version/reserved/u32 length, complete printable-ASCII body and guard, defined failure precedence | 1,392 | 14 | 2 |
| [convert.bf](../examples/stage_e/convert.bf) | Real app main module reads two raw bytes and emits them in reverse, including EOF-zero | 6 | 5 | 1 |
| [coordinates.bf](../examples/stage_e/coordinates.bf) | Real app handler parses its full event, preserves correlation, derives x parity/state, emits one complete READY/ODD/EVEN action | 3,142 | 12 | 3 |
| [stage_d_stored_zip.bf](../src/stage_d_stored_zip.bf) | Actual variable-name/data stored ZIP local header, retained identical central name, CRC metadata, calculated offsets and EOCD | 3,845 | 10 | 2 |

All eight sources are annotated original eight-command BF, totaling **20,096 executable commands**. All eight passed the existing BF-authored annotated-source admission and BF normalization. Every first-pass source/fixture set was complete and frozen before its implementation batch. No BF implementation repair or optimization occurred after those freezes. Direct source editing and reuse of the existing BF counted-buffer primitive supplied the code; no conventional source generator or custom BF evaluator was authored.

The JSON companion records complete source hashes. This is new-source evidence, not retrospective certification of earlier development-process provenance.

## Actual tests and independent checks

**91 direct exact-byte cases passed**, each with root process exit 0 and independent exact comparison. This comprises 60 literal primitive cases, three larger binary boundary fixtures, one additional post-freeze CRC input, 17 app-module cases, nine ZIP cases and one additional CRC-to-ZIP case. Error cases pass only when the specified rejection/status/partial output is observed.

**15 actual BF-in-BF cases passed**, not direct-root substitutions. The existing COCK kernel executes each new program's BF-normalized source as its guest. All whole outputs equal their literal expected bytes plus the kernel's success byte, with root exit 0. Selected cases include u64 carry, binary EOF, real CRC digits, BFIO overflow, text acceptance/rejection, app actions with binary state/correlation, and actual complete ZIP generation. These are **one interpreter layer** component tests, not the missing identical-interpreter two-layer real-compiler proof.

The existing independent BF byte comparator accepted **all 106 corresponding output pairs** with verdict 00; a deliberate unequal-byte control returned 01. Comparisons overlap the direct and guest groups and are not counted as another 106 application tests. Independent `cmp` agrees. The six frozen original/compact real mini-compiler controls were rerun through the unchanged COCK kernel and still match their full existing native-output fixtures, including the terminal kernel result. Their raw AArch64 output was compared, not executed as an Android app.

Six real generated coordinate actions each pass the BFIO envelope validator and the text-body validator, **12 additional producer/consumer validation checks**. Text bodies are inspected at the independently specified byte offsets; the private validator guard is added only to its test invocation, never to the public action body. Actions remain provisional; the handler never prints a forged dispatcher terminal status.

Independent `unzip -t` accepts **seven valid BF-generated archives** and rejects three intended negatives: missing first/final guard gives absent/incomplete directory (exit 9), and deliberately wrong supplied CRC gives checksum rejection (exit 2). Literal archive bytes also match the independent BF comparator. Cases cross path/data count and offset carries, use nested/variable filenames and binary data. The additional `hi`/`hello` archive receives its CRC bytes from the already executed BF CRC component; independent extraction returns exact bytes `68 65 6c 6c 6f`. This is disclosed component-test orchestration, not a claimed production BF build planner.

Important boundaries demonstrated by the tests:

- Binary `00/A5/FF` remain data; EOF zero has a different consumed-input count from real zero input.
- U64 addition rejects overflow while preserving full-width values, including top-bit cases; invalid guard takes precedence.
- The frame parser processes a 65,536-byte payload and rejects `N+25` u64 overflow. Envelope acceptance alone does not authorize a file session.
- Text validates all declared bytes before returning one result; invalid guard outranks version/alphabet faults. A 256-NUL-byte body fails its alphabet check after complete count processing.
- The coordinate handler assumes the dispatcher-checked envelope/nonzero correlation/physical closure required by the app ABI; it checks its own handler/schema/state/event shape and guard. It does not replace the dispatcher, validate live pixel bounds or draw pixels.
- The ZIP component has a bounded one-entry/u16 input format, prevalidated canonical nonempty path and BF-produced/verified input CRC. It withholds the central directory after bad final guard. A root exit 0 with incomplete ZIP or bad CRC is **not** publication success. Multi-entry APK layout, native alignment and signer ownership are not inferred.

No benchmark or speedup claim is made. External seed O3 is the execution backend, not an optimization of the project BF programs or an Android AOT result.

## Executor, invocation error and immutable checkpoints

External installed Tritium v1.2.73 SHA-256 is `0ac670ed3128db52bfa73347d6f81eccd864ebd91f8a7d450d8efb2278178a5b`. Direct flags were `-r -c -b -z -B -O3 -fno-negtape`; BF-in-BF root adds **`-mem 2097152` as two arguments**. The standard external executor's own C backend is disclosed bootstrap tooling; it does not supply project source, oracle semantics or an app-specific native helper.

The first nine guest launches accidentally used unsupported `-mem2097152`. They exited 1 before BF execution and produced no bytes. Those logs/results are preserved under `/workspace/test-results/real-bcde-20261025/guest/invalid-command/`. Corrected invocations passed all nine cases without source changes. The failed launch batch is not counted as a BF execution or hidden as a source repair.

| Actual pretest archive | SHA-256 |
| --- | --- |
| `/workspace/test-results/real-bcde-20261025/pretest.tar` | `daf9be2cac90207553ba6c252fc1a933783dcef10ecde8010cc6a26ff256c52c` |
| `/workspace/test-results/real-stage-e-20261025/pretest.tar` | `83ffabd5a6ee1f69eadee07abd9d40f9dd10370b608411df836febb549b4f0a8` |
| `/workspace/test-results/real-stage-d-zip-20261025/pretest.tar` | `6cd7e09e7c66048e65ce3bacc770a012fe820202cd4787a2b75fc1a25d9ee10a` |

Archive comparison found no source/fixture changes after freezing. Each raw run directory contains literal inputs, expected/actual bytes, BF-source gates, normalized sources, BF comparisons, guest request recipes, stdout/stderr and result tables. The committed fixture JSON/binaries and source files make the component inputs/expectations portable. Post-freeze data is in [postfreeze.json](../fixtures/real_bcde/postfreeze.json); it was chosen after source freeze and its expectations existed before those extra invocations.

## Reproducing real component execution

For example, execute the actual CRC algorithm on a guarded nine-byte chunk followed by zero-length termination:

```text
printf '\x09\x00123456789\x00\x00\xa5' | /workspace/tools/bin/tritium -r -c -b -z -B -O3 -fno-negtape src/stage_d_crc32.bf | od -An -tx1
```

Expected output is `00 26 39 f4 cb`: status plus finalized little-endian CRC. Inputs are literal binary data, not new instructions.

All saved literal test cases may be materialized by selecting their hex parts from the corresponding fixture JSON and using installed `basenc --base16 -d`; no conventional semantic oracle is needed. Guarded source records, normalization, guest-request serialization and output comparisons are executed by the existing BF tools. The exact guest recipe is u16 normalized-source count, u32 fuel `ffffffff`, u16 guest capacity 128, u16 guest input count, normalized source and literal input; BF `tests/wide_request.bf` constructs the actual kernel request. Root memory is separately declared. Larger input/tape formats do not imply every invocation fits the bounded current kernel.

## Full requested work remaining

This is **partial implementation of B–E**, not completion of those stages. Missing work still includes integrated original-offset source admission and AOT lowering for all commands; the complete Android service/worker/native ABI/ELF and normal BF build graph; actual scalable interpreter expansion and mandatory same-interpreter nested real-compiler proof; binary resources/multi-entry aligned APK/SHA/RSA/certificate/signature implementation; secure snapshot/JSON/path/module/session/finalizer/dispatcher/counter/renderer/platform capabilities; optional DEX/services/AAB and device acceptance. The new complete subcomponents do not fill these files by naming convention.

Current `adb devices -l` lists no device. No emulator, install, native loading, visible rendering or release-key test was run for this change. Earlier failed emulator/nesting evidence remains unchanged. The user's instruction allowed this source work to proceed; it does not turn unavailable evidence or missing production code into a completed implementation.
