# General forward bracket probe evidence

**Status: LOCAL DIAGNOSTIC PASSED; NOT FULL STAGE A ACCEPTANCE.**

The BF-authored source `src/general_forward_bracket_probe.bf` locates the matching closing bracket for the **first opening bracket** in a prevalidated normalized BF command suffix. Its data output is a two-byte little-endian relative command offset followed by a one-byte diagnostic status. On any failure the returned offset is zero. This private diagnostic format is not a new wire protocol or ABI.

## Reproducible observed results

- Full diagnostic suite: **572/572** exact-byte checks.
- All opening brackets in both unchanged compilers: **57/57** forward targets checked.
- Unmodified six-cell compiler through the original and compact variants: **6/6** frozen AArch64 binary comparisons.
- Repository BF lexical/annotation/bracket audits: **30/30**.
- BF executable commands in the new component: **863**.
- SHA-256 of the new BF source: `0562931cc5e0a815d51125f2c0f7e0a26ad63fa70a554a5748ef76cbafb48508`.
- A single suite run: **16.363 seconds** in the local container. Timing is diagnostic, not a validated performance claim.

| Compiler source | Opening brackets | Matched targets |
| --- | ---: | ---: |
| `mini_compiler.bf` | 30 | 30 |
| `mini_compiler_compact.bf` | 27 | 27 |

A deterministic external diagnostic model supplies relative jump expectations; the interpreter is run by an external, locally built diagnostic evaluator. No outside source is checked into the repository. This is **not** the independently certified standard Brainfuck bootstrap or a BF-only acceptance oracle. Raw per-case results, original source byte offsets and source hashes are stored in `docs/general-forward-bracket-evidence.json`; immutable fixed vectors are in `fixtures/general_forward_bracket_probe/vectors.json`.

## Representative exact outputs

- Input `[]` plus diagnostic byte terminator: `01 00 00`.
- Input `[+]` plus diagnostic byte terminator: `02 00 00`.
- Input `[` plus terminator: `00 00 02`, missing closing bracket.
- Input whose first byte is `]`: `00 00 0D`, unsupported starting command.
- Offset exceeding unsigned 16-bit representation or nesting exceeding 255: `00 00 0A`.
- Crossing the 255/256 offset boundary produces `FF 00 00` then `00 01 00` for valid matching locations.

## Known limitations and follow-on work

1. Only the **forward** target for a starting opening bracket is computed. Matching a nonzero closing bracket requires reverse lookup or an independently proven jump table. The component is not a BF interpreter and has no guest state, tape, input, fuel or runtime trap semantics.
2. The diagnostic input is a normalized command suffix, not a complete-source validation interface. It is not safe on arbitrary annotated or binary source, and it does not protect against illegal suffix bytes without the separately tested whole-source preflight.
3. Its byte-zero terminator is provisional. The outside host must establish exact source length, stream closure, read and write success; any content following a matched closing bracket is outside this scanner's query and is not validated by it.
4. The 16-bit target distance and 8-bit nesting depth are **current bounded-component representation limits**, not limits imposed on COCK applications or future compiler source.
5. The original and compact compiler artifacts remain unchanged. No general dynamic-tape loop dispatch, full same-interpreter nested compiler proof, Android ELF/APK or device execution was performed in this slice.
6. Independent source authorship and bootstrap-conformance evidence remains pending. This development batch used outside-repository tooling for test coordination and drafting assistance. The repository's executable source remains annotated BF only.

**Stage A status: NOT ACCEPTED. Android: DEFERRED.**
