# Stage A repeated sixteen bit instruction fetch evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Outcome:** LOCAL DIAGNOSTIC PASS for indexed source-command retrieval. **Not an accepted general-loop COCK interpreter or Android build.**

## Implemented component

`src/source_pc_16bit_fetch_many.bf` is a 700-command annotated original Brainfuck program. It buffers an already normalized source stream in a four-cell-per-command outer tape record and serves several non-monotonic sixteen-bit command-offset lookups within a single invocation. A separate navigation marker is propagated to return to the first source record after each query. The original source opcode cells are preserved while lookup scratch is reused. A missing indexed instruction is reported by output bytes `00 0D`; a present instruction is returned as `opcode 00`.

Inputs are *development-only*: `source command bytes | 00 | u8 query_count | query_count × u16_le position`. This format is **not** the trusted `COCK-FRAME-v1`, `COCK-BUILD-INPUT-v1` or `COCK-HOST-IO-v1` contract. Every command byte and byte-count boundary must still pass independently checked source preflight and source/host closure before production use.

## Consolidated local acceptance batch

| Test class | Observed |
| --- | --- |
| Frozen exact-byte binary fixtures | 6 / 6 |
| Whole original and compact mini compiler source lookup | 2 / 2 (515 and 452 commands) |
| Seeded randomized instruction-position requests | 320 / 320, seed 20261025 |
| Long program position stress | 3 / 3 (4096, 65535, 65536 bytes) |
| Per-invocation query-count limit | 1 / 1 (255 nonmonotonic queries) |
| Previously frozen AArch64 compiler outputs, independently re-executed under unchanged six-cell kernel | 6 / 6 exact byte matches |
| Repository annotated Brainfuck source audit | 44 / 44 |

The tests used an outside-repository compiled diagnostic Brainfuck evaluator; an independent outside-repository model generated test *expectations* only. The six AArch64 cases ran against the previous compiler-capable `bf_in_bf_six_cell_preflight.bf`, not this new fetch component. This is preservation of the baseline, not an assertion the new component compiles native code.

The first full stress fixture initially stopped at the configured **one-billion outer evaluator command** limit. Without changing the Brainfuck source or expected bytes, a rerun under a five-billion outer-command budget passed. This is host resource accounting, *not* guest instruction fuel.

## Important observed failures of authority

Three additional intentionally negative cases exposed continuing contract gaps:

1. A valid request with unread appended bytes succeeds and ignores the suffix. Independent host exact read count and closure are mandatory.
2. Source containing a noncommand nonzero `X` returns that byte with a nominal local lookup success. This program assumes complete BF-authored lexical and bracket preflight has already occurred.
3. Absent source terminator can be confused with EOF-zero. The diagnostic sentinel cannot authorize input completion.

Consequently **neither source-validation authority nor execution safety can be claimed from this primitive**. The source's 16-bit query index and one-byte per-invocation query count are local representation limits, not global COCK source, feature, APK or module limits. Long-term host/guest memory separation, 16-bit PC updates, original-command fuel, dynamic guest tape, trusted source offset semantics and same-interpreter nested real compiler execution remain incomplete. Android packaging and testing remain deferred.

The external Python source-layout aid was kept outside the repository. While checked-in executable source is only eight-command annotated BF, the stricter BF-only development-process provenance claim remains **NOT CERTIFIED**.

The machine-readable companion JSON includes input and output hashes, full test breakdown, hashes of the frozen six artifacts and local execution observations.
