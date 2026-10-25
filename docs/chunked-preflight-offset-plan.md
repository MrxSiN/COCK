# Stage A chunked preflight offset slice

## Frozen scope and inventory

- `src/chunked_preflight_offsets.bf`: one Brainfuck source scanner for normalized command bytes, chunked inputs, lexical and bracket errors, and command offsets.
- `fixtures/chunked_preflight_offsets/`: inert exact-byte input and expected-output fixtures plus JSON catalog.
- `docs/chunked-preflight-offset-evidence.md` and JSON: execution results, negative findings, verified source identity and remaining limitations.
- Existing six raw AArch64 candidate artifacts and original compiler/interpreter sources remain immutable.

## Interface

Input is zero or more records consisting of one nonzero byte count followed by exactly that many normalized BF source bytes. A zero count terminates the records, followed by mandatory byte A5. Output is exactly three bytes: status and little-endian 16-bit command offset. Status 00 success, 01 first invalid command byte, 02 earliest unmatched opening bracket, 03 first unmatched closing bracket, 0A bounded counter or nesting overflow, 0B invalid or absent terminal guard. The offset is FFFF for success, overflow, or guard failure. Guard precedence comes first; overflow precedes source and bracket statuses; otherwise lexical errors precede bracket matching and unmatched close precedes unmatched open.

The component accepts up to 65535 commands and at most 255 nested brackets under a component-specific diagnostic budget; neither is a universal application limit. It never publishes guest source or guest output. The accepted input is an already normalized command stream, NOT annotated raw BF. Original annotated-source byte offsets and independent physical host closure are outside scope. Host-reported read/exit/stream closure remains independently mandatory. A trailing byte following the guard is an intentionally unsupported physical-closure case.

## Acceptance vectors frozen before first implementation draft

Empty stream; each of eight commands; illegal ASCII X; embedded NUL; invalid suffix after output-capable prefix; two invalid bytes with first-offset precedence; unmatched opening; unmatched closing; nested and sequential legal loops; lexical error plus unmatched bracket; cross-chunk bracket pairing; malformed/absent guard; complete original and compact compiler command streams; 255/256 depth; 255/256 and 65535/65536 command length boundaries; randomized legal and random-byte streams; an appended trailing byte deliberately not detected by the BF source; existing six compiler outputs unchanged. Each fixture requires the expected exact three bytes and a successful diagnostic host exit, not only an apparent status byte.

## Scope and evidence limits

This slice does not replace the general-loop interpreter, does not emit a normalized-source handoff payload, and cannot attest host stream closure through the BF EOF-zero rule. Local Python or C diagnostic tools are external to the repository and are not compliant BF-authored development tooling; strict BF-only development-process provenance cannot be certified from their use. Android tests remain deferred.
