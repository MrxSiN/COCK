# Development roadmap

Updated 2026-10-26. Work advances in stage order. [Status](status.md), [acceptance](acceptance.md) and [device evidence](windows-device-evidence.md) distinguish tested components from accepted stages. Repository-authored executable code stays annotated Brainfuck; apply the [engineering principles](engineering-principles.md) without adding speculative frameworks.

## Stage A — finish the usable restricted compiler

The Android target blocker is resolved for the pinned Pixel 8 Pro API 37 slice. Real BF native guest/callback/ELF components load and emit source-derived logs; the exclusive-store repair and independent native regressions pass. Debug packaging remains external and explicitly temporary.

Remaining work is mandatory, not postponed to later stages:

1. Complete identical-interpreter nested execution of the real compiler with matching full output and statuses. Retain timeout/partial-output evidence.
2. Implement integrated exact annotated-source admission, original offsets, unsupported-capability errors, immutable handoff and independently authenticated read/count/close facts.
3. Implement BF build composition, artifact framing/status authority and independent source/native/session/self-host oracles. Existing serializers and component pipelines do not supply missing orchestration.
4. Reconcile the [whole-stage inventory](stage-a-full-draft.md), finish/freeze all missing actual BF files, and run [whole-stage acceptance](stage-a-test-draft.md). Publish reproducible readable-source-to-debug-APK usage and preserve the exact accepted baseline.

Keep original/compact raw compilers and their frozen fixtures unchanged. Maintain declared per-invocation resource bounds; do not make diagnostic representation limits universal app limits. No optional optimizer is required to pass a correctness gate.

## Stage B — guest-language correctness

After Stage A acceptance, implement the [B01–B09 design](stage-b-full-draft.md) in bounded slices: native nested loops, checked tape growth/pointers, binary I/O/EOF, full source offsets and fuel/trap precedence. Use [independent acceptance](stage-b-test-draft.md), differential cases and old-app device regressions before promotion. Existing u64 arithmetic components do not constitute a full Stage B runtime.

## Stage C — interpreter completeness

Extend the verified Stage A interpreter under [C01–C06](stage-c-full-draft.md), preserving the bootstrap and compiler path. Complete missing guest profile, tape/decoder isolation, resource/error behavior and source maps; measure actual costs using [C tests](stage-c-test-draft.md). Share frontend/IR only where it reduces demonstrated duplication or cost.

## Stage D — BF-native APK/signing

Implement [D01–D08](stage-d-full-draft.md): binary resources, checked ZIP/container layout, cryptographic primitives, APK signature construction and independent tamper/device verification. Existing CRC-32/stored-ZIP components are not complete APK signing. [Crypto/custody gates](stage-d-crypto-draft.md) and explicit release instructions precede any real release-key use. Keep the disclosed debug fallback until BF production replacement is proved.

## Stage E — Android platform capabilities

Follow [E01–E13](stage-e-full-draft.md) one concrete capability at a time: sealed multi-file/configuration input, BFIO/BHIO authority, events/lifetimes/state, visible UI and input, modules, permissions and separately tested services. Prove two different app structures and independent rendering/state behavior under [E tests](stage-e-test-draft.md). Component text/frame validators are not a working UI platform.

## Stage F — measured optional engineering

Only after correctness, evaluate frontend/optimizer/cache improvements, native-host acceleration, full toolchain rebuilds, additional targets and repeatable resource measurements. Preserve output identity, guest semantics, bootstrap and rollback. Keep an optimization only with measured net benefit; otherwise skip it.

Every slice inventories source/tests/config/docs first, completes its actual BF draft before its consolidated test batch, repairs failures, retains evidence and updates documentation. Commit and push completed verified tasks. Keep DRAFTED, IMPLEMENTED, TESTED, OPTIMIZED and INTEGRATED distinct; a checkpoint commit is not whole-stage acceptance.
