# Stage A next bounded slice — printable guest admission

Status: frozen design and diagnostic plan before drafting and testing.

## Scope and file inventory

- `src/printable_subset_gate.bf` — BF-authored extension of the previously diagnostic raw subset gate. It admits only raw `+` and `-` arithmetic followed by one terminal `.`, additionally requiring the computed modulo-256 guest output to be within inclusive `0x20..0x7e`. Input is `u8 byte count | exact source bytes | A5` and output is one provisional decision byte (`01` or `00`). The external host must independently verify exact byte counts and successful closure.
- `fixtures/printable-subset-vectors.json` — inert byte-accurate positive/negative fixtures for boundary and malformed cases.
- `docs/printable-gate-evidence.md` — actual post-draft diagnostics, code identity and limitations; never prefill passing results.
- `README.md` and `docs/status.md` — update statuses after consolidated diagnostic batch.
- `COCK_Stage_A_Engineering_Workspace.zip` — regenerated after diagnostics.

## Required exact vectors

A period-only source must reject (value zero); 31 additions plus output rejects (`0x1f`); 32 additions plus output accepts (`0x20`); 126 additions plus output accepts (`0x7e`); 127 additions plus output rejects (`0x7f`); 255 additions plus output rejects (`0xff`); 256 arithmetic commands plus output exceed this gate's declared one-byte *per-invocation* input budget, not a universal project size ceiling. Subtraction from zero wraps and rejects if non-printable, but 224 subtractions emit 32 and accept. Also reject missing/double final output, invalid ASCII commands, embedded `0x00`, absent or corrupted trailer, and commands after output. Mixed `+-` arithmetic is accepted or rejected according to *computed* byte, never by program filename.

All BF source must satisfy strict Part 1 annotated comments. The new BF source may call no code outside the standard eight commands. Distinguish the preflight decision from proof of host stream completion, genuine Android output or compiler self-hosting.

## Deferred, explicitly unsupported

The one-byte frame is a bounded raw-source diagnostic interface, not `COCK-FRAME-v1`, not complete annotated source syntax, not BFIO authority, not a general source-length cap, and not a build status. The true Stage A compiler must still perform full trusted source preflight and execute through a BF-in-BF that runs the actual compiler and itself once; the current BF-in-BF does neither. Android SDK, emulator and on-device tests are skipped at user request; no APK proof is implied.

## Consolidated diagnostic batch

After the full planned inventory is drafted, inspect `.bf` comments and brackets, run the fixed vectors, then run one deterministic differential batch comparing the provisional Boolean result with an independent arithmetic predicate and the existing BF arithmetic oracle. Every source-derived test input is outside the repository as ephemeral independent diagnostic transport; no foreign-language executable source is added to COCK. A trailing byte after `A5` is a **host-closure negative**, not a claim that raw eight-command BF can sense the missing physical stream boundary.
