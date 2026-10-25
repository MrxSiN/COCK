# Full Stage A design draft

This package covers **A01–A14, including A09a**, rather than only the next nested-input slice. It fixes the proposed product boundary, every required executable responsibility, the input and output contracts, Android/native ownership, debug packaging, tests, measurements and final acceptance criteria. It follows the attached master prompt as an engineering specification; it does not treat unchecked boxes in that document as completed work.

**Design draft: complete. Whole Stage A executable draft: INCOMPLETE. Stage A acceptance: BLOCKED.** Several required BF implementations do not exist, identical-kernel compiler execution has timed out, and the installed emulators did not provide a stable Android target. The master prompt's Part 23 draft gate requires complete actual BF implementations, not an inventory or placeholder. Accordingly this package does not mark A05 complete and does not open the whole-Stage-A test gate. The already completed bounded-source checkpoints remain separately restorable.

The parent is `80d5de71ad784a51eb8ae0df70eef198084f2bcd` on `codex/dynamic-kernel-candidate`; main remains the installed-environment checkpoint. No runtime test, code generator, compiler or device process is run while preparing this package. No future `.bf` placeholder is created. The current candidate sources and frozen native expectations are retained.

## Product and feasibility decisions

| Decision | Complete proposed contract | Evidence state |
| --- | --- | --- |
| Target | Android API 35, minimum SDK 35, target SDK 35, AArch64 instructions, `arm64-v8a` ABI, direct-install debug APK | Design selected; no Play/distribution acceptance |
| Target execution | Actual ARM64 device, or an independently verified ARM64 bridge on a stable Android image | BLOCKED: Google image advertised a bridge but framework was unstable; ATD has no bridge |
| Source | One sealed exact annotated BF file; raw source bytes and original byte offsets retained through preflight | Existing parser components; integrated authority/offset path missing |
| App subset | Single initially zero byte, modulo-256 arithmetic, exactly one final output, printable `20..7e`; no input, pointer moves or loops | Separate admission/compilation components exist; end-to-end enforcement missing |
| Tool interpreter | All eight commands needed by the real compiler; independent outer/inner source identity and declared resource budgets | Candidate component tests pass; mandatory nesting does not complete |
| Native model | BF-generated Bionic-compatible ELF shared object with OS callback, distinct internal ABI entry, inline app instructions and bounded diagnostic log sink | NOT IMPLEMENTED |
| OS callback | `void ANativeActivity_onCreate(ANativeActivity*, void*, size_t)`; main-thread setup/guest work bounded, no source I/O in callback | Published contract and installed NDK header agree; emitted bridge absent |
| Native internal entry | `cock_guest_run_v1(context*, result*)`, exact 40-byte context and 56-byte result under `COCK-NATIVE-ENTRY-v1` | Design only; existing return-value function is incompatible |
| Observation | One printable byte via `__android_log_write(ANDROID_LOG_INFO, invocation_tag, message)`; require return 1 and correlated captured device log | Platform service contract known; native import/route NOT RUN |
| Packaging | External SDK container/resource and disposable debug-signing tools; every app-specific executable byte BF-produced | DEBUG-ONLY; no app-specific DEX or native shim |
| Page/loading policy | Propose ELF `PT_LOAD` alignment 16 KiB and uncompressed, 16-KiB-ZIP-aligned `.so`, `extractNativeLibs=false` | Must independently inspect and test; no 4/16-KiB compatibility claim yet |
| Production status | No BF-native production packager, release key, store upload, UI, general Android API or binary stdout claim | Explicitly unsupported |

The static composition is plausible under the NativeActivity and logging contracts, but source-to-ELF production and actual target loading remain unproved. This is a conditional feasibility decision, not a fabricated affirmative device result. [Android contract](stage-a-android-draft.md) lists the exact implementation and target checks.

## Complete executable responsibility inventory

Names below ending in **NOT CREATED** are proposed deliverable paths, not files claimed to exist. Existing modules are reused only for their documented behavior. A path in this table does not satisfy DRAFTED or IMPLEMENTED. Complete all remaining first-pass implementations and their tests before claiming the whole Stage A source draft complete.

| Required file or dependency | Responsibility and interface | Actual draft state |
| --- | --- | --- |
| `src/source_pc_dynamic_tape.bf` | BF interpreter; normalized counted source, fuel and logical capacity; executes real compiler | Present, tested as component; mandatory nested execution BLOCKED |
| `src/mini_compiler.bf` | Preserved original raw AArch64 arithmetic producer | Present, component tested; not Android ELF/ABI |
| `src/mini_compiler_compact.bf` | Preserved compact raw arithmetic producer | Present, component tested; not the automatically selected default |
| `src/stage_a_source.bf` | Integrated exact-source admission, annotation/bracket precedence, original-offset projection and printable subset; input/output in the source contract | **NOT CREATED**; existing separate gates do not replace it |
| `src/stage_a_native.bf` | Checked context/result entry, source-derived arithmetic, logging and OS callback code; instruction/relocation records owned by BF | **NOT CREATED** |
| `src/stage_a_elf.bf` | ELF64 layout, symbols, dynamic linking/import relocations, load permissions/alignment, checked offsets and serialized bytes | **NOT CREATED** |
| `src/stage_a_artifact.bf` | One-artifact BFIO declaration/chunks/END/terminal status; trusted producer completion distinct from host success | **NOT CREATED** |
| `devtools/stage_a_build.bf` | BF-side stage selection, status propagation, invocation and source identity; emits only the documented physical service requests or BF-produced streams | **NOT CREATED**; no hidden external build planner may substitute |
| `tests/nested_request.bf` | Exact two-level diagnostic request construction for interpreter plus real compiler plus input | Present first-pass source, UNTESTED |
| `tests/wide_request.bf` | Existing counted one-level request construction | Present, component tested |
| `tests/wide_request_from_legacy.bf` | Existing legacy fixture adapter | Present, component tested |
| `tests/source_guard_records.bf` | Exact-byte physical source record construction | Present, component tested; does not certify host close |
| `tests/byte_compare.bf` | Existing binary expected/actual comparison | Present, component tested; two-byte lengths require checked limits |
| `tests/oracle.bf` | Independent arithmetic value oracle | Present, component tested; not a full profile/source/ABI oracle |
| `tests/stage_a_source_oracle.bf` | Independent annotated grammar, bracket precedence, original offsets and subset oracle | **NOT CREATED** |
| `tests/stage_a_native_check.bf` | Independent byte/record checks for native/ELF/ABI layouts; no production native generation | **NOT CREATED**; external LLVM/device evidence still mandatory |
| `tests/stage_a_session_check.bf` | Independent one-artifact session grammar and completion facts; malformed/forged result vetoes | **NOT CREATED** |
| `tests/stage_a_selfhost_check.bf` | Whole-source identity, nested real compiler results and both terminal outcomes; fresh held-out input | **NOT CREATED**; serializer alone is not an execution checker |
| `devtools/stage_a_smoke.bf` | BF-authored deterministic smoke decisions and result ledger; external OS execution/physical observations only | **NOT CREATED** |
| `examples/tiny_app_a.bf`, `examples/tiny_app_b.bf` | Two distinct printable arithmetic apps, byte `20` versus `21` | Present; raw components tested, device NOT RUN |
| `examples/held_out.bf`, `examples/heldout_mixed_ascii.bf` | Existing regression inputs, bytes `22` and `21` | Present; neither qualifies as a newly selected held-out input now |

The new full compiler is not replaced by the old raw producer with an ELF label. Its real BF implementation must run through BF-in-BF in the normal build path; any component-specific prototype wire limits must be stated. Current u16 source/capacity widths and the interpreter's 16-cell record expansion must be checked against the actual final compiler working set before implementation claims. Widening or changing storage needs a separate full repair draft and full regression; do not hide the capacity problem by executing the final compiler directly under the root.

## Complete inert file inventory

| File or family | Role and actual state |
| --- | --- |
| `docs/stage-a-full-draft.md` | This full scope, coverage and draft-readiness record |
| `docs/stage-a-source-draft.md` | Exact source, original offsets, producer/session ownership and no-commit rules |
| `docs/stage-a-android-draft.md` | Android/ABI/native emission/ELF/lifecycle/error design |
| `docs/stage-a-debug-draft.md` | Complete prospective debug packaging/install/launch/measurement workflow |
| `docs/stage-a-test-draft.md` | Complete consolidated source/self-host/ABI/artifact/device/security acceptance batch |
| `docs/stage-a-issues.md` | Affected gates, severity, reproducers, required fixes and completion evidence |
| `docs/stage-a-full-draft-checkpoint.md` | Pretest physical archive, hashes and changed-file manifest; metadata written after freeze |
| `config/stage-a/AndroidManifest.xml` | Complete proposed inert native-only debug manifest; external SDK compiles it |
| `config/stage-a/target.json` | Inert single-target/budget/ownership/capability policy; not an implemented config parser |
| `fixtures/stage_a_full/acceptance.json` | Literal source/error/ABI/session/device test requirements, not an executable test DSL |
| Existing `fixtures/dynamic_kernel/`, other regression fixtures and `artifacts/` raw binaries | Preserved historical input/goldens; no generated ELF/APK is fabricated |
| `docs/stage-a-decisions.md`, `docs/development-roadmap.md`, `README.md`, `docs/status.md` | Refresh stale environment observations and link the complete draft accurately |

No future ELF/APK binary, generated native template, foreign test source, script, executable CI recipe or release signing asset is part of the draft. The temporary SDK package/signing commands are documented external invocations, not a repository implementation.

## Every Stage A checklist item

| ID | Complete draft coverage | Implementation or evidence still required |
| --- | --- | --- |
| A01 | Target/ABI/API, proposed manifest/loader and observation contract here and in Android draft | Stable actual ARM64-capable target and native load proof |
| A02 | Separate full tool-interpreter and narrow app subset; loops rejected; explicit unsupported cases | Integrated source policy and native bounded-execution implementation |
| A03 | Exact single-source counts/closure, immutable source handoff, BFIO output and host authority in source draft | BF source/artifact implementations and independently proved physical boundary |
| A04 | Every executable and inert dependency enumerated above, with actual state | Resolve new dependencies by updating inventory, never silently add placeholders |
| A05 | Full documentary draft prepared; whole-stage source gate explicitly incomplete | Complete every missing `.bf` and its literal tests, then freeze actual full source before execution |
| A06 | Full annotated preflight, first-byte/error precedence, bracket offsets, command map and admission | Integrated BF frontend and independent source oracle |
| A07 | Source-derived arithmetic/native observation, status and unsupported scope in Android draft | Real BF generator plus independent instruction and native execution checks |
| A08 | ELF metadata, imports, native callback/internal ABI, native-only manifest and lifecycle | BF ELF/runtime source, structural/ABI checks and device load proof |
| A09 | Exact external debug container/signing boundary and executable identity in debug draft | Generated `.so`, validated container and disposable debug key workflow |
| A09a | Data-dependent instruction/output evidence, stable package metadata, fresh held-out observation | Complete compiler/entry/ELF path plus actual correlated logs and in-APK identity |
| A10 | Complete coordinated acceptance order, nested exact outputs, malformed/physical/ABI negatives | Full first-pass source followed by actual tests; mandatory nesting currently fails |
| A11 | Space and exclamation apps, same compiler identity, third held-out app, isolated install/launch | Two distinct device-observed debug apps and held-out check |
| A12 | Required command/hash/process/target/error ledger fields in test/debug drafts | Actual completed-run evidence, no inferred success |
| A13 | Cold/warm methodology, CPU/wall/RSS/native/APK/installed sizes, optional optimization rules | Passing unoptimized Stage A baseline first; no performance claim now |
| A14 | Prospective readable-source-to-debug-app usage and retained rollback checkpoint | Real BF smoke/build drivers and a reproducible successful CLI path |

## Completion policy

This change completes the **full Stage A design package**, not the master prompt's all-source bulk draft gate. The actual whole-stage statuses are DRAFTED **NO**, IMPLEMENTED **NO**, TESTED **NOT RUN as a complete stage**, OPTIMIZED **NO**, INTEGRATED **NO**. Existing component passes and failures retain their separate evidence. Missing source cannot become DRAFTED by renaming this document or creating an empty `.bf`.

Finish source feasibility and the listed BF implementations in coordinated bounded repair/implementation drafts, preserving the working raw compiler. Once every required first-pass implementation and test exists, freeze the actual full-source snapshot and run [the complete batch](stage-a-test-draft.md). Part 23's failed mandatory gates forbid optional optimization, default promotion and representing Stage A as usable. An unavailable physical target blocks its evidence claim; it does not revoke authorization for independently supportable BF work.
