# BF authored compiler request framing evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Date: 2026-10-24. Scope: diagnostic component only. Android work remains deferred.

## Implemented

`tests/compiler_request_framer.bf` is an authored 99-command Brainfuck program. It converts a known-complete, independently admitted compiler command stream into literal one-byte source chunk records for the existing `src/bf_in_bf_six_cell.bf` loader, then relays admitted application input. Unlike the prior Python fixture assembler it does not store or specialize either compiler: the caller passes the exact executable compiler command stream as data. It handles source lengths greater than 255 via repeated records; each one-byte chunk has 1 byte of prefix overhead. The `!` separator is **diagnostic only**, not BFIO/BHIO or a new source instruction.

## Consolidated successful checks

- **13/13** exact-byte request-framing fixtures passed, covering both real compiler command streams, empty source, brackets, and byte lengths 1, 255, 256, 515 and 1,024. Every expected output byte was independently composed as inert fixture data and checked against the real BF executor output.
- **6/6** existing native byte artifacts matched exactly after passing BF framer output to the unchanged COCK six-cell interpreter with the original or compact real BF compiler as guest. Source-dependent output sizes: 264, 272, 280, 140, 144 and 148 bytes.
- **24/24** BF source modules passed strict comment/command-line and bracket audit. This includes the new driver. There are no foreign-language source files in this added slice.
- **4/4** *separate* tiny guest examples passed when the independently attributed Daniel B Cristofani reference BF interpreter executed a second copy of its own source. Exact programs and outer command counts appear in the JSON report. **These self-copy results do not satisfy the COCK-owned self-host requirement and do not run the full mini compiler.**

## Failure observations that remain open

- Missing `!`: raw EOF zero is interpreted as another input source byte, leading to repeated provisional data and an outer diagnostic fuel stop. There is no safe rejection.
- Embedded application NUL: the relay stops early and ignores trailing bytes. The Stage A arithmetic app source does not contain NUL, but arbitrary binary data is unsupported in this input mode.
- Invalid compiler byte `x`: the framer transmits it unchanged because it has no source-grammar preflight. The independent source gate must reject before invoking the framer.
- Host process/pipe closure and true source lengths remain independent and **unimplemented** as an integrated adapter. This driver is **not an input authority**.
- The upstream six-cell interpreter still has unhandled runtime tape violations, no native fuel and no validated host-status boundary. The framer cannot remedy these.

## Ownership and acceptance boundaries

The actual request transformation algorithm is BF-authored. In this run, an outside-repository Python diagnostic coordinator invoked the root BF executor for the driver and then for the six-cell interpreter, compared outputs and wrote inert fixtures/evidence. No Python/C test, source generator, shell launcher or other foreign executable source was added inside the COCK repository. The evaluator was locally built outside the repository and is not an independently certified bootstrap. Therefore this remains a diagnostic BF-authored component rather than a complete self-hosted production build.

The original and compact mini compilers, six-cell interpreter and all six previously frozen native candidates remain byte-identical. `COCK -> same COCK -> real mini compiler` nested self-interpretation is still **NOT VERIFIED**. No Android ELF/APK or device evidence was generated.

See `compiler-request-framer-evidence.json` for command counts, hashes, byte lengths, diagnostic exits and independent reference observations.
