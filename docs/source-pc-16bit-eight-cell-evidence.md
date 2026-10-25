# Stage A retained source sixteen bit eight cell execution evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Outcome:** 1,045 of 1,045 local differential diagnostic cases passed. This is **not Stage A acceptance**, Android remains deferred, and the new candidate cannot execute the actual compiler because it does not support general Brainfuck loops.

## New integrated Brainfuck executable

`src/source_pc_16bit_eight_cell_exec.bf` contains 12,796 actual eight-command Brainfuck operations with strictly nonexecuting annotations. It retains a length-prefixed source in tape records and validates its entire command alphabet before executing a guest instruction. It uses 32 outer cells per mobile source record and carries an eight-cell guest tape, a bounded guest pointer, 16-bit fuel and guest execution state along the already-loaded records.

The diagnostic input contract is **u16le source byte count | u16le guest instruction fuel | exactly that many normalized source bytes | remaining guest input bytes**. It supports `+ - < > . ,` with 8-bit guest cell wrapping, binary output, binary guest input and EOF-to-zero under the diagnostic evaluator. Guest `[` and `]` are **not supported** and are rejected during preflight, before any guest effect. This restriction includes otherwise valid full mini compiler sources. The source length and fuel fields have an implementation limit of 65,535; the **largest actually tested source here was 1,024 commands**, not 65,535.

The output is guest bytes followed by an unframed single-byte **diagnostic** status: `00` success, `04` left guest-tape violation, `05` right guest-tape violation, `06` original guest-command fuel exhaustion, `0D` invalid or unsupported source. Checked tape indices are 0 through 7 inclusive. A boundary-trapping instruction consumes guest fuel; earlier guest output can precede a pointer/fuel error. An invalid source emits **no guest output**. The trailing diagnostic is not an authoritative production BFIO frame and can collide with guest data.

## Measured diagnostic verification

| Check | Observed result |
| --- | ---: |
| Independent-model differential cases | 1,045 / 1,045 passed |
| Exhaustive single-byte source values in this suite | 256 / 256 passed |
| Seeded additional valid programs | 520 / 520 passed |
| Seeded arbitrary-byte source programs | 220 / 220 passed |
| Additional wide-source bounded programs | 20 / 20 passed |
| Named edge cases, including length 515 and 1,024 | 29 / 29 passed |
| New binary fixture pairs rerun separately | 53 / 53 passed |
| Compatible preserved arithmetic fixture pairs | 25 / 25 exact matches |
| Frozen AArch64 compiler-output comparisons through preserved full-loop interpreter | 6 / 6 exact matches |
| Source-format and bracket-balance audits across all repository BF files | 49 / 49 passed |

The differential total is 29 fixed + 256 exhaustive + 520 valid random + 220 arbitrary + 20 wide. Test seed `20261025`. The outside-repository reference model independently computes guest pointer, cell, input, fuel, preflight and status semantics. The temporary outside-repository C interpreter executes the actual `.bf` file, not a conventional-language replacement of the BF guest executor. Each saved fixture is literal nonexecutable binary input and expected output.

The prior arithmetic interpreter has a smaller guest-command alphabet. Of 40 saved old fixtures, **25** have compatible semantics and passed byte-for-byte against the new interpreter. **13** exercise commands newly admitted in this candidate, so their previous expected rejection bytes must not be used as regression expectations. The two other historical source-length stress fixtures (32,768 and 65,535 commands) were **not rerun** here because they exceed the configured diagnostic outer execution budget; their earlier reported results belong to the older arithmetic interpreter only.

The six frozen raw AArch64 machine-code files were independently rerun with the **unchanged** `src/bf_in_bf_six_cell_preflight.bf` and the same six archived binary inputs. Original artifact sizes: 264, 272, 280 bytes; compact artifact sizes: 140, 144, 148 bytes. No new compiler output was produced by the eight-cell interpreter. Frozen raw output is neither ELF nor APK.

## Remaining negative probes and acceptance blockers

- A declared `+.` source followed by an unexpected trailing `X` returned `01 00`; the BF guest interpreter **did not detect the extra physical byte**.
- A declared two-byte source with only one physically present `+` returned invalid-source `0D`, but EOF-zero cannot distinguish missing transport bytes from literal invalid NUL.
- An empty source with extra trailing bytes returned `00`; therefore exact physical source/guest-input closure is still dependent on a trusted host.
- Both 515-command original and 452-command compact **real compiler sources** are rejected with `0D`, because they contain unsupported brackets.
- The outer evaluator is a temporary C diagnostic program and is **not** the independently qualified standards-only root required by Stage A. A temporary Python BF layout helper and Python verification coordinator were also used outside the repository. Though the executable committed here is BF, the specification's stricter BF-only *development-process provenance* is **not certified**.
- Annotated-source original-byte offsets and validated trusted host closure, general nonzero-loop dispatch, larger checked or dynamic guest tape, same-interpreter nested self-execution, full compiler output through this new kernel, production BFIO framing, and Android loader/device proof remain open.

**Next integration task:** connect this tested eight-cell checked guest-state execution to the 16-bit matching-bracket / program-counter control-flow components, then increase guest tape beyond fixed eight cells and execute the actual compiler under bounded guest fuel. Do not label isolated components or preserved interpreter regressions as the required same-interpreter nested compiler proof.

See `source-pc-16bit-eight-cell-evidence.json` for frozen output SHA-256 digests, exact fixture hashes, diagnostic case counts and negative probe bytes.
