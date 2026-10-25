# Stage B AArch64 AOT design draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**NOT IMPLEMENTED.** This design fixes semantic lowering responsibilities. Exact emitted instruction/relocation goldens must be authored independently when the BF emitter is drafted, before its test gate. No assembler/compiler-generated app code or checked-in native byte template may supply the implementation.

## O0 native control flow

Emit one native block per admitted original command. Each block retains its raw source offset and static successor/paired-bracket destinations. Generated code makes direct native transitions; it does not fetch/decode BF at runtime or call a foreign interpreter. A reusable BF-generated service may perform checked allocation, fuel and I/O. Compiler and runtime emitters themselves execute through the BF-in-BF tool interpreter in the normal build path.

At the block entry call `tick(handle, original_offset)` under the [runtime contract](stage-b-runtime-draft.md). On nonzero return enter the single terminal path without executing the command. On success issue the command's native operations/checks. Runtime work, helper instructions and zero-initialization loops consume no extra **guest** command count. The block never reports OK after a failed helper. Do not fold, fuse, delete, reorder or specialize commands in O0, including empty, clear and transfer loops.

| Opcode | Lowered responsibility after tick | Successor |
| --- | --- | --- |
| `+` | Load current byte, add one, store low byte | Next block |
| `-` | Load current byte, subtract one, store low byte | Next block |
| `>` | Checked target address increment; call checked cell/growth service; update pointer only on success | Next block |
| `<` | Test zero and return LEFT_BOUNDARY if so; resolve previous cell without growth; update pointer only on success | Next block |
| `,` | Call input service with current cell destination; write returned raw byte or EOF zero; increment input only for real byte | Next block |
| `.` | Call output service with unsigned current byte; preserve raw byte and actual write result | Next block |
| `[` | Load current cell; zero selects block after matching close; nonzero selects next block | Selected native block |
| `]` | Load current cell; nonzero selects first block after matching open; zero selects next block | Selected native block |

The terminal successor is a distinct epilogue, not an extra guest command. `[]` on zero executes exactly one tick; `+[]` with finite fuel cannot loop forever without checking fuel. Helpers preserve documented AAPCS64 callee-saved registers. No callee may retain a pointer into freed/reallocated tape storage across an allocation. Resolve/reload the current cell after a helper that can move backing metadata. A never-grown zero cell may need allocation on first write; failure is HOST_ALLOCATION_FAILURE, not a logical-limit error.

## Register, stack and ABI ownership

`ANativeActivity_onCreate` has the OS signature, separate from exported `cock_guest_run_v1(context*, result*)`. The guest entry receives 40-byte context and 56-byte result pointers in x0/x1, validates trusted lifetime/alignment/version/size/flags/reserved fields and runtime binding, and returns its terminal status in w0 matching result status. A nonzero invocation-scoped runtime handle is mandatory for this service-based B design. Reject the Stage A no-service shortcut for B input/tape/fuel.

Proposed O0 working assignment is x19 context, x20 result, x21 service, x22 logical pointer, x23 current cell pointer and x26 block raw offset; x24/x25/x27/x28 are available for explicitly owned temporary values. Service state is authoritative; O0 does not cache executed or remaining-fuel counters across helper calls. A later counter cache would require a separately tested optimization preserving every observable trap/trace/return. Preserve original x19–x29/link register, keep SP 16-byte aligned across calls, do not use the nonexistent AArch64 red zone, and treat x0–x18 as call-clobbered, with x18 reserved for the platform. x16/x17 are linker/call scratch. ABI tests must clobber caller-saved registers to expose accidental dependencies.

On every terminal path snapshot actual counters/offset/status to the result before releasing service resources. Validate external entry arguments through the adapter's known live allocation/registration boundary; alignment alone cannot authenticate arbitrary native pointers. Reject a mismatched known header or stale/unregistered handle without following its function pointers. An unmapped hostile native pointer is not promised recoverable by ordinary in-process checks; isolate those ABI-negative processes and report actual fault behavior.

## Layout, branches and dynamic linking

First BF pass computes checked block/helper/data sizes and symbol/branch records; second BF pass serializes from that same immutable admitted source and policy. Never read an independently substituted second source pass. The [uploaded diagnostic](upload-executable-run-evidence.md) already demonstrates why matching separately supplied passes is mandatory. Record exact source/native/map identities across passes.

Check signed branch displacement, instruction alignment and target membership independently. Use ordinary AArch64 branches when their immediate range fits. Otherwise a BF-generated veneer loads a relocated full-width target and branches through call-clobbered x16; conditional lowering may invert the condition around that veneer. Specify each selected literal/veneer instruction and `R_AARCH64_RELATIVE` target in the pretest native vectors. Do not truncate a signed immediate or introduce executable writable memory. If a layout cannot be represented by the implemented path, return an explicit capability/overflow failure before emitting a successful artifact; record that implementation limit separately from language semantics.

The BF ELF layer must support RX text, read-only constants/input/source maps and RELRO pointer tables, separate RW invocation/global state, non-executable stack, page-correct segment offsets/addresses and dynamic linking for the actual Android imports. Proposed physical imports include Bionic allocation/thread/descriptor services and optional `liblog.so` diagnostics. Inspect symbol availability and exact NDK signatures before freezing implementation; never assume a Linux ET_EXEC exit wrapper is an Android shared library. BF owns symbol/hash/string/dynamic tables, relocation addends, import calls and all runtime code.

Retain 16-KiB ELF LOAD and uncompressed ZIP alignment design; independently test actual 4-KiB/16-KiB rows before marking each compatible. External `aapt2`, ZIP, `zipalign` and disposable-key signing may create only the debug container/signature. Extracted final `.so` must equal the complete BF-produced prepackage bytes. Disassemble actual generated blocks and check representative source-to-native differences; metadata, changed input data or a fixed probe does not prove source-driven codegen.

## Required proofs before acceptance

Native byte tests cover every command, both loop branches, nested paired targets, empty source, maximum representable immediate boundaries and forced veneers, all terminal paths, result layout, call/return preservation and integer overflow. Stateful AOT tests must additionally compare actual register-independent guest state, counts, offsets, binary output and trap precedence against the independent oracle. A disassembler confirms structure; only actual native execution can establish behavior. Test helper failure injection and cancellation at original boundaries, then repeat unaffected Stage A debug installs/launches. No Stage B optimization or promotion is available before those checks pass.
