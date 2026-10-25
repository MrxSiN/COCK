# Normalized source streaming admission evidence

Diagnostic date: 2026-10-24. **Component passed its bounded local test batch; this is not Stage A acceptance.** Android development remains deferred at user direction.

## Implemented component

`src/normalized_source_stream_gate.bf` is a new annotated, eight-command Brainfuck source module. It extends the separate, retained `bracket_stream_gate.bf` algorithm with an explicit exact-alphabet check covering `+ - < > [ ] . ,`, before bracket-depth checks. All source-to-admission logic is executable BF; no foreign-language executable source is included in the repository. It consumes the existing provisional development framing of repeated `u8 count | count literal source bytes | A5` records followed by `00 A5` and emits precisely one byte `01` or `00`. It accepts source spanning arbitrarily many records but has a **255 bracket nesting resource bound** and per-record length capacity of 255. Neither bound is claimed as a universal COCK source size limit.

This gate validates **already-normalized instruction bytes**, not annotated source with `#` comments/line grammar. It does not report original source offsets. It is not a BFIO/BHIO conforming production transport and cannot independently attest host process/stream closure. In particular, a deliberate input with valid `00 A5` termination followed by `EXTRA` was *accepted* by the BF component; this is an expected demonstration of why independent exact closure is mandatory. A successful Boolean cannot authorize executing the application guest or publishing an artifact by itself.

## Consolidated tests

Execution used the locally compiled outside-repository `/usr/local/bin/cock-bf-diagnostic` (not a qualified independent Stage A bootstrap evaluator) to run the new BF executable. An outside-repository Python diagnostic harness generated test inputs and independently computed expected bracket/alphabet admission; it was not checked into the COCK repository, and it did not implement any production source compilation, binary generation, or BF transformation. All passing observations are in the adjacent `normalized-source-stream-evidence.json`, including one record per test.

| Test family | Passed | Detail |
| --- | ---: | --- |
| Fixed positive and negative streams | 15/15 | Empty, nested, illegal byte, premature close, open suffix |
| All possible one-byte values | 256/256 | Admission requires exactly one of the original eight BF commands and a balanced bracket state |
| Randomized multi-record streams | 400/400 | Seed 20261024, both legal alphabet and arbitrary bytes |
| Real implementation command streams | 3/3 | Original compiler, compact compiler and licensed reference interpreter |
| Depth boundary and larger stream | 3/3 | Depth 255 pass, depth 256 reject, 1500-byte source pass |
| Valid/missing/corrupt guard records | 6/6 | A5/EOF handling, truncated payload/terminal |
| Frozen old bracket gate regressions | 7/7 | Existing component left unchanged |
| **Total** | **690/690** | Complete set recorded in JSON |

The complete source audit passed **10/10** repository Brainfuck source files under the Part 1 line-level comment grammar, all eight-command executable alphabet and balanced source brackets. Source SHA-256: `5284b9f1aa1f3a004d41ff257361dd7c260e7fb0d05e6909351328f89e398504`. Machine command count: 1,609.

## Integration regression

An additional **6/6** *host-orchestrated diagnostic* sequences admitted the normalized app command stream using the new BF gate, then executed either the preserved `mini_compiler.bf` or `mini_compiler_compact.bf` **as a guest of the separate BF-in-BF reference**. All six generated raw AArch64 outputs matched their corresponding previously frozen binary artifact exactly. This does not constitute an in-BF-authoritative preflight/compiler router: the outside diagnostic harness selected the second invocation after checking the first result, which is **not** permitted as the production semantic build path.

## Outstanding mandatory gates

1. Complete annotated-source lexer and original-source-offset error reporting; guest whole-source preflight and physical source byte-count/closure authority; no application guest execution on malformed-source input.
2. Actual COCK-owned BF-in-BF interpreter that executes the real mini compiler, with locked semantics and resource traps; full bounded **BF root to BF-in-BF to BF-in-BF to mini compiler** matching-output proof.
3. Independent root BF qualification; appropriately framed BF-owned semantic routing rather than an outside-repository diagnostic harness choosing production execution order.
4. Generated native AAPCS64 guest entry and Android OS callback, ELF/manifest/debug APK, installed target/emulator and device observation. This remains deferred by user instruction.

**No new guest profile, document revision, wire protocol, or ABI version is introduced.**
