# Stage B consolidated acceptance and benchmark draft

**NOT RUN. Executable test gate CLOSED.** This package supplies prospective acceptance criteria and inert literal data. The complete BF test/oracle/compiler/runtime files are not created, Stage A is not accepted and no stable Android target is available. Static document/JSON/link review is not implementation testing.

## Pretest readiness

For the selected bounded group in [the inventory](stage-b-full-draft.md), finish every actual BF implementation and independent test file, select precise input/session and native service layouts, author complete literal byte expectations, and resolve the compiler/interpreter working-set and target/lifecycle feasibility issues. No TODO/empty module or this design archive satisfies the actual DRAFTED gate.

Freeze an immutable restorable commit/archive containing all source, expected data, policy, module identities and planned commands **before** source validation, unit tests, emission, disassembly, self-hosted execution or device checks. Record source hashes and changed-file manifest. Design-time file/JSON/link/count consistency checks are allowed. Select a fresh valid held-out source after the actual complete implementation checkpoint; the historical held-out sources and the literal programs in this package are regressions, not that fresh input.

## Independent reference design

`tests/stage_b_oracle.bf` must be independent from the production frontend/native/runtime: scan original raw lines for grammar, locate brackets by independent directional scans and execute explicit reference steps over separate tape. Do not import production bracket tables, use its helper implementation or copy generated output as expected bytes. The original arithmetic `tests/oracle.bf` remains a narrow cross-check, not the full oracle. Tests themselves are BF-only; externally installed disassemblers/Android inspectors can veto results but cannot supply source transformation or expected app behavior.

The hand-derived `fixtures/stage_b_full/semantics.json` is inert expectation data. Each runtime vector specifies exact source/input bytes, enabled/disabled fuel, logical budget and expected output/status/offset/count/pointer/high-watermark and relevant cell values. Report all differences, not merely output equality. Additional matrix data must cover every source grammar class, service/ABI/native byte layout and fault-injection ordinal before its corresponding executable test begins. These seed vectors do not pretend to be the full future native-golden corpus.

## One coordinated test batch per complete slice

| Group | Required cases and evidence |
| --- | --- |
| Ownership and source | Repository-wide original-eight-command annotated BF audit of all authored executable source; unsafe comments/foreign wrappers/opaque templates rejected; historical authorship-provenance uncertainty retained |
| Physical input/session | Exact narrow-record marker and source/input counts/identities; truncation/extra bytes/mutation/read-close failure, flags/enabled-zero/disabled-nonzero and length overflow; reject grammar mixing; standard artifact missing file/status/END, forged OK and guard/version/overflow negatives; no commit on uncertainty |
| Frontend | Empty source, safe annotations, LF/CRLF/final lines, NUL/BOM/non-ASCII/DEL/bare CR, unsafe/inline comments, invalid suffix, unmatched close/earliest remaining open and original offsets across 255/256 and 65535/65536 boundaries |
| AOT semantics | Every opcode; both loop branches; `[]`, `+[]`, clear/transfer/nested loops; wrapping; binary input/output and EOF; long linear runs and sparse travel; source-driven code difference under fixed package metadata |
| Tape | `<` at zero, `><` with one-cell limit, crossing current high-watermark, zeroed pages, revisiting values, page/directory boundaries, configured logical limit, injected allocation failure, checked address/length overflow and cleanup |
| Fuel/trace | Enabled zero versus disabled; exhaustion before arithmetic, comma, dot, open/close bracket and movement; skipped bodies uncharged; `]` target after `[`, admitted failing command charged; same output but distinct EOF/input count |
| ABI/native layout | Exact context/result/table offsets; versions/sizes/flags/reserved/unaligned/stale inputs; w0/result match; callee-saved registers/SP; caller-saved clobber; relocation/branch/veneer ranges, symbol/import/LOAD permissions and code/source map identity |
| Service failures | Raw `00/A5/FF`, partial write/EINTR/error, input acquisition read error versus EOF, output open/close/status failure, unregistered handle, thread setup failure, ordinal allocator failures; distinct guest and physical statuses |
| Android lifecycle | Stable target boot/services first; real native load, callback returns, finite-fuel `+[]`, cancellation, immediate destroy, relaunch/concurrent isolation, no use after destroy/library unload, no ANR, no blocking main-thread I/O/join |
| Completion authority | Guest emits BFIO/OK-looking bytes; missing/forged/repeated status; good result but lost close; stale invocation/PID/files; partial output marked failed; no process/worker-return substitution |
| Self-hosted build | Compiler direct root as diagnostic control, compiler as BF-in-BF guest as normal path, identical interpreter outer→inner→actual real compiler; exact entire result including both completion outcomes and physical exit/closure |
| Packaging/target | Full executable inventory, manifest mapping/SDK, independent ELF/disassembly/signature/ZIP alignment, exact extracted `.so`, actual install/launch, private binary extraction and output/result identity |
| Regression | Both unchanged Stage A mini apps, historical compiler/native fixtures and held-out regressions through accepted build path, package/device/lifecycle/identity reruns; new held-out B program after actual source freeze |

Use a second BF-owned randomized generator or explicitly inventoried BF differential workload source before claiming randomized coverage. Store seeds, exact generated cases and expected-reference identities. No conventional outside-repository reference executor/source generator may silently create test semantics. The earlier uploaded historical conventional-evaluator counts are not current Stage B evidence.

Runtime comparisons include exact stdout, terminal status, raw error offset, input consumption, executed original commands, pointer, selected/touched cells, logical high-watermark and actual physical completion. Compare full short traces and declared checkpoints for long traces, preserving the first divergence. State unavailable private runtime details explicitly; output alone cannot certify fuel/state equivalence.

The proposed internal test trace record is 96 bytes, all scalar fields little endian: `0:u64 zero_based_record_index`, `8:u64 original_source_offset`, `16:u8 opcode`, `17:u8 flags`, `18:6 zero bytes`, `24:u64 pointer_before`, `32:u64 pointer_after`, `40:u8 cell_before`, `41:u8 cell_after`, `42:6 zero bytes`, `48:u64 logical_cells_before`, `56:u64 logical_cells_after`, `64:u64 input_consumed_after`, `72:u64 output_emitted_after`, `80:u64 executed_commands_after`, `88:u32 status`, `92:u32 reserved=0`. Flags are bit 0 command admitted by fuel, bit 1 cell sampled, bit 2 real input consumed, bit 3 output byte written; other bits zero. Arithmetic, input/output and brackets sample the current cell; pointer commands have no sampled cell and zero cell fields. A rejected fuel/cancellation attempt has admitted=0, no effects and unchanged counts. A command admitted then failing its own check has admitted=1. Record each attempted command once, including the failed attempt, then stop. Empty valid source has no trace records; independent terminal result proves completion. Trace bytes are separate from raw guest output. Counter/trace storage failures are independently reported physical/tool failures; never silently truncate a successful trace. This internal test layout does not change the public guest or native ABI.

Literal short trace anchors are included in the semantic data: `++[-]` visits offsets `0,1,2,3,4,3,4`; finite-fuel `+[]` visits `0,1,2,2,2` successfully and then rejects another offset-2 attempt. The BF trace checker must independently encode/decode the complete record including zeros and validate these source boundaries before any optimization claim.

Native fault injection is a BF-generated test-only build with distinct identity and deterministic injected call ordinal. It must not alter production guest step semantics. Do not trigger host-wide OOM or infer deterministic native allocation timing from host pressure. A root allocation/wall failure cannot be rewritten as guest status 5/6/7.

## Actual device and debug workflow

Use a specifically selected API-35+ ARM64 device or an independently proved bridge on a stable compatible emulator. Record build/API/ABI/page size, completed boot plus usable package/activity services and actual native execution. Lack of KVM on this host and the previous incomplete emulator boot remain actual blockers; do not rerun the same long startup as proof of progress without a changed diagnosis/target.

Reuse the [Stage A external debug workflow](stage-a-debug-draft.md) only after the new BF artifact producer passes. Keep package/certificate identity stable for old/new comparisons and use a disposable debug key outside the checkout. No release key use, upload or production publication. Record prepackage/native/APK identities, complete entry inventory, signature/decoded manifest/alignment, install/launch results, process/worker identity and callback responsiveness. Library extraction must exactly match BF output after signing.

Capture raw private output and separate result by invocation using supported debug extraction. Preserve bytes before rendering; do not trim a space, interpret NUL as EOF or treat log text as binary stdout. Observe two materially different original mini apps again and a newly compiled all-eight-command/nested-loop app with independent expected result. A valid subset app rejection regression is a failure. Negative loader/ABI candidates run in isolated task-owned debug installs with recorded expected failure reason; an unavailable package service is NOT RUN for the intended loader test.

For 4-KiB and 16-KiB configurations, report each tested matrix row independently. Untested rows remain untested. AArch64 disassembly on this x86 host cannot substitute for native execution. Missing devices/services/extraction produce NOT RUN/NOT VERIFIED, never PASS or a vacuous expected-failure pass.

## Baseline, optimization and rollback

Only after mandatory correctness and target checks pass, freeze the exact O0 source/artifacts and repeat equivalent workloads at least three times, preserving individual observations. Measure cold/warm source admission, BF-in-BF compile, native/runtime/ELF generation, debug packaging/signing, installation, worker startup/execution and completion separately where possible. Report wall/CPU time, peak RSS or unavailable measurement, guest commands/second where meaningful, emitted guest/runtime/metadata/padding/ELF/APK bytes and actual installed bytes where accessible. Use identical target, input, budgets, seed/backend and comparable external load. Do not call concurrent noisy runs a stable speedup.

Workloads include empty source, short mini app, long arithmetic, nested loops, sparse rightward tape, binary stream, almost-no-optimization input and a deterministic fuel trap. Record measurement overhead, capture/instrumentation and whether root startup is included. Power is NOT MEASURED without a real independent method. No benchmark number is supplied by this draft.

B09 may close with a measured usable unoptimized baseline and **NOT NEEDED** optimization. Any optimization needs attributable benefit, precise semantic guards, an O0 fallback and complete failure/fuel/source-map/device/regression rerun. Clear/transfer loops, pointer fusion and cancellation scheduling are particularly sensitive; do not remove intermediate traps or original command cutoffs. Keep the old accepted compiler available; on regression revert the candidate and rerun checks. Until Stage A and B pass, no optional optimization, integration or usable-compiler claim is authorized by this draft.

## Execution ledger and final decision

For every attempted case retain run/checkpoint ID, exact source/input/policy/compiler/interpreter/backend identities, commands, resource budgets, start/end times, exit/timeout/signal, exact actual/expected bytes and counters, independent check results, device identity, failures and limits. A missing expected case is NOT RUN. Preserve failures through coordinated repair and reruns; never regenerate a golden from actual output to make it pass.

Only a completed B01–B09 record plus still-passing Stage A, whole-stage source ownership, self-hosting, device/lifecycle and artifact-identity gates can authorize integration. A documentation commit is a design review checkpoint, not that integration.
