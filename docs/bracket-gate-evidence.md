# Bracket depth gate evidence

2026-10-24. Local diagnostics only, not accepted self hosting.

First-pass source, frozen plan and passive vector fixtures were drafted before running the batch. First consolidated run had **24 mismatches out of 420**, all later-balanced malformed prefixes erroneously becoming accepted due to a non-sticky error accumulator. Repaired the error state in one batch and reran **420 of 420 passing** cases. Covers 12 frozen cases, 400 seeded randomized cases, 6 depth tests, and 2 full-length stress cases.

Actual diagnostic command (outside repository evaluator): `python /tmp/verify-bracket-slice.py` (diagnostic harness outside repository, not a COCK executable module). For direct fixture executions, `/usr/local/bin/cock-bf-diagnostic COCK/src/bracket_depth_gate.bf` receives binary stdin from a separate byte router or caller.

The input is `[one count byte][that many normalized BF source bytes][A5]`; only bracket depth and guard are checked. Source count maximum 255 for this specific diagnostic format. It does not validate source symbols, annotations, independently authenticated stream closure, exact original offsets, or compiler behavior.

Source SHA256: `8b57f6ae831185b41f5e2705a2e8396071b37a77a7f5a698d4873ad5151a9456`.
