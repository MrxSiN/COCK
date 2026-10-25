# Dynamic guest tape bidirectional clear loop slice

Status before implementation batch: PLANNED AND NOT TESTED.

## Scope

Extend the existing twelve outer cell per guest record interpreter to recognize either three command loop `[-]` or `[+]`. Both are semantically clearing loops in wrapping unsigned eight bit BF when guest fuel is not active. They must work at every reachable rightward guest cell including addresses beyond six and 255. Preserve diagnostic status byte on success zero, on left origin trap four, and unsupported guest opcode thirteen. This provisional diagnostic input protocol is raw guest instruction bytes followed by zero, supplied under independently known physical length and closure. It is not COCK framing.

## Frozen slice inventory

- `src/bf_in_bf_dynamic_bidirectional_clear.bf`: sole new BF executable module.
- `docs/dynamic-bidirectional-clear-plan.md`: inventory and acceptance plan.
- `fixtures/dynamic_bidirectional_clear/vectors.json`: fixed exact byte cases and negative inputs.
- `docs/dynamic-bidirectional-clear-evidence.md` and `.json`: post batch evidence.
- Frozen previous interpreter and both compilers remain unmodified.

## First consolidated acceptance batch

- Exact `[-]` and `[+]` source handling including zero cell, modulo wrapping at 255, repeated clearing, neighbor preservation, cells beyond 255, and guest output 00 and FF.
- Malformed open bracket suffix, wrong clear instruction, stray close, plus/minus loops with extra interior operations, and left trap.
- Deterministic 300 bounded seeded randomized programs formed from the five linear guest commands and either permitted clear loop, compared byte for byte against an independent nonproduction guest reference evaluator.
- Legacy dynamic clear loop diagnostic regression, 6 frozen AArch64 output checks using the unchanged six cell compiler interpreter, whole repository annotation audit and ZIP checksum validation.
- Explicit unsupported negative results for source NUL, late malformed source and trailing bytes after source delimiter; these are acceptance blockers for arbitrary untrusted source.

## Exclusions and evidence limits

This component is neither arbitrary loop execution nor accurate source preflight. It does not support guest comma input, fuel, source offsets, configured tape budgets, independent host closure, real BFIO result frames, nested self compiler interpretation, or Android execution. Clearing `[+]` in one host loop is semantically correct only for unbounded guest execution without exact guest instruction fuel. The independent outside repository diagnostic executor and test oracle are not the repository build implementation. No acceptance of full Stage A or production artifact publication follows.
