# Stage E invocation, state and lifecycle draft

**Design only.** Preserve the master `COCK-APP-ABI-v1`; a long-lived Android process can complete many handlers. Process exit is not required per event, while a guest printing status is never proof of handler return.

## Exact byte ownership

One handler receives exactly one complete checked kind-03 BFIO frame, including header and trailer, with fresh nonzero correlation ID. Its payload is u32 handler_id at 0, u32 event_type at 4, u64 state_schema at 8, u64 prior_state_len at 16, u64 event_data_len at 24, then exact prior-state/event bytes: checked size 32+S+E. Validate handler/schema/capability/window binding before invocation. The handler starts on a fresh zeroed tape, pointer zero, bounded input and explicit finite resource/fuel policy.

Handler output may contain exactly one provisional kind-04 action, no guest terminal status or trailing stdout. Action payload is u32 handler_id at 0, u16 action_type at 4, u16 flags=0 at 6, u64 schema at 8, u64 next_state_len at 16, u64 action_data_len at 24, then replacement-state/action bytes. Size is checked 32+S+A. Type 0 requires no action data; type 1 requires the registered UI body; other types are unsupported until separately versioned/tested. Empty valid next state is permitted; it is not absent state by sentinel.

Only the trusted BF-generated dispatcher observes actual guest return/trap/cancel, validates complete action, and emits the exact 36-byte kind-02 terminal status payload with phase 4 and matching correlation. Native result/header and actual handler return must agree. Success external ordering is one action then one authoritative status. Failure may have no valid action; surface a real terminal failure when possible, otherwise UNKNOWN. Missing trusted return, forged status, extra action/frame, truncated action, mismatched IDs/schema or late output can never commit.

## State and local effect transaction

Keep authoritative states RECEIVED, HANDLER_COMPLETED, ACTION_VALIDATED, EFFECT_ACKNOWLEDGED, STATE_COMMITTED, FAILED and UNKNOWN. The terminal guest-success result is a prerequisite for applying an action, not proof that drawing/commit has succeeded. Record actual renderer/commit outcome separately; never rewrite guest completion to fake an acknowledged UI effect.

Stage the replacement opaque bytes. Recheck correlation, handler/schema, lifecycle/surface generation, capability and budgets immediately before local effect. For no-op, acknowledge locally without a renderer; for text, require actual registered draw/post acknowledgement. Commit replacement state only after the declared local action succeeds and the generation is still valid. Until commit, previous bytes remain authoritative. If pixels changed but acknowledgement/commit fails, preserve old logical state, mark visual state UNKNOWN, invalidate the correlation and request a safe full redraw from committed state when valid. Do not promise visual rollback or exactly-once Android effects.

State is schema-bound app data. First invocation/process restart has empty prior state absent a separately accepted persistence capability. Counter interprets empty as zero and later eight-byte u64; other apps may use different schemas/encodings. A schema mismatch is a hard ABI failure, not automatic conversion. No file/network/notification operation participates in the initial reversible-local transaction; those require separate idempotency/partial-effect/durability contracts.

## FIFO, threading and lifetime

One logical handler is in flight per application; admit later events FIFO as observed by the dispatcher. Queue capacity is a nonzero explicit per-app budget. Initial backpressure policy rejects the newest unadmitted event with recorded reason, preserving FIFO among admitted events; no silent coalescing or unlimited growth. Queued cancellation discards the event without guest work. In-flight cancellation prevents commit and requires trustworthy stop/error conclusion; stale/duplicate/old-session correlations remain invalid after restart or surface replacement.

Native callbacks copy only live required event data, acquire valid resource ownership and enqueue promptly. Run guest loops on a lifetime-managed worker with finite guest fuel; the callback does not block on execution, I/O, joins or rendering waits. Input-queue/window/surface/JNI work runs on the documented valid owner thread. Generated handle tables check type, generation, ownership and lifetime; an integer from guest state is not a native pointer. Library/worker/resource lifetime and cancellation under blocked physical services must be proved on target; inherited Stage B lifetime assumptions are still unresolved.

Separate guest fuel from host watchdog/process death and physical errors. A timeout/forced stop with no trusted return is UNKNOWN/NO-COMMIT, not an invented deterministic guest offset. On destroy, invalidate surface/event generations and cancel pending work; free only after all live owners release, without stale callback access or main-thread deadlock. Reentrancy/nested module calls are unsupported. Platform event arrival/loss is not globally deterministic, even though admitted events are serialized.

Tests must observe handler completion while process stays alive; action-then-trap; forged status; two actions; streaming cancellation; old correlation; state schema change; queue saturation; rapid destroy/recreate; surface loss between validation/draw/commit; thread/allocator failure and dispatcher crash. Each observation separately records event admission, guest result, effect acknowledgement, logical commit and uncertain external effects.
