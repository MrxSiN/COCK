# Observed Stage A component diagnostic evidence

**Evidence classification: OUTSIDE REPOSITORY DIAGNOSTIC ONLY.** The basic BF evaluator for these tests was an ephemeral Python diagnostic outside the checked-in source tree, not a preinstalled, externally supplied, independently certified BF executor. It cannot establish the specification's accepted root bootstrap, self-hosting or production build chain. No non-BF executable source is included in this package.

## Passed component checks

The consolidated local diagnostic batch validated every authored `.bf` file's Part 1 comment/code line grammar and bracket pairing. It ran `src/mini_compiler.bf` with normalized command streams from the three example files and `+.` and `-.`, compared exact native bytes against independently specified arithmetic instruction sequences, and compared guest bytes against **both** the initial arithmetic BF interpreter and the separate BF oracle. Additional mixed, wrap and double-minus tests passed. No Android application was executed.

Recorded command-count and hash observations are in `docs/evidence.json`. The diagnostic outer-instruction counts refer only to the particular external diagnostic evaluator and are **not** CPU performance or an accepted full host bootstrap measurement.

An independent external assembler check executed:

```text
printf '.text\n.globl cock_verification_only\ncock_verification_only:\n mov w0, #0\n add w0, w0, #1\n sub w0, w0, #1\n ubfm w0, w0, #0, #7\n ret\n' | clang --target=aarch64-linux-android35 -c -x assembler -o /tmp/cock_aarch64_verify.o -
readelf -h /tmp/cock_aarch64_verify.o
readelf -x .text /tmp/cock_aarch64_verify.o
```

`readelf` reported an `ELF64`, `REL` (object), `AArch64` file, with `.text` bytes `00008052 00040011 00040051 001c0053 c0035fd6`, confirming the independently assembled instruction encodings. This verification object is **not** a COCK-produced ELF, was not placed in the COCK repository and was not used to manufacture the candidate raw code output.

The three `.aarch64.raw` files in `artifacts/` are **unpublished diagnostic candidates**, raw BF-emitted native instructions only. Their exact SHA-256 identifiers and byte counts are in `docs/evidence.json`. The source-dependent compiled output consists of a one-word initialization, one arithmetic plus masking pair per source arithmetic instruction, and a return word.

## Failed mandatory checks and blockers

Negative tests confirmed the current mini compiler **does not reject** `+x.`, an embedded NUL with a suffix, unmatched brackets or a missing final output command. These cases yielded code rather than a preflight failure. They are explicitly recorded as **MAJOR blockers**. Therefore this compiler is unsafe as a standalone unrestricted frontend and is only a partial component behind a *not-yet-implemented* BF-authored source-validation and exact-input-closure boundary.

`src/bf_in_bf.bf` cannot execute the mini compiler as guest and cannot execute its own interpreter source. Mandatory **BF in BF interpreter running compiler, bounded inner interpretation, exact source preflight, signed debug APK, emulator installation/launch, native lifecycle and logging** remain `NOT IMPLEMENTED / NOT RUN`. No accepted Stage A compiler, Android app or optimization result exists.
