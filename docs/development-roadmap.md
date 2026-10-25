# Remaining development stages

This is a dependency and acceptance draft grounded in the master prompt and current repository evidence. It is not a statement that the platform, Android app or later-stage source exists. Only the [bounded nested-input slice](next-stage-draft.md) has a complete new executable first-pass draft in this change. Stages B–F remain design-only and receive exact source/test inventories at their own bounded slice boundaries; no empty modules are created now.

## Complete Stage A first

| Work package | Master IDs | Existing material | Next concrete deliverable | Acceptance and current blocker |
| --- | --- | --- | --- | --- |
| Reproduce nested inputs | A04, A05, A10 | Dynamic kernel, real compilers, two frozen nested requests, BF comparator | Drafted `tests/nested_request.bf` and the complete driver batch | UNTESTED; exact request equality is required |
| Finish identical-kernel nesting | A02, A10 | Five timed-out attempts; only native prefix reached | Recorded changed-resource experiment or a separately inventoried necessary kernel repair, followed by complete nested compiler results | BLOCKED; full payload plus two statuses and clean physical/process completion required |
| Qualify root execution | A10, A12 | External Tritium interpreter/JIT/compiled controls | BF-only profile fixtures and an explicit root/bootstrap qualification report | Malformed brackets/left boundary/buffering qualification unresolved; an execution backend is not a conformance certificate |
| Seal source and diagnostics | A03, A06 | Separate annotated parser, normalizer, source-offset and chunked components | One exact source-acquisition contract; BF-owned original-offset preflight, subset admission and handoff; independent close authority | Separate component passes do not establish integrated source identity, complete input or BFIO compliance |
| Establish Android feasibility | A01, A02 | SDK/NDK installed, two API 35 image diagnostics | Stable arm64-v8a device or proved bridge with a supported entry/loader observation contract | BLOCKED; software AVD runs were unstable; ATD lacks ARM64 bridge |
| Generate Android native output | A07, A08 | Original and compact raw return-value instruction generators | BF-emitted Android shared object, OS callback, internal ABI bridge, bounded guest instructions and liblog call | NOT IMPLEMENTED; raw AArch64 return function is not an ELF or NativeActivity |
| Debug package and observe | A09, A09a, A10, A11 | Official external SDK package/sign tools | Two source-dependent debug APKs and new held-out app, exact extracted ELF identity, installed APK/log/lifecycle evidence | NOT RUN; no producer or target; no app-specific C/Java/Kotlin shim allowed |
| Preserve usable baseline | A12, A13, A14 | Raw compiler artifacts and evidence ledger | Exact reproducible debug usage, unoptimized measurements and rollback checkpoint | BLOCKED on preceding gates; performance work optional only after passing baseline |

The immediate draft does not consolidate these packages into an unmanageable rewrite. Source authority is the first correctness boundary for a real application; nested and Android feasibility may be investigated in isolated test paths without pretending those paths publish a trusted application.

### Android contract to resolve before its source draft

Retain AArch64 instructions, `arm64-v8a`, API 35 and Bionic-compatible ELF shared-object ownership unless actual target evidence requires a recorded change. Document minimum/target SDK separately. The planned OS entry is `void ANativeActivity_onCreate(ANativeActivity*, void*, size_t)`, distinct from `cock_guest_run_v1(context*, result*)`. The OS callback must preserve its native ABI, return promptly and obey lifecycle/threading constraints. All executable bridge/runtime bytes must be BF-produced, including relocation, dynamic imports and calls to the declared `liblog` system service. The existing function returning `w0` cannot simply be exported as the callback.

Require independently verified ELF headers, load segments and alignment for the selected device page size; dynamic symbol/hash/string tables, dependencies, relocations, stack/register discipline, correct callback bridge, non-executable writable data, valid manifest library/function mapping and native executable inventory. Pin exact layout and byte expectations in that later inventory. Do not create a guessed ELF wrapper now or use `llvm-objcopy`'s inspection-only object as production output.

Admit only annotated, syntactically valid single-cell loop-free arithmetic followed by exactly one final output, with computed byte `20..7e`. Reject valid loops, input, pointer moves, missing/multiple output and nonprintable results explicitly. Fix original-byte diagnostic precedence before generating effects. App execution must have an invocation-specific finite work budget. Use at least two distinct outputs and a newly selected held-out source, proving changes to guest-derived instructions rather than metadata. Logs are DEBUG-ONLY text observations, not binary stdout or general UI.

Temporary external debug packaging may supply inert manifest/resources/container and disposable-key signatures. It may not supply native runtime behavior, DEX shims or rewrite guest instructions. Independently compare prepackage and extracted `.so` bytes and inventory every executable entry. Debug packaging acceptance is not Stage D release-signing acceptance.

## Stage B: Android guest-language correctness

Prerequisite: keep a verified Stage A debug build usable. Implement bounded slices for B02 nested loop code generation, B03 checked tape/pointer/zero-init behavior, B04 binary I/O/EOF with a proved Android bridge, B05 full source maps/preflight and B06 original-command fuel/precedence. Each B01 inventory must include its complete BF implementation, independent BF oracle, literal positive/negative data and target tests before any execution. B07 differentials and B08 old-app install/launch checks gate each new supported capability. B09 measurements permit only justified optional optimizations. Never infer Android support from the tool interpreter's eight-command component tests.

## Stage C: interpreter coverage and maintainability

Preserve the accepted Stage A kernel rather than starting another broad VM. C01–C04 expand only missing decoder/tape separation, full profile semantics, original offsets and failure behavior with independently proved runtime results. C05 measures actual cost without changing the default build; C06 shares frontend/IR only when it simplifies responsibility or improves demonstrated cost. This stage improves an already self-hosted toolchain; it cannot postpone the still-mandatory Stage A nesting proof. Generic IR, caches and JITs are not prerequisites.

## Stage D: BF-native packaging and signing

Use separate D01 complete draft inventories for D02 binary manifest/resources, D03 ZIP/CRC/layout/alignment and D04 cryptographic primitives/signature integration. Define exact canonical bytes, malformed-container negatives and independent known-answer vectors before implementation tests. D05 checks the chosen Android/API/page-size policy; D06 requires independent APK signature/tamper validation and device launch. D07 proves output ownership, retaining the labeled external debug fallback; D08 measures the working path before optimization.

Real release keys require a separately satisfied custody/security contract, independent crypto evidence and explicit release instruction under Parts 11 and 19. The user's ordinary development/commit authorization does not authorize use of real release keys. No key material belongs in source, fixtures, logs or the cloud setup draft. No production APK or distribution promise is made by this roadmap.

## Stage E: one Android capability at a time

E01 freezes each capability's complete bounded files before tests. E02–E04 add sealed multi-file input, canonical paths/configuration, frozen BFIO/BHIO session ownership and transactional artifact publication. E05 establishes native app event, lifetime, cancellation and state contracts. E06 proves actual visible text, touch/input, state commit, render acknowledgement and cleanup before any UI claim; E07 proves two different app structures. E08–E09 add modules/capability negotiation and explicit permission/API gateway behavior. E10 optional DEX and E11 storage/network/hardware each require BF-owned output and target evidence. E12 distribution formats and E13 additional ABI/API/device support are independent compatibility projects, not implied by one debug app.

## Stage F: measured optional engineering

F01–F03 frontend/optimizer/cache work needs semantic guards, complete identities and repeatable net benefit. F04 host-native execution has its own ABI, separate from Android. F05 BF-authored inspection/trace/smoke tools and F06 reproducible full rebuilds must retain actual nesting and rollback. F07 startup/allocation/package closure and F08 adaptive/PGO/SIMD/JIT/parallelism are optional and must earn their complexity. F09 adversarial differentials, F10 host/target portability, F11 reproducible time/memory/size/power observations and F12 BF build drivers/onboarding improve only the capabilities independently tested. Do not optimize around an unresolved correctness or mandatory target failure.

## Evidence required at every handoff

Keep DRAFTED, IMPLEMENTED, TESTED, OPTIMIZED and INTEGRATED separate. A later stage in this document has **design only**, no complete implementation draft, no new tests and no integration. An unavailable mandatory target blocks the affected acceptance path, not isolated BF development. For each passing slice retain exact source/input/output identities, process/physical authority, independent BF/format/target observations, resource limits, failures, deferred capabilities and a restorable pretest checkpoint. Update the existing master feature IDs without inventing a document version or replacing unrun results with checkboxes.
