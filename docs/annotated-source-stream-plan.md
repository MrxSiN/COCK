# Annotated source streaming preflight slice

Status at inventory freeze: first draft, NOT TESTED. This slice does not change a published COCK protocol.

## Inventory

- `src/annotated_source_stream_gate.bf` — strict annotated source line grammar and checked bracket depth, all executable behavior in BF.
- `fixtures/annotated-source-stream-vectors.json` — inert fixture data and initial byte examples.
- `docs/annotated-source-stream-evidence.md` and `.json` — populated only after the consolidated diagnostic batch.
- `README.md`, `docs/status.md` — update after tests and evidence.

## Input and budgets

The development-only input transport is `u8 count | count literal source bytes | A5` repeated zero or more times, then `00 A5` as terminator. Count is bounded **per record**, not across the full source. The 255-level bracket-depth limit is an acknowledged implementation-specific resource bound. The source is not an unbounded tape and this input protocol is not BFIO or BHIO. Independent host byte-count, no-extra-bytes closure and process-success evidence are still required. No deployment or compilation may be authorized by the Boolean output alone.

## Source admissions and acceptance

Admit code lines containing only original eight BF glyphs and spaces or tabs; comment lines starting at first nonblank `#`, with remaining bytes in printable ASCII range and no BF glyph; blank lines, LF and CRLF. Reject illegal NUL, BOM, Unicode, stray CR, malformed comments, inline hash, negative/unbalanced brackets, and record truncation/guard corruption. The result is `01` for pass or `00` for rejection.

Known limitations: no original source offset diagnostics; no normalized code-output channel; 255-level nesting implementation bound; no independent physical closure; no operator authority to gate the next compiler within one BF-owned process. Consequently this is a component preflight, **not** complete normative Part 2.5/2.7 source preflight or a successful Stage A acceptance.

Tests after drafting: known line cases, split CRLF, 256 raw-byte fixtures, repeatable random records, bracket depth 255/256, guard and EOF truncation, current repository implementation modules, previous normalized gate regression, and equality of previously frozen emitted native byte candidates when the existing separate raw compiler is invoked diagnostically. External diagnostic programs are not checked into the repository.
