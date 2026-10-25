# COCK — Stage A engineering workspace

Stage B draft: [complete B01–B09 design, file inventories and gates](docs/stage-b-full-draft.md), [acceptance plan](docs/stage-b-test-draft.md), and [open issues](docs/stage-b-issues.md). Source, AOT, runtime/binary bridge, fuel, regression and benchmark contracts are drafted with literal reference data. Executable Stage B source is not complete; Stage A and device blockers remain open.

Latest emulator run: [actual APK installation failures, BF-native entry probe and nested retry](docs/emulator-retry-evidence.md). A new BF test generator emits a structurally checked Android ET_DYN entry library and a signed debug probe APK was prepared. The software emulator failed to finish boot/install after about 39 minutes; the 900-second nested retry also failed. Full A01–A14 is not accepted.

Latest execution: [uploaded BF components, source-identity repair and actual test results](docs/upload-executable-run-evidence.md). Four Linux AArch64 ELF examples reproduce directly and through the COCK interpreter; the new BF buffer adapter and prior serializer/regressions pass their bounded checks. These are Linux diagnostics. The missing Android NativeActivity/ET_DYN/APK implementation and stable target still block A01–A14.

Full Stage A scope: [A01–A14 design, complete inventory and actual draft status](docs/stage-a-full-draft.md), [whole-stage acceptance plan](docs/stage-a-test-draft.md), and [open implementation/target issues](docs/stage-a-issues.md). The design package covers every Stage A requirement; the whole-stage executable BF draft remains incomplete. Current diagnostic execution is recorded separately above; Android device tests remain NOT RUN.

Nested-input slice: [driver and full slice inventory](docs/next-stage-draft.md), [acceptance plan](docs/next-stage-acceptance.md), [completed serializer diagnostics](docs/upload-executable-run-evidence.md), and [remaining development stages](docs/development-roadmap.md). Serializer checks passed; actual nested-compiler execution and Android acceptance remain blocked.

Experimental dynamic-tape/wide-fuel kernel: [candidate evidence](docs/dynamic-kernel-evidence.md). Component and compiler regressions pass, but mandatory nested execution timed out. The candidate is not promoted to the default compiler path or accepted as Stage A. Current installed SDK and failed emulator checks are recorded in [Android environment evidence](docs/cloud-android-environment.md).

**Development in progress. Not an accepted Stage A build and not an Android compiler yet.** All authored executable source in this folder is annotated original eight-command Brainfuck. There is no hidden conventional production compiler or launcher. The restricted component passed exact raw-byte diagnostics under a nonqualifying external test evaluator; **the mandatory independently qualified root BF evaluator and full nested self-hosting path are absent**. See `docs/evidence.md`.

## Implemented component and observed diagnostics

- `src/mini_compiler.bf` consumes *trusted prevalidated normalized* input source and emits raw little-endian AArch64 instruction bytes, not ELF/APK.
- `src/bf_in_bf.bf` is the initial arithmetic BF-in-BF evaluator. It only supports the admitted normalized loop-free single-cell guest subset and **cannot yet run the actual compiler**. It is not a completed self-hosted Stage A interpreter.
- `tests/oracle.bf` is a separate BF implementation of arithmetic semantics with a different command classifier. It is incomplete as a full `COCK` oracle.
- `examples/` contains three annotated, distinct source fixtures. `fixtures/` contains inert byte expectations. `artifacts/` contains raw instruction output candidates produced by diagnostic BF execution, not ELF or APK files.
- `docs/evidence.md` and `docs/evidence.json` record true tests, output identities, and negative-case failures.

## Developer diagnostics after installing an external BF evaluator

Use a trusted external standards-only BF evaluator that supports 8-bit wrapping cells, zero at EOF, binary stdin/stdout, and an adequately growing right-hand tape. Validate the annotated source and **raw exact byte count/closure** independently before any accepted run. An evaluator which merely ignores all non-command bytes is **not** a source preflight.

A documented conceptual invocation is an *externally installed* evaluator reading `src/mini_compiler.bf` as executable source, receiving one validated normalized guest source stream as its binary stdin, and writing raw native code bytes to a candidate output file. Run `src/bf_in_bf.bf` and `tests/oracle.bf` with the same normalized guest source as a separate arithmetic component diagnostic. No repository script is used.

Do not label any resulting raw instruction stream as an ELF, Android shared library or APK. No component currently verifies the complete source grammar and closure, framing, resource budgets, guest fuel, nested full compiler self-interpretation or Android loader callbacks; the bounded six cell kernel separately demonstrates single-layer compiler execution. See `docs/stage-a-decisions.md`, `docs/acceptance.md`, and `docs/status.md`.

## Followup component and install blockers

The next bounded draft added `src/raw_subset_gate.bf` and `fixtures/raw-subset-gate-vectors.json`. Fixed raw-source diagnostic vectors passed 13/13 and deterministic additional differential diagnostics passed 400/400 on 2026-10-24. **These are local diagnostics**, not the self-hosted compiler or complete Part 1 source preflight. See `docs/stage-a-followup-evidence.md` and its JSON companion.

The current cloud environment has the official Android SDK and both API 35 emulator images installed; software runtime validation failed with boot timeouts and framework restarts. See `docs/cloud-android-environment.md` for current evidence. An independently supplied upstream Tritium evaluator is now installed for bounded component checks; full COCK bootstrap qualification remains incomplete. The observations in `docs/sdk-environment.md` describe the archived host.

## Printable admission extension — current bounded slice

`src/printable_subset_gate.bf` adds a BF-authored computed-output check for ASCII space through tilde (`0x20..0x7e` inclusive), on top of the older raw-only gate. Its 2026-10-24 diagnostic batch ran 18 fixed executable cases, all 256 possible output bytes with the separate BF arithmetic oracle, and 700 randomized cases; all executed comparisons passed. Three further fixed vector entries require an unavailable host byte-count/closure adapter and are **NOT RUN**, not declared passing host tests. The previously saved mini-compiler raw AArch64 output files are byte-for-byte reproducible for all three example programs via diagnostic direct BF execution. This remains **raw source only**: full annotated-source preflight, self-hosted/nested mini-compiler execution and Android native package functionality are not implemented. See `docs/printable-gate-plan.md`, `docs/printable-gate-evidence.md`, and the matching evidence JSON. The older `raw_subset_gate.bf` is preserved.

## Normalized bracket validation update

The next Stage A bounded slice added `src/bracket_depth_gate.bf` and `src/bracket_stream_gate.bf`, both executable sources written exclusively in annotated Brainfuck. The former validates a single 255-byte maximum *development input record*; the latter uses multiple guarded byte records and accepts the 515-command mini compiler's lexically normalized source in 200, 200 and 115-command chunks. It carries nesting depth across records and rejects its present implementation-specific depth overflow above 255. The first bracket gate uncovered a sticky-rejection defect in its initial 420-case batch, which was repaired and passed its full 420-case rerun. The streaming gate passed 721/721 in its consolidated diagnostic batch. All source files passed the pure-BF annotation audit, and the three existing raw machine-code candidates remain reproducible. See `docs/bracket-gate-evidence.md`, `docs/bracket-stream-evidence.md` and `docs/bracket-gates-evidence.json`.

**Do not treat this as compiler self-hosting.** These components inspect bracket structure only and assume a separate lexer has admitted exact eight-command input. Full annotated-source validation, independently trusted physical byte count/closure, actual BF-in-BF execution of the compiler and its bounded nested self-interpretation are NOT IMPLEMENTED. The stream format is a provisional local diagnostic transport, not the versioned production BFIO/BHIO profile. Android remains deferred at the user's request.

## BF in BF reference bridge and bounded nested diagnostics

`src/bf_in_bf_reference.bf` adds a separately licensed, annotated 423-command BF self-interpreter by Daniel B Cristofani (CC BY-SA 4.0); see `docs/self-host-reference-credits.md` for attribution and license terms. This is a **third-party BF-authored diagnostic reference**, not an accepted implementation of the full COCK profile. It takes the legacy test input `guest source!guest input`. **The original `src/bf_in_bf.bf` has not yet been upgraded** to run arbitrary pointer/loop/io guest code.

A 2026-10-24 local test demonstrated all **three** example apps through the BF-in-BF reference executing the actual `src/mini_compiler.bf` guest: their raw AArch64 outputs matched the prior frozen 264-, 272-, and 280-byte candidates byte-for-byte. Four small BF programs also ran with one additional nested BF-in-BF interpreter level, including pointer/loop and binary NUL/FF. **Full nested execution of the actual compiler remains unverified**: an explicit 15-billion-root-instruction diagnostic attempt exhausted its budget before a complete output. The reference bypasses strict annotated-source preflight, as demonstrated by a negative case. Detailed, labeled results: `docs/self-host-reference-evidence.md` and `.json`.

No Android SDK/emulator or production signing work was attempted. Strict source/transport admission, independently qualified bootstrap, COCK trap/fuel/budgets, full nested compiler and device launch remain mandatory acceptance blockers. Source attribution and CC BY-SA obligations apply to the separately adapted reference file; the rest of the workspace retains its own provenance.

## Compact AArch64 compiler candidate — new bounded component

`src/mini_compiler_compact.bf` is a second, independently testable BF-authored generator for the *same admitted raw arithmetic subset*. It moves the modulo-256 low-byte extraction from each guest arithmetic step to one final AArch64 instruction, retaining a source-dependent ADD/SUB instruction for every arithmetic source command. For the three established examples its directly generated raw binaries are 140, 144 and 148 bytes versus 264, 272 and 280 for the preserved original baseline. A consolidated test batch passed 7 fixed cases, 1,200 seeded variable-input byte comparisons, 3 BF-in-BF reference compiler runs, an independent assembler word check, 3 old-output regressions, 12 BF source audits and 10 raw admission-gate diagnostics. See `docs/compact-compiler-plan.md` and `docs/compact-compiler-evidence.md` plus `.json` for full evidence and measurement limits.

**This does not resolve the mandatory full nested compiler execution, COCK-owned source preflight/host closure, independent BF root or Android acceptance.** Neither variant emits an ELF, APK or signed artifact. No Android installation work was undertaken.

## Exact command alphabet and bracket streaming gate

`src/normalized_source_stream_gate.bf` adds Brainfuck-authored exact command admission to the existing bracket-stream algorithm. Its **690/690** local diagnostic batch, plus **6/6** host-orchestrated compiler-through-reference regression comparisons, passed on 2026-10-24. The frozen old bracket gate and both raw compilers remain unchanged. Refer to `docs/normalized-lex-plan.md`, `docs/normalized-source-stream-evidence.md`, the accompanying evidence JSON and `fixtures/normalized-source-stream-vectors.json`.

**Not full source preflight:** this gate reads only an already-normalized command stream using provisional chunk records. It does not validate annotated source lines or attest independent physical stream closure, and a valid terminal record followed by junk remains undetectable by the BF module alone. Neither the full nested compiler self-hosting chain nor Android target is accepted.

## Annotated source and bracket gate — present slice

`src/annotated_source_stream_gate.bf` now validates **annotated** source line syntax and bracket nesting across bounded literal-byte records, rather than trusting pre-normalized command streams. A consolidated batch passed **589/589** tests and **924/924** extended adversarial tests after a sticky-record-guard defect was repaired. **11/11** annotated BF source audits and **6/6** replayed original/compact raw-code artifact comparisons passed. Detailed evidence: `docs/annotated-source-stream-plan.md`, `docs/annotated-source-stream-evidence.md`, `docs/annotated-source-stream-evidence.json` and `fixtures/annotated-source-stream-vectors.json`.

**This is still a component, not completed source preflight.** It emits a Boolean but not the filtered source or exact first-invalid original byte offset; it uses provisional byte records, a current 255 bracket nesting bound and no independently attested host closure. A deliberately valid record followed by extra bytes still passes the BF Boolean and MUST be rejected by a trusted host closure gate. The BF-owned downstream execution coordinator, COCK-compliant interpreter and required full nested compiler proof remain unfinished. Android remains deferred.

**Source-provenance qualification:** The new `.bf` file contains only BF executable instructions, but a temporary outside-repository Python instruction-layout helper assisted initial source drafting. This helper is not part of the workspace or production compiler and was not run to generate application artifacts. Under the master specification’s stronger BF-only engineering-process ownership requirement, this authoring workflow is **not purity-certified**; the component is retained as a tested diagnostic prototype pending BF-native source-maintenance provenance review.

## 2026-10-24 BF authored source normalization and Android Docker feasibility

The suggested [HQarroum Docker Android emulator](https://github.com/HQarroum/docker-android) was inspected. This execution host has no Docker/Podman, `/dev/kvm`, reachable GitHub DNS or `adb`; thus it could neither install nor run the emulator. Upstream defaults to an x86_64 Android image, which is not by itself an ABI match for COCK's `arm64-v8a` native target. See `docs/docker-android-feasibility.md`. Android device acceptance remains **NOT RUN**.

`src/annotated_source_normalizer.bf` is a new BF-authored command-sequence projection for **already admitted and independently completed** annotated source. It strips annotations and whitespace by retaining the eight BF commands in original order. The source was manually drafted as BF, and passes 595/595 local diagnostic checks, including all 11 repository `.bf` files accepted by the BF annotation gate, 256 individual byte projections, 300 randomized valid sources, and 6 exact native-byte compiler-through-reference regressions. See `docs/annotated-source-normalizer-evidence.md`, `.json`, the planning contract and fixtures.

**Do not use the normalizer alone as source preflight.** It does not reject illegal comments or embedded NUL, establish exact read/stream closure, preserve original source error offsets, or hold provisional output until authoritative whole-source preflight. The diagnostic harness separately exercised the validator then normalizer, but that is not an integrated BF-owned production handoff. Full COCK-owned BF-in-BF execution and complete nested self-interpretation of the real mini compiler remain unfinished, and no Android binary packaging/signing was claimed.

## Bounded atomic source handoff (2026-10-24)

`src/normalized_source_atomic_gate.bf` adds a BF-authored buffered admission component for one at-most-255-byte normalized instruction record with a required A5 guard. It emits `01` plus the entire admitted command stream only after checking the record, eight-command alphabet and bracket nesting; on failure it emits a lone `00`, with no partial command bytes. The 1,135-case local diagnostic batch passed after fixing the initial guard arithmetic. A further six source-to-existing-compiler artifact regression checks and four annotated-source rejections passed with external diagnostic coordination. See `docs/normalized-source-atomic-evidence.md` and `.json` for the exact evidence and test boundaries. The record is an interim diagnostic interface, **not** BFIO or an accepted complete-source host-closure contract. It cannot detect trailing bytes after the guard without a trusted host. No BF-owned integrated annotated-source router, fully COCK-conformant interpreter, nested full compiler self-host proof, or Android device build is claimed.

## Bounded atomic printable Stage A source gate (2026-10-24)

`src/stage_a_atomic_subset_gate.bf` and `src/stage_a_atomic_printable_gate.bf` now provide an additional, bounded *single BF-owned admission-and-release transaction* for an **already normalized** Stage A arithmetic guest. They buffer all declared bytes and check the complete guarded record before releasing any guest commands. The printable variant also verifies modulo-256 arithmetic produces `0x20..0x7E`; unsupported commands, missing or repeated output, invalid guards and nonprintable results yield only one failure byte. No accepted source is replaced by a precomputed output table.

The two files passed **1,366/1,366** and **1,620/1,620** local diagnostic cases respectively. All six previously frozen AArch64 raw instruction outputs were reproduced through the printable admission gate and the existing BF-in-BF diagnostic reference. **18/18** `.bf` source files passed the lexical/bracket static audit. See `docs/stage-a-atomic-printable-evidence.md` and the machine-readable evidence files.

This narrows a Stage A source-handoff gap, **but does not establish trusted physical stream closure**; deliberately appended bytes remain invisible to the BF gate. The single-byte count permits at most 255 normalized source bytes per diagnostic record, not a permanent source limit or a protocol change. The strict annotated-source parser, compiler handoff, and host closure are still separate; the local diagnostic launcher is outside the repository. The COCK-owned interpreter, mandatory nested execution of the *actual* mini compiler, Android loader and APK/device evidence remain missing. Outside-repository Python assisted source editing and diagnostic coordination, so stronger BF-only development-process provenance has not been certified. Stage A is **NOT ACCEPTED**. Android stays deferred.

## COCK owned six cell BF in BF interpreter diagnostic checkpoint

`src/bf_in_bf_six_cell.bf` is a new, separate COCK-owned Brainfuck interpreter kernel supporting all eight operations for programs whose guest pointer stays within six cells. It receives source in multiple count-prefixed byte chunks followed by guest input; the input grammar is a **provisional diagnostic fixture format**, not the canonical BFIO/BHIO transport. The unchanged original and compact BF mini compilers ran as guests and produced six identical frozen raw AArch64 artifacts, with 93 bounded reference-differential test cases and 11 reproducible binary fixture replays passing. See `docs/six-cell-interpreter-evidence.md` and `fixtures/six_cell/`.

The component is **not COCK profile conformant or production safe**: guest pointer bound traps, fuel/trace, trusted closure/source preflight and full nested compiler self-interpretation remain absent. The kernel is not an ELF/APK builder; Android is deferred. Outside-repository Python-assisted drafting prevents certification of stronger pure-BF development-process provenance. The previous first-generation arithmetic-only interpreter remains preserved.

## Six cell static source safety checkpoint — 2026-10-24

`src/six_cell_static_safety_gate.bf` is a diagnostic Brainfuck-authored admission gate for the existing six-cell BF-in-BF interpreter. It validates the normalized instruction alphabet, all bracket pairs and static pointer travel within guest cells zero through five; each admitted loop restores its entry pointer. The consolidated local diagnostic batch passed **1,163/1,163**, including both full mini compiler sources, all six prior raw-code artifacts, and malformed inputs. See `docs/six-cell-static-safety-evidence.md`.

This is **not** a general COCK source preflight, runtime trap implementation, full host stream-closure proof or mandatory nested self-hosting proof. A verified BF-owned admission-to-interpreter handoff remains outstanding. Android work remains deferred.

## Bounded arithmetic runtime fuel diagnostic — 2026-10-24

Added `src/bounded_arithmetic_fuel_executor.bf`, a standalone single-cell BF guest execution component with one-byte configurable instruction fuel. It charges each executed arithmetic or final-output command before effects, returns a diagnostic status byte and emits the guest byte only after successful completion. The exact-byte local suite passed **1,279/1,279**, with **6/6** unchanged raw native compiler artifacts and **21/21** BF static source audits. Input/output framing is diagnostic-only. It **does not** give the existing six-cell BF-in-BF kernel guest fuel or constitute a nested compiler proof. Source-preflight precedence and independent closure remain incomplete; Android is deferred. See `docs/bounded-arithmetic-fuel-evidence.md`. External Python BF-layout assistance means strict repository-wide BF authorship provenance has not been certified.

## Bounded all-command guest runtime fuel diagnostics

`src/bf_in_bf_six_cell_fuel.bf` adds a **separate BF-in-BF execution prototype** that handles original guest `+-<>[].,`, nested loops, exact bounded instruction fuel, pointer boundary traps, and binary bytes. A 438-case local reference-differential diagnostic batch passed, six old compiler artifacts remained identical and the 22-file `.bf` syntax audit passed. See `docs/six-cell-fuel-evidence.md` and its JSON companion.

**Not promoted to a complete compiler kernel:** this new fuel-aware prototype has a 32-command guest source budget and cannot execute the real 515-/452-command BF mini compilers. The existing full-compiler-capable six-cell interpreter is preserved but does not yet implement runtime fuel. These two independent capabilities must be integrated into a scalable BF-in-BF interpreter before full self-hosting acceptance. External test/drafting aids were not checked in, but strict BF-only authorship provenance and exact host closure remain uncertified. Android remains deferred.

## COCK owned two level arithmetic interpretation smoke checkpoint

Added `tests/nested_arithmetic_driver.bf`, a BF authored diagnostic byte driver emitting the existing 103 command COCK arithmetic interpreter as a guest program for `src/bf_in_bf_six_cell.bf` and relaying an admitted arithmetic input. The local diagnostic root executed 13 of 13 nested arithmetic cases to exact output; all six original and compact single layer compiler artifacts remained byte identical, and 23 of 23 tracked BF sources passed the lexical audit. See `docs/nested-arithmetic-evidence.md` and the matching JSON report.

**This is not the full mandatory Stage A self interpretation gate.** The inner interpreter is the small arithmetic evaluator, not a copy of the six cell kernel, and it does **not** run the actual AArch64 mini compiler. Two malformed input probes still execute without complete source preflight. The outside repository C root is diagnostic only, and an outside Python source layout aid means strict BF only development process provenance remains uncertified. No Android device test was run.

## BF authored compiler request handoff checkpoint — 2026-10-24

`tests/compiler_request_framer.bf` now forms the diagnostic six-cell interpreter source records using only BF executable instructions; it receives the complete admitted original or compact compiler source as data. It passed 13 of 13 exact framing tests and all six unchanged raw AArch64 artifact regressions, with 24 BF source files passing static audit. Source lengths above 255 work through repeated one-byte records, with overhead rather than truncation. `docs/compiler-request-framer-evidence.md` records the tests and known missing-separator, embedded-NUL and invalid-byte counterexamples.

A separate attributed BF reference running its own source passed four small nested examples, **but full COCK-owned interpreter self-interpretation of the real mini compiler remains NOT VERIFIED**. The diagnostic executor and staging coordinator are outside the repository; no production bootstrap or closure acceptance is claimed. Android remains deferred.

## Chunked atomic compiler handoff — 2026-10-24

`src/chunked_atomic_compiler_handoff.bf` is a new BF-only exact-source admission and six-cell-loader emission component. It accepts multiple 1-to-255-byte normalized source chunks (no 255-byte **total** source ceiling in this component), checks every source byte and bracket pair, verifies the final A5 guard, and **withholds all source output until the full packet passes**. Success is `01` followed by all `01,command` pairs and a `00` source terminator; rejection emits only `00`.

Its first consolidated batch passed **387/387** exact-byte source cases, **6/6** unchanged AArch64 compiler artifacts (three apps through both unchanged BF mini compilers and the COCK six-cell kernel), and **25/25** repository BF audits. Both entire mini compilers and 1,024-command synthetic source inputs succeeded. An invalid record with trailing bytes after a valid guard still requires independent host closure, so this is a **diagnostic handoff, not a production input authority**. The existing `tests/compiler_request_framer.bf` is preserved as the older less-safe diagnostic alternative. Full same-interpreter nested compiler execution and Android/device verification remain unverified or deferred. See `docs/chunked-atomic-compiler-handoff-evidence.md` and `.json`.

## Latest Stage A nested execution checkpoint

The BF-only `tests/nested_reference_transport.bf` now constructs counted-source and binary payload requests for nested BF diagnostic execution. The external diagnostic BF evaluator ran an independently attributed BF-in-BF reference, which ran the unchanged COCK six-cell BF-in-BF kernel, which ran five small BF guest examples: 5/5 exact outputs. The new source-transport driver passed 9/9 exact-output fixtures and all six original/compact native-code regression outputs remain unchanged. This is **not** same-implementation self-hosting and no complete mini compiler has run successfully at this two-level interpretation depth. The nested compact compiler timed out with zero generated bytes. Source/host closure and Android remain unsupported or deferred. See `docs/nested-kernel-evidence.md` and `docs/dynamic-interpreter-next-design.md`.

## Dynamic linear guest tape checkpoint — 2026-10-24

Added `src/bf_in_bf_dynamic_linear.bf`, a COCK-authored **diagnostic five-command linear BF-in-BF interpreter** that stores guest cells in adjacent twelve-cell outer BF records rather than using a six-cell array. It implements `+ - < > .`, wrapping arithmetic, on-demand zero-initialized rightward guest tape, left-of-zero trap status `04`, and an unsupported-opcode status `0D`. It emits raw guest output followed by one terminal diagnostic status byte; it is **not** the normative COCK result format.

The consolidated batch passed **520/520** exact-byte component cases (20 fixed/boundary and 500 deterministic randomized), including logical guest address 7200 and a diagnostic host tape reallocation, plus **6/6** unchanged old six-cell compiler artifact regressions. The source and the older interpreter are separate. Loops, `,`, source preflight/closure, exact offsets, fuel, configured logical cell budget, the same-interpreter full nested compiler proof and Android testing remain missing. See `docs/dynamic-tape-evidence.md`, `.json`, and `docs/dynamic-tape-slice-plan.md`. Stage A is **NOT ACCEPTED**.

## Dynamic tape clearing loop diagnostic checkpoint

`src/bf_in_bf_dynamic_clear_loop.bf` extends the previous right-growing tape interpreter with the exact guest `[-]` loop construct. It handles clearing loops on addresses beyond the previous six-cell ceiling, while all other guest loop patterns and comma-input remain explicitly unsupported. This is a **restricted BF-in-BF diagnostic**, not a complete `COCK` interpreter, a replacement for the compiler-capable six-cell kernel, or an accepted self-hosted compiler.

The consolidated diagnostics passed **524/524** clearing-loop guest cases (14 fixed and 510 additional randomized/boundary cases); the preserved compiler path matched **6/6** frozen native instruction outputs and the repository syntax audit passed **28/28** BF source files. The test inputs require external physical byte-count authority. Embedded source NUL, invalid-suffix partial output and trailing bytes after the delimiter are demonstrated missing safety requirements. The same-interpreter nested compiler proof and Android target tests remain unfinished. See `docs/dynamic-clear-loop-evidence.md` and `docs/dynamic-clear-loop-slice-plan.md`.

## Dynamic tape bidirectional clearing checkpoint — 2026-10-24

`src/bf_in_bf_dynamic_bidirectional_clear.bf` expands the previous dynamic-tape diagnostic from the single clearing loop `[-]` to both `[-]` and `[+]`, with each recognized as the exact three-command guest sequence. An independently run outside-repository diagnostic batch passed **835/835** supported guest cases, **6/6** old original and compact compiler artifact regressions through the unchanged compiler-capable six-cell BF interpreter, and **29/29** BF source-format audits. See `docs/dynamic-bidirectional-clear-plan.md`, `docs/dynamic-bidirectional-clear-evidence.md` and the corresponding JSON evidence and fixtures. The previous linear and one-sided clear-loop implementations remain unchanged.

**Important:** This is not generic nested-loop support and cannot execute the full compiler. Optimizing `[+]` or `[-]` without original-command accounting is not valid under finite COCK guest-fuel semantics. Source validation, physical transport closure, guest comma input, full interpreter traps, original source offsets, nested same-interpreter compiler execution and Android device acceptance are not complete. No Android tooling installation or emulator run was attempted.

### General forward bracket target diagnostic — 2026-10-24

`src/general_forward_bracket_probe.bf` finds arbitrary nested forward bracket targets in prevalidated normalized Brainfuck suffixes. It passed **572/572** local diagnostic cases, including **57/57** queries over the original and compact mini compiler sources. The existing six AArch64 compiler outputs remain unchanged. See `docs/general-forward-bracket-evidence.md`. This is a bounded jump-target primitive, not full general loop dispatch, trusted host closure, or self-hosting acceptance. Android remains deferred.

## Backward bracket lookup and Brainfuck source reversal

The next bounded slice added `src/reverse_normalized_source.bf` and `src/general_backward_bracket_probe.bf`. The first performs exact reversal of a previously admitted normalized source prefix in Brainfuck; the second finds the matching opening bracket for a closing bracket at the end of that prefix. The private diagnostic output is a checked unsigned sixteen bit distance and a one byte result status. In the consolidated local test batch, **487/487** exact-byte cases passed, including **57/57** closing bracket queries against both real mini compiler sources; **6/6** old compiler AArch64 raw outputs remained unchanged, and **32/32** BF source audits passed. Details are in `docs/backward-bracket-evidence.md` and its JSON companion.

**These are not a general loop interpreter.** Integrating random-access guest source, instruction PC, exact guest fuel and dynamically growing tape is unfinished. Two known negative probes show that extraneous input after a zero terminator remains undetected unless host-reported exact byte count/closure is independently validated. Same-interpreter nested full compiler execution and Android device proof remain **NOT VERIFIED / DEFERRED**.

## Latest Stage A checkpoint — whole source bracket pairing

The BF authored `src/whole_source_bracket_pairs.bf` emits all normalized command bracket pairs in a single pass using a mobile stack. It passed 506 of 506 local diagnostic vectors, with all six prior AArch64 raw compiler outputs unchanged. The stream uses a provisional zero marker and **does not** establish input closure or full self-hosted execution. Read `docs/whole-source-bracket-evidence.md` for complete limitations. Android work remains deferred.

## General program counter diagnostic checkpoint

`src/bf_in_bf_pc_dispatch.bf` provides a bounded general-loop BF-in-BF interpreter, beyond the earlier special-case clearing loops. It passes local differential and binary fixtures, with 127-command source, 16-cell guest tape and 8-bit fuel limits. It is not suitable for untrusted source or the full mini compiler. Read `docs/pc-dispatch-evidence.md` before using it. All six prior AArch64 artifacts remain preserved; Android device work remains deferred.

## Stage A normalized command byte offset admission checkpoint

A new BF only `src/normalized_source_offset_gate.bf` reports the first invalid byte position without executing the guest. Its 1175 local diagnostic cases and six unchanged raw compiler artifact regressions passed. It accepts length limited normalized source records with a checked terminal guard only; bracket preflight, annotated grammar, BF owned admission routing and independent host closure remain separate unfinished requirements. Evidence in `docs/normalized-source-offset-evidence.md`. Android remains deferred and Stage A not accepted.

## New Stage A diagnostic: combined normalized-source offsets

`src/chunked_preflight_offsets.bf` combines command-byte validation, bracket error checks and 16-bit normalized-command offset reporting over chunked input. Local exact-byte diagnostics and six unchanged compiler-artifact regressions passed. This program does not establish annotated-source preflight, independent host closure or a BF-owned interpreter handoff. See `docs/chunked-preflight-offset-evidence.md`.

## Integrated bounded source preflight checkpoint

`src/bf_in_bf_pc_preflight.bf` adds complete normalized-source admission to the small general loop BF interpreter **before guest execution**. For example the prior `+.X` partial-output failure now returns only invalid-source status. New differential tests and preserved compiler regressions are recorded in `docs/pc-preflight-evidence.md`. This component is not a full source loader, not the compiler-capable kernel, not the mandatory nested self-hosting proof and not an Android build. Hardware/device checks remain deferred.


## Compiler capable BF in BF with integrated preflight — 2026-10-24

Added `src/bf_in_bf_six_cell_preflight.bf` as a separately testable companion to the unchanged six cell compiler execution kernel. It buffers source through the existing counted chunk loader, marks every actual source byte including NUL, checks the whole normalized command stream and bracket structure, and rejects malformed inputs before running any guest instruction. Successful programs retain the previous unframed guest output semantics. Its **446 of 446** completed local diagnostics include **six of six** frozen raw AArch64 outputs from the actual original and compact mini compilers. The source has **10,635** executable BF commands; see `docs/six-cell-integrated-preflight-evidence.md` and `.json`, with 25 inert input/output fixture pairs.

**NOT ACCEPTED:** this is still a six-cell, no-guest-fuel prototype. Its source admission is limited to normalized BF input; physical stream closure and original annotated source offsets remain unavailable. The mandatory same-interpreter nested mini-compiler proof and Android ELF/APK/device gates have not passed. Temporary external diagnostic and BF layout tools were used outside the repository, so strict BF-only development-process provenance is not independently certified.

### Additional diagnostic slice — checked guest logical tape budget

A separate pure `.bf` linear interpreter (`src/bf_in_bf_dynamic_budget.bf`) now traps right moves beyond an explicit one-byte per-invocation addressable-cell budget (1..256 cells). It passed 2,016 fixed, boundary and randomized local comparisons, plus 15 saved binary fixtures. Existing full compiler artifacts were independently reproduced with the preserved six-cell kernel. This does **not** implement a fully scalable interpreter or nested full-compiler self-hosting; see `docs/dynamic-logical-budget-evidence.md`.

## 2026-10-25 — Budgeted dynamic tape with clear loops

`src/bf_in_bf_dynamic_budget_clear.bf` now combines checked rightward guest tape growth with literal `[-]` and `[+]` clearing loops in a BF-only bounded diagnostic interpreter. A 630-case model batch, 80 common-linear regressions and 7 growth/budget boundaries passed; all six original/compact compiler outputs remain unchanged through the separately preserved compiler-capable preflight interpreter. Full arbitrary loops, trusted input closure, original-command guest fuel and same-interpreter nested mini-compiler execution remain **UNVERIFIED**. See `docs/dynamic-budget-clear-evidence.md` and JSON. Android remains deferred.

## Checked dynamic tape with general zero valued loop skipping

`src/bf_in_bf_dynamic_zero_skip.bf` adds nested forward bracket scanning on a zero guest cell to the restricted dynamic tape interpreter, while retaining checked logical right travel and earlier exact nonzero clearing loops. Its **533/533** local diagnostic cases and **90/90** preserved subset comparisons passed after repair of a marker clearing defect. The six saved AArch64 compiler candidates still match through the unchanged compiler capable interpreter; the new dynamic component is *not* itself compiler capable. It is **not full source preflight**, an arbitrary loop interpreter, a completed nested self hosting path, or Android code. Consult `docs/dynamic-zero-skip-plan.md` and the matching evidence.

## 2026-10-25 buffered PC dynamic tape interpreter checkpoint

`src/bf_in_bf_pc_dynamic_prototype.bf` is a new executable Brainfuck-only bounded interpreter that integrates complete normalized-source preflight, eight guest commands, arbitrary nested loops, right-growing guest tape, original-command fuel, binary input/output and logical pointer limits. Local differential diagnostics passed **1,616/1,616**; **22/22** frozen binary fixture pairs passed; the unchanged six-cell compiler route preserved **6/6** AArch64 raw artifacts. See `docs/dynamic-pc-interpreter-evidence.md` and JSON. Source/fuel/tape record widths remain one byte, so this does **not** execute the full mini compiler or prove same-interpreter nested self-hosting. Physical host closure, complete annotated-source offsets, and Android testing remain unverified or deferred.

## 2026-10-25 sixteen bit source indexing slice

`src/source_pc_16bit_ledger.bf` is a new BF authored, development-only indexed-source ledger. It emits `(u16 little endian command position, source opcode)` triples, then a checked provisional terminal marker. It accepts both actual compiler sources at 515 and 452 commands, with a tested 65,535 command invocation limit. In the completed local diagnostic suite 572 of 572 ledger comparisons passed; the preserved compiler-capable interpreter separately reran all six previously frozen AArch64 outputs byte for byte. A 43-file BF syntax audit passed. See `docs/source-pc-16bit-evidence.md` and JSON for exact tests, hashes and boundaries.

This is not a new `COCK` wire protocol, not a general program counter interpreter and not compiler self-host acceptance. Two observed negative cases demonstrate that physical EOF and trailing data still demand trusted host closure. The 255-command dynamic program counter interpreter has **not** been extended by this change. Strict development-process BF-only authorship provenance, full nested compiler self-interpretation and Android device functionality remain **UNVERIFIED / DEFERRED**.

## Sixteen bit random instruction lookup checkpoint

`src/source_pc_16bit_fetch_many.bf` adds a BF-authored source-resident command fetch primitive for repeated nonmonotonic `u16` command positions. The 332 local execution cases and 6 unchanged compiler-output regressions passed. This is not a full interpreter. Full-source validation, trusted stream closure, runtime fuel, dynamic tape and mandatory same-interpreter nested compiler execution remain incomplete. Android work stays deferred. See `docs/source-pc-16bit-fetch-evidence.md`.

## Sixteen bit PC and guest fuel decision diagnostic

`src/source_pc_16bit_fuel_branch.bf` now computes one step of validated source PC control flow from supplied opcode, bracket partner and guest cell, decrementing a sixteen-bit guest-command fuel budget before the selected instruction. The consolidated local diagnostics passed **2557 of 2557** individual decisions in 23 fixture batches, including every command and all loop bracket states in the original and compact mini compiler sources. The independent BF bracket pairing baselines and all six existing raw AArch64 output artifacts also passed unchanged. See `docs/source-pc-16bit-branch-evidence.md`.

This component **does not execute the guest**, verify supplied partner offsets, establish host input closure, or satisfy the mandatory nested compiler self-hosting requirement. Strict development-process purity certification and Android device proof remain unavailable; Stage A acceptance remains incomplete.

## Sixteen bit PC and arithmetic decision slice

The BF authored `src/source_pc_16bit_cell_step.bf` now combines next command PC selection, sixteen bit guest fuel and one executed guest cell arithmetic change. Local tests passed **7581 / 7581** exact decision records. The six frozen AArch64 binaries still reproduce unchanged through the preexisting compiler interpreter. This is not yet a general guest interpreter: source mapped fetch, guest tape across steps, input output, host closure, and same-interpreter nested compiler remain unverified. See `docs/source-pc-16bit-cell-step-evidence.md`.

## Sixteen bit guest execution step — diagnostic only

`src/source_pc_16bit_guest_step.bf` executes a single original guest BF instruction per supplied record while applying checked 16-bit PC and fuel rules, pointer-boundary checks, modulo byte cell arithmetic, EOF/input and binary output-candidate flags. A consolidated diagnostic batch passed **1,182/1,182 step records** and all six frozen legacy raw AArch64 artifact regressions; **47/47** `.bf` sources passed the annotation audit. The new component is not a self-contained interpreter: source fetch, trusted bracket mapping, guest tape persistence and host closure are external or unimplemented, so no Stage A or nested self-hosting acceptance is asserted. Full evidence and known failures: `docs/source-pc-16bit-guest-step-evidence.md` and `.json`. Android remains deferred.

## 2026-10-25 integrated sixteen bit arithmetic interpreter

`src/source_pc_16bit_arithmetic_exec.bf` now retains source, completes normalized-source byte admission, executes real arithmetic guest operations and enforces sixteen bit original-command fuel in **one BF executable**. This integration passed **966/966 local diagnostic cases**, including 65,535 source commands. There are 40 new exact-byte fixture pairs; all 40 pairs were independently rerun from stored binary inputs. The unaltered compiler-capable interpreter separately reproduced all six original/compact AArch64 raw instruction streams with exact matches. **This new interpreter supports only `+ - .`, cannot run either full mini compiler and has no authoritative host transport closure.** It is not COCK self-hosting acceptance or an Android binary. See `docs/source-pc-16bit-arithmetic-exec-plan.md`, `docs/source-pc-16bit-arithmetic-exec-evidence.md`, and JSON.

## 2026-10-25 — 16-bit retained source and checked eight-cell guest operations

`src/source_pc_16bit_eight_cell_exec.bf` combines 16-bit normalized-source admission and instruction fuel with a **working eight-cell guest tape**, checked pointer movement, binary guest input/output and arithmetic wrapping. It executes the six-command `+ - < > . ,` subset and atomically rejects other commands, including general loops. A seeded 1,045-case differential batch passed; 53 new exact-byte binary fixtures, 25 compatible historical arithmetic fixtures, all six *unchanged* compiler-output regressions through the **older full-loop six-cell kernel**, and the 49-file BF grammar audit passed. See `docs/source-pc-16bit-eight-cell-evidence.md` and `.json` for exact scope.

**No new compiler-through-this-interpreter claim:** the real mini compilers have brackets and are rejected by this new kernel. Trusted physical host closure, framed production status, general nested loops, scalable guest tape, same-interpreter recursive self-hosting, independently qualified root and strict BF-only development-process provenance remain unresolved. Stage A is NOT ACCEPTED. Android is DEFERRED.

## 2026-10-25 — Full eight command compiler capable source retained interpreter

`src/source_pc_16bit_eight_cell_loops.bf` is a new **single integrated BF-in-BF interpreter** using 16-bit normalized-source length, 16-bit original-command fuel, eight checked guest cells, full lexical/bracket preflight, binary input/output and **general nested loops**, with no guest execution before admission. It passed **1,160/1,160** differential diagnostics, 67 saved diagnostic fixture replays and **all six frozen real AArch64 outputs produced directly by the NEW interpreter** using both 515-command original and 452-command compact BF mini compilers on all three applications. **73** total literal input/expected fixture pairs and **50/50** repository BF syntax audits passed. See `docs/source-pc-16bit-eight-cell-loops-evidence.md` and JSON for instruction/fuel limits and negative tests.

**Stage A STILL NOT ACCEPTED:** the mandatory identical-interpreter nested real compiler proof is not established. Eight guest cells and 16-bit fuel/source format do not support full self-hosting. This is not a dynamic large guest tape and does not provide trusted physical stream closure, full annotated-original-source offset preflight, qualified BF-only development process, authoritative framing or Android ELF/APK/device acceptance. Android remains deferred.
