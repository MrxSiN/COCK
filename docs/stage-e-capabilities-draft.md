# Stage E modules, Android gateway and optional capability draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Design only.** A registry is a checked set of supported contracts with evidence, not a list of APIs automatically implemented. Initial `ui.touch`/`ui.text` requests are themselves still unsupported. This package creates no new public event/action IDs or callable instructions.

## Modules and registry

Each module is an independent eight-command execution unit with source identity, role, profile, budgets, input/output contract and declared dependencies. V1 main modules and event handlers run through BF-generated native entry/dispatch with isolated tapes. Nonempty named imports/exports, general frame-mediated nested calls and arbitrary shared guest addresses return UNSUPPORTED_CAPABILITY. Adding direct calls requires a separate versioned request/return/native ABI, ownership, reentrancy and cancellation proof; source concatenation is not linking semantics.

Per capability record bind exact ID/version, config/schema/API/ABI requirements, BF source/gateway owner, event/action/typed argument/result grammar, import/service set, thread affinity, handle types/generation/lifetime, permissions, resources/budgets, failure/partial-effect policy and independent positive/negative/device evidence. Compute dependency closure and reject unknown/incompatible/missing features before code generation. Include only required BF-generated executable support and inert resources. Design-only or failed capability cannot be advertised as supported from a registry row alone.

## Permissions and native/JNI gateway

Select a specific documented Android operation before implementing its typed native/JNI adapter. Fix exact platform signature/API range, argument encoding, return/error and exception mapping, required component/manifest permissions, runtime grant flow, callback queue/lifetime and acknowledgement semantics. The gateway validates length/range/type and translates only registered operations; it cannot expose raw pointers, arbitrary JNI class/method lookup or native command execution from guest strings.

Manifest permission declarations derive from the validated capability plan; request only required permissions. Check actual runtime grant state at use, handle denial/permanent denial/revocation/cancellation/lifecycle changes explicitly and fail without unauthorized work. Permission declaration is not permission grant. No security setting or Android restriction is disabled. UI touch/text baseline requests no dangerous permission; E09's broader platform operations remain unsupported until selected and verified.

JNI adapters must attach only on allowed worker paths, manage local/global references and pending exceptions, detach threads they attached, avoid stale JNIEnv across threads, pin object/array lifetime and marshal UI-required work to its owner. Native/managed callbacks reenter only through the registered event dispatcher with generation checks and queue/backpressure policy. Some APIs require BF-generated managed classes/components; one universal JNI call cannot supply them. Abort unsupported cases rather than hide a Java/Kotlin helper or untracked conventional runtime.

## Optional DEX group — E10

Only generate DEX when the selected app capability needs it. BF owns header/version/magic/endian/file size, SHA-1 signature and Adler-32 checksum over their proper distinct regions, aligned map/data sections, sorted/unique string/type/proto/field/method identifiers, class definitions, code/register/branch/try/handler records and references. Select the exact DEX version permitted by the target before source freeze. Check index/offset/ULEB/SLEB/branch widths and explicit overflow/multidex policy; no arbitrary global class cap.

First slice is one minimal BF-generated managed class with one required platform interaction and independent DEX parser/ART loader/behavior verification. Include checksum/branch/register/exception/reference and extra executable provenance negatives. No foreign DEX assembler/compiler or Java/Kotlin source provides output. Known Android libraries are platform dependencies only where explicitly allowed, not copied app-specific code. The native-only baseline must have no unnecessary DEX. Current capability status is UNSUPPORTED, not an implementation promise created by selecting its name.

## Optional physical services — E11

Select one bounded service and completely freeze its typed wire/API/permission/data/handle/resource/ack/error/idempotency/partial-effect contract before implementation tests. Proposed first storage scope is app-private versioned opaque blob read/replace with exclusive staging, actual sync/close/rename evidence, restart recovery and schema checking. It is not covered by the UI logical-state transaction; filesystem durability needs real evidence. The storage operation IDs/payload grammar are not yet registered and requests remain unsupported until that complete selected capability is specified and tested.

Network scope must specify destination policy, sizes, DNS/TLS/certificate/timeouts/cancellation, response ownership and the fact that a transmitted request may have external effect even if the reply is lost. Do not retry an irreversible request as if no effect occurred. Hardware scope names the concrete sensor/camera/etc., permission/resource ownership, callbacks/sample encodings, device availability, revocation and cleanup. No network request, hardware activation or external message is performed by this drafting task. No generic irreversible action is smuggled into UI action type 1 or no-op type 0.

## Distribution and compatibility — E12/E13

Preserve the accepted direct-install APK route. AAB is a separate optional BF-owned bundle/protobuf/module/manifest/resource/ZIP/upload-signature implementation, with current channel/API policy retrieval, upload-key versus Play App Signing custody roles and independent bundle/derived APK verification. An APK renamed `.aab`, an external production bundle builder or a signed debug APK is insufficient. Store upload/publication is outside this drafting request; real key/security/release gates remain separate.

Every advertised matrix row names OS/API range, ABI, device page size, loader/manifest/component model, package compression/extraction, SDK, signing schemes, distribution channel and actual test device. Initial proposal stays API 35/arm64-v8a with separate 4-KiB/16-KiB rows, both untested. Cross-ABI support requires a BF code generator/native ABI/ELF/relocation/gateway implementation and its complete tests; API lowering is not a manifest-number edit. Unknown/unsupported combinations fail explicitly before output. A stable ARM64 bridge must be independently proved, not inferred from advertised ABI properties.

Optional features do not prevent accepting a correctly scoped initial touch/text capability, but each must remain visibly unsupported in capability negotiation and final reports. No broad Stage E/platform/Play claim follows from that narrow acceptance.
