# Same-kernel compiler execution slice

2026-10-26. This is a bounded Stage A repair slice, not whole-stage acceptance.

The existing dynamic-PC kernel has repeatedly timed out under nesting. The separately attributed, unchanged `src/bf_in_bf_reference.bf` is a second available BF implementation. Its 423-command stream can interpret itself; select it for a separately identified trusted-tool execution experiment. Do not relabel the dynamic-PC kernel's failed tests or claim the reference implements its counted/fuel/status profile.

Before drafting, the complete inventory is:

| File | Responsibility |
| --- | --- |
| `tests/same_kernel_request.bf` | Copy three counted chunk streams, inserting the two reference-interpreter separators; no compilation or source filtering |
| `fixtures/same_kernel/vectors.json` | Literal request and expected-output requirements |
| `docs/same-kernel-plan.md` | Scope, input authority, ownership and pretest gate |
| `docs/same-kernel-evidence.json` and `.md` | Actual batch results, identities, timing and limitations, written after execution |

Reuse the unchanged reference, normalizer, source-record serializer, annotated source gate, binary comparator, arithmetic oracle, original/compact compilers and Android guest/callback/ELF producers. There is no new interpreter or native algorithm in this slice. Every new executable is annotated BF. The request driver is transport infrastructure, not the missing Stage A build planner.

## Execution boundary

The root is the already-installed upstream Tritium Android evaluator. Its outside-checkout C output for the unchanged reference may be compiled with installed NDK Clang as an accelerated standards-only root. That generated C and its binary stay outside the checkout. It is not a handwritten compiler, interpreter replacement, Android application helper or COCK native-host backend. Record the exact reference identity and independently check direct seed versus accelerated-root controls.

The reference input is `program!input`; it has no COCK fuel, status or input-closure envelope. Both interpreter levels use the exact same 423 commands and byte semantics. Only independently admitted trusted BF tool sources enter this experiment. The mechanical host records exact closed file counts and process exits, supplies immutable literal fixture bytes, and independently vetoes incomplete output. Its assembly of counted fixture records is physical transport. The new BF driver, not the host, constructs the interpreter separators. A timed-out or failed producer never passes, even with a correct prefix.

The initial diagnostic completed before this draft used an existing file, with `reference!compact-compiler!+.` as inert test data. It produced 16 bytes and exit zero. This is a diagnostic lead; the new slice's tests start only after all first-pass source/fixtures are drafted and a restorable snapshot is saved.

## Acceptance batch

1. Static annotation/bracket audit and BF gate checks for every source used.
2. Driver literal cases including empty streams, byte `00`, `21`, `ff`, and multi-chunk source.
3. Root binary/EOF and reference control cases; accelerated-root outputs must match.
4. Direct, one-level and identical-reference nested original/compact compiler outputs for the existing apps and a fresh post-draft held-out source. Compare complete bytes with frozen raw artifacts and the independent BF comparator. Raw compiler fixtures are not Android applications.
5. Direct, one-level and nested Android guest/callback/ELF component outputs where the declared watchdog permits. Preserve all timeouts as failures. Native output must match existing independently inspected BF artifacts; no host-created native instructions.
6. Repackage and launch exact self-hosted BF native output with disclosed external debug-only SDK tools where the complete producer result exists; independently compare prepackage, extracted and installed native identities, executable inventory and correlated device logs.

Use an explicit 600-second process watchdog and record individual elapsed times. This is an outer resource control, not deterministic guest fuel. Stream lengths, source identities, source admission, process exit and physical read/write closure remain independent facts. A matching raw output does not retroactively certify COCK framed status, dynamic tape traps, a complete source frontend, a whole-build CLI or production signing.

No optional optimization or Stage B promotion is part of this repair. Preserve all prior sources and native artifacts. Whole-stage source/error/session/build-entry gates remain open unless actually implemented and tested in a later bounded slice.
