# Stage A retained source arithmetic execution evidence

**Outcome: 966 of 966 local diagnostic execution cases passed, including two additional long source cases. This is not Stage A acceptance.** Android remains deferred.

## BF authored implementation

`src/source_pc_16bit_arithmetic_exec.bf` is an annotated Brainfuck executable of 2,019 original BF commands. It combines source loading into persistent mobile records, complete normalized-source lexical preflight, actual sequential guest execution and original-command 16-bit fuel accounting **in a single BF program**. This addresses an integration gap left by the separately tested PC lookup and instruction-step components, but only for the single-cell `+`, `-`, `.` guest subset.

The temporary development request is `u16le source_length | u16le guest_fuel | source bytes`, with no source cap beyond the 16-bit representation and actual configured host resource capacity. The output is zero or more literal guest `.` bytes followed by a one-byte *diagnostic* `00` success, `06` fuel violation or `0D` invalid/unsupported source. On an invalid source the program emits **no guest bytes**, including when an invalid suffix follows a valid output-producing prefix. On a fuel violation, earlier guest output may be present, but the terminal diagnostic is not a production status authority. An empty source with zero fuel returns diagnostic success. The guest tape is a single accumulator cell and arithmetic wraps modulo 256. Nothing here implements guest pointer travel, loops, guest comma, BFIO or Android ABI.

## Executed consolidated tests

| Scope | Actual checked result |
| --- | ---: |
| Fixed and boundary, alphabet exhaustive and seeded randomized cases | 964 of 964 passed |
| Large retained source at 32,768 commands and equal guest fuel | Exact `FF 00` output |
| Largest 16-bit source representation at 65,535 commands and equal fuel | Exact `FE 00` output |
| Saved exact binary input/output fixture pairs | 40 created, all 40 rerun successfully in a separate exact byte batch |
| Original and compact mini compiler regression on three unchanged applications | Six of six exact matches through the **older compiler-capable BF-in-BF interpreter** |
| Repo BF source grammar and matched bracket audit | 48 of 48 passed |

The 964-case main suite includes 256 exhaustive single-byte source values, 450 randomized valid sources, 200 randomized arbitrary-byte sources, 35 randomized wide-source cases and 23 fixed cases. Deterministic seed: `20261025`. The independently computed expected bytes were produced outside the repository, for diagnostic verification only. The actual runnable code under test was exclusively `.bf`.

The two additional 32,768 and 65,535 command cases ran on outside-repository BF diagnostic executors with adequate tape capacity; the maximum-length case required expanding that evaluator's physical tape configuration to two million cells. This changed only diagnostic memory provision, not the BF algorithm. The recorded maximum-length run consumed 65,539 input bytes, completed after approximately 1.27 billion *outer evaluator grouped operations*, and produced exactly two expected bytes. These operation counts are **not** native runtime or guest-fuel throughput measurements.

The six preserved AArch64 regressions used the **unaltered** `src/bf_in_bf_six_cell_preflight.bf` executing the unaltered original or compact BF mini compiler. Their output sizes are 264, 272, 280, 140, 144 and 148 raw machine-code bytes; they are **not produced by this new arithmetic interpreter**, and remain neither ELF shared libraries nor installable APKs. Compiler replay outcomes and SHA-256 values appear in the machine-readable JSON.

## Explicit failed trust-boundary probes

- A declared two-byte `+.` program followed by an unexpected `X` returned `01 00` and the host reported only six of seven input bytes consumed. Extra input was not detected internally.
- A declared empty program with extra `+.` input returned `00` with only four of six input bytes consumed.
- A declared two-byte source containing only a physically available single `+` returned invalid-source `0D` because EOF supplied the missing NUL byte; it could not independently report a physical incomplete-read status.
- A physically truncated fuel header also produced an invalid-source diagnostic, not a trustworthy host-read-failure status.

**Therefore the BF program does not itself establish the exact closed input boundary.** A trusted external physical byte-count/stream/process-completion fact is mandatory, together with a BF-authored production router. The one-byte appended status is unframed and can collide with normal output; no claimed result should be treated as `COCK-FRAME-v1` authoritative. The finite 16-bit source field remains a provisional development format limit, not a COCK-wide size policy.

## Reproducibility and process qualification

The archive includes 40 paired literal `.input.bin` and `.expected.bin` fixtures and the JSON data for all main randomized tests. Example local diagnostic invocation with an outside-repository evaluator:

`diag src/source_pc_16bit_arithmetic_exec.bf fixtures/source_pc_16bit_arithmetic_exec/one_output.input.bin actual.bin 250000000`

Compare `actual.bin` to `one_output.expected.bin` byte for byte, and independently check the diagnostic evaluator exit/actual input-consumption facts. The maximum length fixture requires an evaluator with at least 786,500 physically addressable outer cells and an execution budget above the actual observation; do not infer unlimited host memory from this result.

A temporary outside-repository source-layout aid was used for authoring this `.bf` file, and conventional source/fixture test coordination was also outside the repository. The repository contains no foreign-language executable source, but the master document's stronger **BF-only development-process provenance is NOT CERTIFIED**. Likewise, source admission for annotated files, source-byte offsets, general BF guest semantics, validated physical stream closure, full same-implementation nested mini compiler, qualified bootstrap and Android device proof remain **NOT IMPLEMENTED / NOT VERIFIED**.

**Next engineering target:** merge this 16-bit retained-program execution design into the general-loop/dynamic-tape BF interpreter, after separately proving stable 16-bit PC, matching-bracket lookup and actual guest tape state. Preserve the existing six-cell compiler-capable checkpoint throughout.
