# Documentation index

Updated 2026-10-26. [Project overview](../README.md), [current status](status.md) and [physical-device evidence](windows-device-evidence.md) are the starting points. Stage A is incomplete; later-stage designs and historical passing components do not establish stage acceptance.

Latest: [integrated normalized-source native compiler and device evidence](android-native-compiler-evidence.md), [same-kernel nested compiler evidence](same-kernel-evidence.md), their [native plan](android-native-compiler-plan.md) and [nested plan](same-kernel-plan.md). The complete Android compiler's nested run still fails its watchdog; Stage A remains open.

The master specification records requirements. Evidence records observed results. Plans/drafts record intended work. Checkpoint notices preserve older reports without presenting old environment paths, unavailable features or stale hashes as current instructions.

## Current guidance and contracts

| Document | File |
| --- | --- |
| [Stage A acceptance matrix](acceptance.md) | `acceptance.md` |
| [NativeActivity callback batch](android-callback-plan.md) | `android-callback-plan.md` |
| [Source-sized Android ELF component batch](android-library-plan.md) | `android-library-plan.md` |
| [Development roadmap](development-roadmap.md) | `development-roadmap.md` |
| [Engineering principles](engineering-principles.md) | `engineering-principles.md` |
| [Stage A feasibility and scope decisions](stage-a-decisions.md) | `stage-a-decisions.md` |
| [Stage A issue register](stage-a-issues.md) | `stage-a-issues.md` |
| [Engineering status](status.md) | `status.md` |
| [Physical-device verification and callback repair](windows-device-evidence.md) | `windows-device-evidence.md` |
| [Windows physical-device verification slice](windows-device-plan.md) | `windows-device-plan.md` |

## Master specification

| Document | File |
| --- | --- |
| [MASTER ENGINEERING PROMPT: COCK — Completely Overengineered Compiler Kit](COCK_Master_Engineering_Prompt_Updated.md) | `COCK_Master_Engineering_Prompt_Updated.md` |

## Prospective designs and checkpoint plans

| Document | File |
| --- | --- |
| [BF-generated Android native entry feasibility probe](android-native-entry-probe-plan.md) | `android-native-entry-probe-plan.md` |
| [Native guest implementation batch](android-native-guest-plan.md) | `android-native-guest-plan.md` |
| [Annotated source normalization bounded slice](annotated-source-normalizer-plan.md) | `annotated-source-normalizer-plan.md` |
| [Annotated source streaming preflight slice](annotated-source-stream-plan.md) | `annotated-source-stream-plan.md` |
| [Backward bracket lookup development slice](backward-bracket-slice-plan.md) | `backward-bracket-slice-plan.md` |
| [Stage A bracket gate bounded slice](bracket-gate-plan.md) | `bracket-gate-plan.md` |
| [Stage A streaming bracket gate slice](bracket-stream-plan.md) | `bracket-stream-plan.md` |
| [Chunked atomic compiler handoff slice](chunked-atomic-compiler-handoff-plan.md) | `chunked-atomic-compiler-handoff-plan.md` |
| [Stage A chunked preflight offset slice](chunked-preflight-offset-plan.md) | `chunked-preflight-offset-plan.md` |
| [Bounded compact AArch64 generator slice](compact-compiler-plan.md) | `compact-compiler-plan.md` |
| [Compiler request framer slice](compiler-request-framer-plan.md) | `compiler-request-framer-plan.md` |
| [Dynamic guest tape bidirectional clear loop slice](dynamic-bidirectional-clear-plan.md) | `dynamic-bidirectional-clear-plan.md` |
| [Dynamic tape interpreter clear loop slice](dynamic-clear-loop-slice-plan.md) | `dynamic-clear-loop-slice-plan.md` |
| [Compiler-capable dynamic tape kernel slice](dynamic-kernel-slice-plan.md) | `dynamic-kernel-slice-plan.md` |
| [Dynamic guest tape development slice](dynamic-tape-slice-plan.md) | `dynamic-tape-slice-plan.md` |
| [Stage A bounded implementation slice — general zero valued loop skip](dynamic-zero-skip-plan.md) | `dynamic-zero-skip-plan.md` |
| [Emulator retry and remaining-gate test plan](emulator-retry-plan.md) | `emulator-retry-plan.md` |
| [General forward bracket probe — bounded Stage A slice](general-bracket-probe-plan.md) | `general-bracket-probe-plan.md` |
| [COCK nested arithmetic smoke slice](nested-arithmetic-slice-plan.md) | `nested-arithmetic-slice-plan.md` |
| [Nested compiler capable interpreter diagnostic slice](nested-kernel-slice-plan.md) | `nested-kernel-slice-plan.md` |
| [Consolidated batch for the nested-proof draft](next-stage-acceptance.md) | `next-stage-acceptance.md` |
| [Untested next-stage checkpoint](next-stage-draft-checkpoint.md) | `next-stage-draft-checkpoint.md` |
| [Next Stage A draft: reproducible nested proof inputs](next-stage-draft.md) | `next-stage-draft.md` |
| [Normalized source admission and bracket slice](normalized-lex-plan.md) | `normalized-lex-plan.md` |
| [Atomic normalized command handoff slice](normalized-source-atomic-plan.md) | `normalized-source-atomic-plan.md` |
| [Stage A next bounded slice — printable guest admission](printable-gate-plan.md) | `printable-gate-plan.md` |
| [Real BF implementation continuation](real-bcde-implementation-plan.md) | `real-bcde-implementation-plan.md` |
| [Real BF stored ZIP component batch](real-stage-d-zip-plan.md) | `real-stage-d-zip-plan.md` |
| [Real Stage E handler implementation batch](real-stage-e-handlers-plan.md) | `real-stage-e-handlers-plan.md` |
| [Stage A bounded reference interpretation slice](self-host-reference-plan.md) | `self-host-reference-plan.md` |
| [Bounded six cell runtime fuel slice](six-cell-fuel-slice-plan.md) | `six-cell-fuel-slice-plan.md` |
| [Sixteen bit retained source arithmetic execution slice](source-pc-16bit-arithmetic-exec-plan.md) | `source-pc-16bit-arithmetic-exec-plan.md` |
| [Stage A sixteen bit next command and fuel slice](source-pc-16bit-branch-plan.md) | `source-pc-16bit-branch-plan.md` |
| [Stage A combined sixteen bit dispatch and arithmetic step slice](source-pc-16bit-cell-step-plan.md) | `source-pc-16bit-cell-step-plan.md` |
| [Stage A bounded source fetch slice](source-pc-16bit-fetch-plan.md) | `source-pc-16bit-fetch-plan.md` |
| [Stage A sixteen bit guest step slice](source-pc-16bit-guest-step-plan.md) | `source-pc-16bit-guest-step-plan.md` |
| [Stage A Android, native ABI and ELF draft](stage-a-android-draft.md) | `stage-a-android-draft.md` |
| [Stage A debug build, target and usage draft](stage-a-debug-draft.md) | `stage-a-debug-draft.md` |
| [Full Stage A documentary checkpoint](stage-a-full-draft-checkpoint.md) | `stage-a-full-draft-checkpoint.md` |
| [Full Stage A design draft](stage-a-full-draft.md) | `stage-a-full-draft.md` |
| [Stage A exact-source and completion draft](stage-a-source-draft.md) | `stage-a-source-draft.md` |
| [Whole Stage A consolidated acceptance draft](stage-a-test-draft.md) | `stage-a-test-draft.md` |
| [Stage B AArch64 AOT design draft](stage-b-aot-draft.md) | `stage-b-aot-draft.md` |
| [Stage B documentary draft checkpoint](stage-b-draft-checkpoint.md) | `stage-b-draft-checkpoint.md` |
| [Full Stage B design draft](stage-b-full-draft.md) | `stage-b-full-draft.md` |
| [Stage B native service and Android bridge draft](stage-b-runtime-draft.md) | `stage-b-runtime-draft.md` |
| [Stage B source and execution contract draft](stage-b-source-draft.md) | `stage-b-source-draft.md` |
| [Stage B consolidated acceptance and benchmark draft](stage-b-test-draft.md) | `stage-b-test-draft.md` |
| [Full Stage C design draft](stage-c-full-draft.md) | `stage-c-full-draft.md` |
| [Stage C interpreter, source and resource contract draft](stage-c-interpreter-draft.md) | `stage-c-interpreter-draft.md` |
| [Stage C acceptance and measurement draft](stage-c-test-draft.md) | `stage-c-test-draft.md` |
| [Stage D cryptography, v2 signing and key boundary draft](stage-d-crypto-draft.md) | `stage-d-crypto-draft.md` |
| [Full Stage D design draft](stage-d-full-draft.md) | `stage-d-full-draft.md` |
| [Stage D binary resources and APK container draft](stage-d-package-draft.md) | `stage-d-package-draft.md` |
| [Stage D independent acceptance and benchmark draft](stage-d-test-draft.md) | `stage-d-test-draft.md` |
| [Stage E modules, Android gateway and optional capability draft](stage-e-capabilities-draft.md) | `stage-e-capabilities-draft.md` |
| [Stage E invocation, state and lifecycle draft](stage-e-events-draft.md) | `stage-e-events-draft.md` |
| [Full Stage E design draft](stage-e-full-draft.md) | `stage-e-full-draft.md` |
| [Stage E exact inputs, configuration and publication draft](stage-e-input-draft.md) | `stage-e-input-draft.md` |
| [Stage E consolidated acceptance and device draft](stage-e-test-draft.md) | `stage-e-test-draft.md` |
| [Stage E native touch/text and two-app draft](stage-e-ui-draft.md) | `stage-e-ui-draft.md` |
| [Stages C, D and E documentary checkpoint and issues](stages-cde-draft-checkpoint.md) | `stages-cde-draft-checkpoint.md` |
| [Uploaded executable diagnostics and identity repair](upload-executable-run-plan.md) | `upload-executable-run-plan.md` |

## Historical evidence and references

| Document | File |
| --- | --- |
| [Android native implementation — 2026-10-26](android-native-implementation-evidence.md) | `android-native-implementation-evidence.md` |
| [Brainfuck authored source normalization evidence](annotated-source-normalizer-evidence.md) | `annotated-source-normalizer-evidence.md` |
| [Annotated source streaming admission evidence](annotated-source-stream-evidence.md) | `annotated-source-stream-evidence.md` |
| [Backward bracket target and BF owned reversal evidence](backward-bracket-evidence.md) | `backward-bracket-evidence.md` |
| [Bounded arithmetic guest fuel executor evidence](bounded-arithmetic-fuel-evidence.md) | `bounded-arithmetic-fuel-evidence.md` |
| [Bracket depth gate evidence](bracket-gate-evidence.md) | `bracket-gate-evidence.md` |
| [Streaming bracket gate evidence](bracket-stream-evidence.md) | `bracket-stream-evidence.md` |
| [Chunked atomic compiler handoff evidence](chunked-atomic-compiler-handoff-evidence.md) | `chunked-atomic-compiler-handoff-evidence.md` |
| [Chunked normalized source preflight and original command offsets](chunked-preflight-offset-evidence.md) | `chunked-preflight-offset-evidence.md` |
| [Cloud Android test environment — 2026-10-25](cloud-android-environment.md) | `cloud-android-environment.md` |
| [Compact arithmetic compiler diagnostic evidence](compact-compiler-evidence.md) | `compact-compiler-evidence.md` |
| [BF authored compiler request framing evidence](compiler-request-framer-evidence.md) | `compiler-request-framer-evidence.md` |
| [HQarroum docker Android feasibility for COCK Stage A](docker-android-feasibility.md) | `docker-android-feasibility.md` |
| [Dynamic bidirectional clearing loop diagnostic evidence](dynamic-bidirectional-clear-evidence.md) | `dynamic-bidirectional-clear-evidence.md` |
| [Dynamic guest tape with checked budget and clear loops — diagnostic evidence](dynamic-budget-clear-evidence.md) | `dynamic-budget-clear-evidence.md` |
| [Dynamic right growing tape with restricted clearing loop](dynamic-clear-loop-evidence.md) | `dynamic-clear-loop-evidence.md` |
| [Dynamic guest tape requirement for the next Stage A interpreter slice](dynamic-interpreter-next-design.md) | `dynamic-interpreter-next-design.md` |
| [Dynamic tape and wide fuel candidate evidence](dynamic-kernel-evidence.md) | `dynamic-kernel-evidence.md` |
| [Dynamic tape logical budget diagnostic evidence](dynamic-logical-budget-evidence.md) | `dynamic-logical-budget-evidence.md` |
| [General program counter and checked dynamic guest tape — local evidence](dynamic-pc-interpreter-evidence.md) | `dynamic-pc-interpreter-evidence.md` |
| [Dynamic tape interpreter diagnostic evidence](dynamic-tape-evidence.md) | `dynamic-tape-evidence.md` |
| [Dynamic logical tape general zero valued loop skipping — local evidence](dynamic-zero-skip-evidence.md) | `dynamic-zero-skip-evidence.md` |
| [Emulator and remaining-gate execution — 2026-10-25](emulator-retry-evidence.md) | `emulator-retry-evidence.md` |
| [Observed Stage A component diagnostic evidence](evidence.md) | `evidence.md` |
| [General forward bracket probe evidence](general-forward-bracket-evidence.md) | `general-forward-bracket-evidence.md` |
| [COCK nested arithmetic interpreter diagnostic evidence](nested-arithmetic-evidence.md) | `nested-arithmetic-evidence.md` |
| [Nested compiler capable BF interpreter diagnostic evidence](nested-kernel-evidence.md) | `nested-kernel-evidence.md` |
| [Atomic normalized source handoff evidence](normalized-source-atomic-evidence.md) | `normalized-source-atomic-evidence.md` |
| [Normalized guest source offset preflight diagnostic](normalized-source-offset-evidence.md) | `normalized-source-offset-evidence.md` |
| [Normalized source streaming admission evidence](normalized-source-stream-evidence.md) | `normalized-source-stream-evidence.md` |
| [General program counter interpreter diagnostic evidence](pc-dispatch-evidence.md) | `pc-dispatch-evidence.md` |
| [Integrated general loop source preflight evidence](pc-preflight-evidence.md) | `pc-preflight-evidence.md` |
| [Printable source admission extension — executed diagnostic evidence](printable-gate-evidence.md) | `printable-gate-evidence.md` |
| [Real BF implementation and actual execution evidence](real-bcde-implementation-evidence.md) | `real-bcde-implementation-evidence.md` |
| [Development environment and SDK installation evidence](sdk-environment.md) | `sdk-environment.md` |
| [Reference interpreter attribution and limitations](self-host-reference-credits.md) | `self-host-reference-credits.md` |
| [Reference BF in BF evaluation evidence](self-host-reference-evidence.md) | `self-host-reference-evidence.md` |
| [Six cell Brainfuck interpreter with runtime guest fuel](six-cell-fuel-evidence.md) | `six-cell-fuel-evidence.md` |
| [Integrated full compiler source preflight — local diagnostic evidence](six-cell-integrated-preflight-evidence.md) | `six-cell-integrated-preflight-evidence.md` |
| [Six cell Brainfuck in Brainfuck interpreter evidence](six-cell-interpreter-evidence.md) | `six-cell-interpreter-evidence.md` |
| [Six cell static admission proof — diagnostic evidence](six-cell-static-safety-evidence.md) | `six-cell-static-safety-evidence.md` |
| [Stage A retained source arithmetic execution evidence](source-pc-16bit-arithmetic-exec-evidence.md) | `source-pc-16bit-arithmetic-exec-evidence.md` |
| [Stage A sixteen bit PC and fuel branch decision evidence](source-pc-16bit-branch-evidence.md) | `source-pc-16bit-branch-evidence.md` |
| [COCK Stage A sixteen bit executable arithmetic step evidence](source-pc-16bit-cell-step-evidence.md) | `source-pc-16bit-cell-step-evidence.md` |
| [Stage A retained source sixteen bit eight cell execution evidence](source-pc-16bit-eight-cell-evidence.md) | `source-pc-16bit-eight-cell-evidence.md` |
| [Stage A sixteen bit eight cell general loop interpreter evidence](source-pc-16bit-eight-cell-loops-evidence.md) | `source-pc-16bit-eight-cell-loops-evidence.md` |
| [Stage A source program counter ledger evidence](source-pc-16bit-evidence.md) | `source-pc-16bit-evidence.md` |
| [Stage A repeated sixteen bit instruction fetch evidence](source-pc-16bit-fetch-evidence.md) | `source-pc-16bit-fetch-evidence.md` |
| [Stage A sixteen bit guest execution step evidence](source-pc-16bit-guest-step-evidence.md) | `source-pc-16bit-guest-step-evidence.md` |
| [Stage A atomic printable source admission evidence](stage-a-atomic-printable-evidence.md) | `stage-a-atomic-printable-evidence.md` |
| [Stage A followup development and tool installation result](stage-a-followup-evidence.md) | `stage-a-followup-evidence.md` |
| [Stage B issues and closure requirements](stage-b-issues.md) | `stage-b-issues.md` |
| [Executable diagnostics continuation — 2026-10-25](upload-executable-run-evidence.md) | `upload-executable-run-evidence.md` |
| [BF executable implementation checkpoint — Linux AArch64 diagnostic](uploaded/experimental-aarch64-elf-evidence.md) | `uploaded/experimental-aarch64-elf-evidence.md` |
| [Whole source bracket pairing evidence](whole-source-bracket-evidence.md) | `whole-source-bracket-evidence.md` |
