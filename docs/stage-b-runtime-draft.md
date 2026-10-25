# Stage B native service and Android bridge draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Design only. No BF-generated service, worker, binary sink or service-ABI test implementation exists.** The installed NDK r28c header confirms NativeActivity's `internalDataPath` and `onDestroy` callback and Bionic's pthread declarations. This is interface inspection, not a running binding. Exact native structure offsets, imported symbol signatures, machine instructions and synchronization vectors must be pinned in the executable slice before testing.

## Invocation service surface

The unchanged 40-byte `COCK-NATIVE-ENTRY-v1` context points at an invocation-scoped BF-generated service. The following is an internal **proposed** service binding, independent of the public entry/header ABI. Its table is read-only after registration, aligned to 8 bytes, little endian and 96 bytes long.

| Offset | Width | Field |
| --- | ---: | --- |
| 0 | 4 | Internal service version 1 |
| 4 | 4 | Table byte size 96 |
| 8 | 8 | Flags 0 |
| 16 | 8 | Nonzero invocation ID, equal to entry context |
| 24 | 8 | Nonzero lifetime generation |
| 32 | 8 | Pointer to BF-generated owned mutable invocation state |
| 40 | 8 | `tick` function pointer |
| 48 | 8 | `cell` function pointer |
| 56 | 8 | `input` function pointer |
| 64 | 8 | `output` function pointer |
| 72 | 8 | `finish` function pointer, callable only by adapter/status authority |
| 80 | 16 | Reserved zero |

All functions use AAPCS64 and return the existing u32 status vocabulary in w0. `handle` and original offsets are u64; output slots are aligned, caller-owned and live for the call. Functions cannot turn guest output into authoritative status.

| Call | Arguments in x0 onward | Responsibility |
| --- | --- | --- |
| `tick` | handle, raw source offset | Validate live binding; check cancellation then enabled fuel, checked charge/count; no command effects |
| `cell` | handle, target address, raw source offset, pointer to u64 returned cell address | Check growth/limits/overflow, allocate and zero as needed; publish new logical high-watermark only on success |
| `input` | handle, raw source offset, pointer to u8 byte, pointer to u8 present flag | Read next immutable input byte; present=1 consumes one, EOF returns byte=0/present=0 and consumes none |
| `output` | handle, raw source offset, zero-extended byte | Write exactly one raw byte to private output descriptor, update count only after actual write; return physical failure explicitly |
| `finish` | handle, pointer to native result header | Adapter-only post-guest closure, result/status serialization and completion observation; never callable by guest-source bytes |

The adapter validates context/result provenance against its own live allocations and registered handle/generation before dispatch. Known accessible bad headers, unaligned pointers, stale/unregistered handles, repeated active IDs, unknown versions/sizes/flags and nonzero reserved fields fail ABI validation. No arbitrary native address may be dereferenced merely because its contents might form a table. Registry/lifetime synchronization and concurrent-entry behavior must be complete BF-generated routines, tested before acceptance. The narrow debug policy permits one guest worker per activity; an overlapping invocation fails explicitly rather than resetting a live tape. A second activity must have independent state or a documented explicit busy rejection; it cannot alias the first invocation.

## Tape and counts

Logical pointer begins at zero, high-watermark is one addressable cell and all values are zero. A configured maximum cell count must be at least one. An absent maximum and configured zero are different: zero is an invalid policy, not shorthand for unlimited. Right growth is committed on successful `>` movement, even if the next instruction moves left. A `<` at zero leaves pointer unchanged. Guest wrapping byte arithmetic is independent of native register width.

Proposed backing is 4,096-byte data pages addressed through a growable pointer directory. This is an allocator unit, not an Android device page-size claim or a universal guest tape cap. Check page index/offset/directory multiplication/addition and address+1 before narrowing or allocation. BF-generated initialization zeroes new storage before exposing it. The abstract initial zero cell may remain lazily unallocated; writing it or obtaining a mutable byte pointer may allocate. No stale cell pointer survives a helper that can change backing ownership.

Logical budget check precedes physical allocation at a growth movement. A disallowed target returns status 5 with no pointer/high-watermark change; admitted command count has already increased. Actual allocator failure returns status 7, never status 5 or EOF. A failed allocation cannot lose the old directory or make a partially initialized page visible. Keep ownership so all successful allocations can be freed after failure/cancellation. Physical allocation-failure timing is implementation dependent; deterministic tests inject allocation ordinal failures rather than compare host OOM timing.

Counters are checked u64. Track executed commands, input consumed, output emitted, pointer and logical high-watermark independently. Runtime temporary memory, compiler tape, captured input and frame buffers are not guest logical cells. Test trace output is a separate instrumented BF-generated build; it cannot increment guest stdout counters or appear in production output. Instrumented/native O0 identities are distinct and both need regression checks.

## Binary debug bridge

Input is a finite immutable read-only ELF byte region with exact declared length, emitted by BF from the separately sealed binary input snapshot. `00`, `A5` and `FF` are ordinary bytes. At EOF comma writes zero without incrementing consumed count. There are no guest-input host reads during execution in this first bridge; acquisition read failures are build/transport failures before publication. Interactive input, external file reads and live sockets remain unsupported capabilities with their own future contracts.

Output is raw bytes in an app-private file. The BF-generated worker opens the copied activity-private directory and creates an invocation-specific basename using exclusive creation, no symlink following and owner-only permissions. BF chooses normalized basenames; no guest output byte selects a path. Open failures are HOST_WRITE_FAILURE outside guest execution. Descriptor operations are narrowly declared Bionic OS physical services; byte selection, ordering, counters, paths, retry/status decisions and framing are BF-generated native logic.

Each dot writes one byte. Retry EINTR only after checking cancellation and preserving whether a byte was actually written. A successful one-byte write advances output count once. Zero/invalid progress or a physical write failure returns HOST_WRITE_FAILURE; do not silently drop bytes or replace them with text. No logging conversion or NUL terminator is applied to raw output. Descriptor/write bookkeeping overhead consumes no extra guest fuel. A cancellation interrupting an in-progress physical call is an external boundary observation, not a fabricated deterministic source step.

Keep `output.partial` bytes on a guest trap; correlate them with the terminal result. `finish` records the actual guest return and result, closes output, and writes a separate exact kind-02 BFIO result with phase 1 for a guest outcome or phase 4/5 for gateway/transport failure. A v1 result has the frozen 36-byte payload, **not** the 56-byte native result; output count is obtained from native evidence/file length, never appended to that payload. Correlation ID is the invocation ID. Preserve the first guest error and independently record later close/status-write failures. If guest execution was OK but final physical output fails, completion is not OK. Missing/failed status close cannot authorize success even if an OK frame was written provisionally.

After successful close/validated completion, the worker may rename the successful candidate to its BF-selected completed basename. Failed/unknown runs retain partial evidence and never a completed-success marker. Rename alone does not establish durability; no crash-durable storage claim is made. Use fresh exclusive names on retry. Status/result files cannot be overwritten by raw guest output that happens to resemble BFIO. Device `run-as`/ADB may mechanically extract exact private debug files where supported; independent BF validators and physical copy/close facts decide acceptance. If extraction is unavailable, binary observation is NOT VERIFIED. Logcat may announce invocation/PID/status for correlation but is not binary stdout or the sole completion authority.

## Android worker and lifetime boundary

The generated NativeActivity entry performs bounded validation/setup only: copy required platform metadata into owned storage, register callbacks/state and request a detached worker with explicit ownership. No guest loop, source read, file creation/write, worker join or condition wait runs on the main callback thread. Check pthread setup/create/detach errors and roll back partial ownership. If detached creation cannot be guaranteed through the selected supported attribute API, do not start a worker and then leak its join obligation.

The worker owns guest tape, immutable input references, output descriptors, result and completion. It uses copied private-path data and no borrowed `ANativeActivity*`, activity instance fields, window/input queue or asset manager after callback lifetime. Runtime/ELF data must remain live through worker exit; prove library/lifecycle lifetime under actual NativeActivity loading before accepting this design. If that cannot be established, change the design and inventory before claiming source readiness. No unverified assumption that detached pthread implies safe shared-library unload is allowed.

`onDestroy` atomically requests cancellation and releases only the activity's ownership; it never frees worker-owned state or waits on blocking guest I/O. The worker checks cancellation at every command boundary and in bounded runtime initialization/retry loops. Reference counting/registration uses declared acquire/release semantics and prevents completion, destroy and thread-start failure from double freeing. Cleanup performs no later callback through the destroyed activity. A worker blocked in an OS write may require separately supported cancellation/descriptor policy; no hard cancellation-latency promise follows from a flag. Test that failure explicitly and keep the capability blocked if lifecycle safety cannot be bounded.

Required native imports are limited to the actual Bionic allocation, pthread/synchronization, private descriptor and diagnostic APIs selected in the source inventory. Every imported service, signature, structure layout, thread-affinity rule and error mapping must be documented from the pinned NDK/primary platform contract before implementation freeze. No Java/Kotlin shim, conventional native helper or opaque runtime template is allowed.

## Failures and acceptance

Distinct observations include invalid ABI, guest left/budget/fuel traps, checked overflow, cancellation, physical allocation/output failure, worker start failure, native crash, lifecycle shutdown and unknown completion. A process timeout is an outer failure. Native w0/result agreement is necessary but not independent authority; require actual adapter-observed return, closed output/status, current invocation identity and device extraction facts. On destroy-before-completion, preserve CANCELLED/UNKNOWN as actually observed; no success is inferred from a stale file.

Test binary boundaries, EOF input counts, partial writes, forged status-looking raw output, stale handles, immediate teardown, rapid relaunch, concurrent invocation rejection/isolation, all allocator failure ordinals, thread setup failure, double cleanup and device responsiveness. Exact ABI offsets and emitted instructions must have independent BF checks and external LLVM inspection. Actual device install/load/return/lifecycle and binary file extraction remain mandatory; a host simulation or structurally valid library cannot satisfy them.
