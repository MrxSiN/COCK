# Full Stage E design draft

Prepared 2026-10-25 (Asia/Kuala_Lumpur), against `fe9d57a`, using master Parts 2–3, 8–12, 19–21 and 23–25. **All E01–E13 have documentary coverage. Actual executable first-pass draft: INCOMPLETE; IMPLEMENTED: NO; TESTED: NOT RUN; OPTIMIZED/INTEGRATED: NO.** No generated app, renderer, platform gateway, release capability or device result is claimed.

## Scope and dependency policy

Expand one bounded requested Android capability at a time, preserving the last accepted compiler. The first E path is sealed multi-file configuration plus the exact `COCK-APP-ABI-v1`/`COCK-UI-BASIC-v1` native touch/text capability. Registered design requests remain UNSUPPORTED until their BF implementation and device tests pass. Additional managed/storage/network/hardware/distribution targets are separate optional capability groups, not inferred from a UI label.

Stage A/B are not currently accepted and Stage C/D are designs. E cannot bypass their missing source, actual compiler nesting, native/runtime lifetime or Android target gates. E UI diagnostics may use explicitly labeled external debug packaging under the master exception; they cannot claim Stage D BF-native production packaging/signing. A BF-native release path depends on D's actual independent acceptance and separate signing-key security/authorization gates.

| ID | Complete design coverage | Acceptance required |
| --- | --- | --- |
| E01 | Exact source/inert inventories and bounded groups below | Complete actual BF sources/tests/fixtures frozen before first implementation batch for each feature |
| E02 | [Snapshot/BHIO/build input](stage-e-input-draft.md), confined exact file collection and host ownership | Full-duplex physical router, immutable set/count/read/close and deadlock/race negatives |
| E03 | Separate envelope/session/completion validators and transactional output/receipt | Forged/partial/failed close never commits; exact staged/published identity and supported filesystem semantics |
| E04 | Strict full v1 config/schema/JSON/path/canonical plan and deterministic dependency graph | Duplicate/escape/number/UTF-8/NFC/cycle/type/capability negatives and equivalent interpretation |
| E05 | [Event/state/lifetime contract](stage-e-events-draft.md), full-frame input, one provisional action and trusted return | FIFO/backpressure, no reentry, exact authority/commit/cancel and lifecycle tests |
| E06 | [Native UI draft](stage-e-ui-draft.md), physical-pixel touch, printable text raster, draw acknowledgement | Actual visible initial text/touch/state/redraw/cleanup on device, all invalid/stale cases rejected |
| E07 | Two different app structures and input-driven app/module/asset configuration | Counter versus main-plus-coordinate-handler app through same compiler/gateway; source-derived behavior and final resource/package differences |
| E08 | [Module/capability boundary](stage-e-capabilities-draft.md), isolated main/handler dispatch | Graph/entrypoint/resource negotiation and explicit unsupported direct calls, no shared-tape shortcut |
| E09 | Typed platform gateway/permissions/JNI lifetime/thread/error policy | Each selected API/permission version/device path independently implemented and verified; no universal JNI claim |
| E10 | Optional demand-driven BF DEX capability inventory and verifier constraints | Actual DEX bytecode/checksum/class/loader/interoperability tests only when selected; initially unsupported |
| E11 | Optional storage/network/hardware capability gates and partial effects | One requested capability with exact versioned wire/permission/ack/failure/device contract; initially unsupported |
| E12 | Direct APK preserved; separate AAB/channel policy and key roles | Own format/signature/derived install/policy evidence; no Play publication claim |
| E13 | Explicit API/ABI/page-size/device/channel matrix and negatives | Independent install/load/event/lifecycle/results for every claimed row; untested remains NOT VERIFIED |

## Exact proposed executable inventory

All new paths below are **NOT CREATED**; they enumerate complete responsibilities. All authored implementation/test/developer source must be annotated original eight-command BF. Existing A/B/C/D source proposals remain missing dependencies until actually accepted.

| Path | Responsibility / group |
| --- | --- |
| `src/stage_e_json.bf` | Strict UTF-8 JSON/escape/integer parser with decoded-key duplicate detection; INPUT |
| `src/stage_e_paths.bf` | Canonical relative paths, NFC/support policy and actual-host alias/confined-handle checks; INPUT |
| `src/stage_e_config.bf` | Frozen v1 schema, modules/entrypoints/dependency sort and checked capability plan; INPUT |
| `src/stage_e_snapshot.bf` | BF BHIO request planner, exact materialized set, canonical BFIO build-input assembler and BF semantic identities; INPUT |
| `src/stage_e_frame.bf` | BFIO/BHIO envelope decoding/encoding with strict selected grammar and checked lengths; INPUT/SESSION |
| `src/stage_e_artifact.bf` | Complete canonical artifact-output session, trusted producer facts and publish plan; SESSION |
| `src/stage_e_dispatch.bf` | Event routing/FIFO, isolated guest invocation, one action, authoritative return/status and state machine; EVENT |
| `src/stage_e_state.bf` | Opaque schema-bound state, staged replacement/commit/rollback, cancellation and restart rules; EVENT |
| `src/stage_e_native_gateway.bf` | Emit NativeActivity/window/input worker, typed platform calls, thread/handle/generation lifetime; EVENT/UI |
| `src/stage_e_ui.bf` | Emit touch validation, text-body validation, BF raster/draw/acknowledgement and surface recovery; UI |
| `src/stage_e_resources.bf` | Extend accepted D resource emission for actually requested app assets/labels/resources; UI |
| `src/stage_e_platform.bf` | BF-generated typed permission/API/JNI gateway for individually registered operations; PLATFORM |
| `src/stage_e_dex.bf` | Optional BF DEX layout/bytecode, symbols/checksums and managed-call output; DEX |
| `src/stage_e_dex_digest.bf` | Optional BF SHA-1/Adler-32 required by selected DEX format, independent of D's SHA-256 signing; DEX |
| `src/stage_e_storage.bf` | Optional selected private-blob storage transaction, exact lifecycle/error/ack contract; SERVICES |
| `src/stage_e_network.bf` | Optional selected network request/cancel/partial-effect implementation; SERVICES |
| `src/stage_e_hardware.bf` | Optional individually selected hardware adapter/permission/handles; SERVICES |
| `src/stage_e_bundle.bf` | Optional BF AAB/protobuf/ZIP and upload-signature output for selected channel; DISTRIBUTION |
| `tests/stage_e_config_oracle.bf` | Independent schema/path/canonical/dependency oracle, structurally different from production parser |
| `tests/stage_e_snapshot_check.bf` | BHIO/build-input exact counts/identity/race/deadlock result checks |
| `tests/stage_e_session_check.bf` | Independent envelope, selected session and completion/receipt checks as distinct verdicts |
| `tests/stage_e_event_oracle.bf` | Independent event/action/state/terminal and FIFO/cancellation reference |
| `tests/stage_e_ui_check.bf` | Exact coordinate/text/native output, generation/render-ack/state/device checks |
| `tests/stage_e_platform_check.bf` | Per-operation permission/JNI/type/thread/error/device checks, no generic fake success |
| `tests/stage_e_dex_check.bf` | Optional DEX independent format/bytecode/checksum/managed loader checks |
| `tests/stage_e_service_check.bf` | Optional selected storage/network/hardware contract/partial-effect/device checks |
| `tests/stage_e_distribution_check.bf` | Optional AAB/derived APK/ABI/API/channel policy checks |
| `tests/stage_e_adversarial.bf` | BF-owned malformed/replay/race/fault workload construction with exact identities |
| `devtools/stage_e_build.bf` | Actual BF-owned module/native/package/artifact graph and status propagation |
| `devtools/stage_e_smoke.bf` | Per-feature coordinated acceptance and old-compiler regression ledger |
| `devtools/stage_e_bench.bf` | BF measurement/workload comparison for accepted features only |
| `examples/stage_e/counter.bf` | App-owned counter handler consuming full event and emitting one action |
| `examples/stage_e/convert.bf` | Independent main-module binary conversion example, isolated from handlers |
| `examples/stage_e/coordinates.bf` | Coordinate-label event handler with a different state/schema/behavior |

Optional paths are not prerequisites for the first touch/text slice and are not created in advance. Selecting any optional group requires its full concrete operation/byte/API/fixture inventory and actual source freeze; these design responsibilities cannot imply a finished universal implementation. A permitted preinstalled physical router is an external dependency with its own trust-boundary proof, not an untracked semantic wrapper supplied by this package. Module source composition is BF-owned; no foreign scripts/includes/linker implement it.

## Complete inert inventory and groups

Present files: `docs/stage-e-full-draft.md`, `docs/stage-e-input-draft.md`, `docs/stage-e-events-draft.md`, `docs/stage-e-ui-draft.md`, `docs/stage-e-capabilities-draft.md`, `docs/stage-e-test-draft.md`, `config/stage-e/capabilities.json`, `fixtures/stage_e_full/acceptance.json`, `fixtures/stage_e_full/counter.build.json`, and `fixtures/stage_e_full/coordinates.build.json`. Both illustrative manifests reference **not-created** BF sources/assets; they are not complete buildable projects. Proposed non-executable glyph asset `assets/stage_e/ascii8x8.bitmap` and coordinate asset `assets/stage_e/palette.bin` are NOT CREATED and require exact validated data before their UI fixture freeze. Shared issues/archive/navigation are in the C–E checkpoint and README/roadmap/status.

E-INPUT completes JSON/path/config/snapshot/frame sources and independent config/snapshot/session tests plus all exact protocol data. E-SESSION completes artifact/receipt with actual host physical results. E-EVENT completes dispatcher/state/native lifetime and event oracle. E-UI completes renderer/resources/three example BF sources, glyph/assets and real target checks. Optional PLATFORM, DEX, SERVICES and DISTRIBUTION groups each add their complete exact typed wire, format/operation source/tests/fixtures and platform policy before testing. Combine inseparable groups; do not test an unfinished slice. Preserve independent oracle algorithms and rollback.

All mandatory prerequisite/source/target failures remain explicit in [the C–E issue record](stages-cde-draft-checkpoint.md). The design completes planning for every E ID; it does not satisfy Part 23 actual DRAFTED or certify every optional Android service. Integration requires verified applicable A/B/C/D dependencies, complete feature/device/authority tests and exact ownership/identity, with every unsupported optional capability visibly rejected.
