# Normalized source admission and bracket slice

First pass scope and complete file inventory before implementation testing.

Source file: `src/normalized_source_stream_gate.bf`. It extends the existing chunked bracket-depth gate with an independently BF-authored exact eight-command alphabet admission step. It preserves the separate original bracket gate unchanged.

Inert fixture specification: `fixtures/normalized-source-stream-vectors.json`. Results: `docs/normalized-source-stream-evidence.md` and a passive JSON report, created after the draft and consolidated test batch. Update README and overall status only once the verification results exist.

Provisional diagnostic input: any number of `u8 nonzero_count | count literal BF command bytes | A5`, followed by a mandatory terminal `00 A5` record. A single output byte `01` means complete *provisional* normalized-command plus bracket validation, `00` means rejection. Each record has at most 255 bytes; total source can span multiple records. Depth currently has a 255 nesting bound; depth overflow rejects. This is neither COCK-FRAME-v1 nor COCK-BUILD-INPUT-v1.

Acceptance vectors: all eight command glyphs; empty stream; `[]`; `+[-]`; zero-depth premature close; unmatched open; 255-depth boundary; 256-depth overflow; all 256 byte values in payload (admit only original eight ASCII command bytes); malformed/truncated A5 guard; truncated data; missing terminator; junk after the terminator (host side closure only); all normalized instructions extracted independently from original and compact mini compilers; random matched and malformed multi-record streams, including splits across brackets. Check exact output and process result. Original bracket-stream behavior must remain unchanged. Audit source annotations and balance before the batch. No Android work.

Guarantee: the checker may veto a normalized stream, but does **not** lex annotated source, establish exact trusted host closure, expose original source offsets, provide unrestricted depth, or authorize execution of application guest code. An independent success/closure result is mandatory before any downstream compiler may use the output; this is a component diagnostic only.
