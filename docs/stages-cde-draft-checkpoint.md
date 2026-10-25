# Stages C, D and E documentary checkpoint and issues

Prepared 2026-10-25, Asia/Kuala_Lumpur. Candidate parent: `fe9d57a510388de7614089ff648fc7b306345b01` on `codex/dynamic-kernel-candidate`. Independently fetched main: `b1250780e67e7988e30ec06469468abfb7be6c39`, the user's merge of the previous candidate through PR #2. Main's tree equals the parent candidate tree; no new implementation or target result arrived with that merge. This change remains a reviewable design commit on the existing development branch.

Complete documentary coverage is recorded for [C01–C06](stage-c-full-draft.md), [D01–D08](stage-d-full-draft.md) and [E01–E13](stage-e-full-draft.md): **27 master feature IDs**. Each package includes exact proposed BF/inert inventories, contracts, bounded implementation groups, independent acceptance/measurement plans and explicit incomplete-source/target states. The master prompt remains an engineering specification, not a source of invented completed results.

## Physical archive

Read-only local design archive: `/workspace/test-results/stages-cde-design-20261025/design.tar`.

SHA-256: `f365dc1825ee326931eeb3ca56e52e67b8fac726ded1523978b31df9430e45bd`.

The archive contains exactly **24 files**: thirteen stage documents, three inert policies, five fixture JSON files and README/roadmap/status navigation. This checkpoint is the twenty-fifth changed file, written after archive creation and excluded to avoid a self-referential hash. The committed files are the portable result; the local archive is an additional audit checkpoint. No source executables, SDK/emulator files, logs, keys, certificates or generated app artifacts are included.

Archived documents are `docs/stage-c-{full,interpreter,test}-draft.md`, `docs/stage-d-{full,package,crypto,test}-draft.md` and `docs/stage-e-{full,input,events,ui,capabilities,test}-draft.md`. Inert policies are `config/stage-c/policy.json`, `config/stage-d/policy.json` and `config/stage-e/capabilities.json`. Fixtures are `fixtures/stage_c_full/acceptance.json`, `fixtures/stage_d_full/acceptance.json` and `fixtures/stage_e_full/{acceptance,counter.build,coordinates.build}.json`. The remaining files are `README.md`, `docs/development-roadmap.md` and `docs/status.md`.

Unmodified master SHA-256: `5524bd878b66d5aea43b477ed696b8a802e9168b6b388abb5b47a5c4beb3d7fd`. Existing BF sources, test sources, old native/fixture artifacts, Stage A/B policy and master checkboxes are unchanged.

## Static review performed

Installed `jq` parses all **eight new JSON files**. C data has 12 literal expectations with unique IDs. D has five public primitive/arithmetic seed vectors and four format vectors, including the exact 22-byte empty ZIP negative APK fixture. E has 20 literal body/state/app expectations, four frame-size anchors and eight schema-negative cases, each group's IDs unique. These are **53 authored case/anchor records**, not tests executed or passed. D's 14 additional package obligations and other required-group lists describe future coverage, not additional completed cases.

All 27 coverage-table IDs and local document/fixture links were reviewed. `git diff --cached --check` covers the complete staged new/updated files. The illustrative E manifests parse as inert JSON but reference BF source/assets that do not exist; no implemented v1 parser or capability validation is claimed. Public policy/specification reference URLs in D are future authoritative checks, not evidence of newly verified release policy.

No BF source validation/execution, compiler/native generation, crypto implementation test, package/signature operation, emulator/device run or benchmark was performed. Static review corrected fixture bytes before archive creation; no implementation output supplied expected data. This **documentary archive is not the Part 23 actual all-source freeze**. Actual BF implementations, independent native/format/crypto goldens and feature-specific data must be complete and frozen before each implementation batch.

## Open issues and closure evidence

| Issue | Severity / scope | Current evidence / required closure |
| --- | --- | --- |
| CDE-BASELINE | CRITICAL / C01, D01, E01 and regressions | Stage A/B production frontend/native/runtime/ELF/artifact/build/test path missing; complete actual sources and independently accept the prerequisite scoped compiler before promoting extensions |
| CDE-NESTING | CRITICAL / C01–C04, D07, E build ownership | Actual identical-interpreter real-compiler retry still timed out after 900 seconds; necessary capacity/representation repair plus complete exact compiler output and both trusted terminations required, no fixed probe/toy substitution |
| CDE-TARGET | CRITICAL / D05–D06, E05–E07/E13 | No stable target; previous software emulator installation/framework failures and no KVM; obtain actual stable API-35 ARM64/verified bridge and real load/lifecycle/observation results |
| C-REPRESENTATION | MAJOR / C02–C04 | Proposed u64 boundaries, 32-cell source/2-cell input/8-cell guest records not implemented; finish exact BF metadata/tape/physical admission, nested working-set feasibility and independent isolation/fuel/source checks |
| D-FORMAT | MAJOR / D02–D03 | Binary attribute IDs/resource/string/layout/padding goldens and BF emitters absent; independently pin exact Android bytes and complete format/negative tests |
| D-CRYPTO | CRITICAL / D04/D06 | No BF SHA/RSA/DER/v2 implementation or complete independent RSA/APK KAT corpus; complete published exact vectors, strict parsing, cross-tool signature/tamper proof and actual target checks |
| D-CUSTODY | CRITICAL for real keys / D04 release | Threat model/entropy/custody/side-channel/security and explicit release instruction absent; no real key admission. Disposable-key correctness cannot close custody; if infeasible, production signing remains UNSUPPORTED |
| E-HOSTIO | CRITICAL / E02–E04 | Buffered root/absent verified physical adapter cannot prove full-duplex BHIO, secure materialized input or pipe/backpressure closure; independently prove the exact permitted physical service without moving semantics to a conventional wrapper |
| E-CONFIG | MAJOR / E02/E04/E08 | BF JSON/path/NFC/config/dependency/canonical identity implementation and independent oracle absent; complete strict decoded-key/number/path/alias/graph negatives, explicit unsupported normalization and true immutable-set identity |
| E-LIFETIME | CRITICAL / E05–E06/E09 | Native worker/library/window/JNI lifetime, generation, blocked-I/O cancellation and main-thread behavior unproved; complete BF gateway and actual race/cleanup/response tests |
| E-UI | CRITICAL for UI claim / E06–E07 | BF handlers/renderer/resources/glyph/assets missing; complete both illustrative app structures, exact event/action/state/visible-render acknowledgement and device tests with post-freeze held-out inputs |
| E-OPTIONAL | Capability-specific / E09–E13 | Additional API permissions/JNI/DEX/storage/network/hardware/AAB/other targets have no registered implemented operation path; select each bounded concrete versioned contract/source/fixtures and independently test before support claims |
| CDE-PERFORMANCE | MAJOR / C05–C06/D08/accepted E | No whole-stage passing baseline; measure actual cold/warm time/memory/size after correctness, then justify optional sharing/optimization or record NOT NEEDED |

The master Part 23 states: “If an unresolved critical bug, failing check or unavailable mandatory target remains, STOP / BLOCKED: do not optimize, integrate or represent the feature as working.” This prevents promotion/optional optimization of affected failing paths. Part 25.4 still permits independent authorized drafting/source work. No fresh development-start permission is requested by this checkpoint.

| Stage | Documentary draft | Actual DRAFTED | IMPLEMENTED | TESTED | OPTIMIZED | INTEGRATED |
| --- | --- | --- | --- | --- | --- | --- |
| C01–C06 | Complete | INCOMPLETE | NO | NOT RUN | NO | NO |
| D01–D08 | Complete | INCOMPLETE | NO | NOT RUN | NO | NO |
| E01–E13 | Complete coverage, optional capabilities scoped explicitly | INCOMPLETE | NO | NOT RUN | NO | NO |

Close issues only with changed source/contracts where needed, exact immutable identities, independent complete results and actual applicable device/physical facts. Do not change expected semantics to remove a failure or count an unrelated tool/device failure as an intended negative pass. These designs complete the requested drafting scope while preserving the actual implementation and verification gaps.
