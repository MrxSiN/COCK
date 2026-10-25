# Backward bracket target and BF owned reversal evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Status: LOCAL DIAGNOSTIC PASSED for the documented component contract. Stage A self hosting is NOT ACCEPTED. Android testing is DEFERRED.**

## Implementation

- `src/reverse_normalized_source.bf` receives the entire already admitted normalized forward command stream and a diagnostic zero marker; it uses a three cell per record outer BF tape stack to emit the source **in reverse order**. This reversal is performed by executable Brainfuck instructions, not by the outside host.
- `src/general_backward_bracket_probe.bf` receives the resulting reversed prefix beginning at a closing bracket, followed by the same zero marker. It computes the distance backwards to the corresponding opening bracket, supporting properly nested structures and checked unsigned sixteen bit distance. The result is **two little endian distance bytes plus one diagnostic status byte**. Failed lookup zeros the distance.
- Both are separate tools, not an integrated loop executor. The input to the backward scanner must be an admitted prefix ending at the closing bracket of interest. Locating and selecting this prefix inside a complete program remains a BF authored compiler or interpreter responsibility in a future slice; the test harness may supply fixture prefixes but does not fulfill that integration requirement.

Private diagnostic status values: `00` success; `03` missing opening bracket; `0A` nesting or distance representation overflow; `0D` wrong first command. This is **not a new COCK wire version**.

## Executed diagnostic results

| Check | Observed result |
| --- | ---: |
| Exact byte reversal and backward lookup fixed cases | 9 passed |
| Checked distance boundary cases | 9 passed |
| Nesting boundary cases | 6 passed |
| Seeded valid generated balanced sources | 280 passed |
| Seeded arbitrary normalized-source prefixes | 120 passed |
| Actual closing brackets in original and compact mini compilers | **57 of 57 passed** |
| Checked unsigned sixteen bit overflow boundary | 2 passed |
| Earlier forward probe regression cases | 4 passed |
| **Total exact result cases** | **487 of 487 passed** |
| Unchanged original and compact AArch64 compiler artifacts | **6 of 6 exact byte matches** |
| Repository authored BF source grammar and balanced brackets | **32 of 32 passed** |

The two real compiler command streams have respectively 515 and 452 instructions, with 30 and 27 closing brackets. For each closing bracket the test supplied the actual source prefix, executed **BF code** to reverse the bytes, executed the new BF backward lookup and compared the three output bytes against an independently computed reference target. This is a standalone diagnostic; it does not prove an integrated BF generated program counter.

The frozen existing `src/bf_in_bf_six_cell.bf` was independently rerun using its saved six input fixture streams. All six candidate native instruction binaries are bit for bit identical to the already frozen `artifacts/*.aarch64.raw` payloads: original sizes 264, 272, 280 bytes; compact sizes 140, 144, 148 bytes. These are raw instructions, **not ELF shared libraries, installed applications or signed APKs**.

Representative exact backward lookup outputs:

| Input forward prefix | BF reversed bytes (before sentinel) | Result hex | Meaning |
| --- | --- | --- | --- |
| `[]` | `][` | `01 00 00` | Matching open is one command earlier |
| `[+]` | `]+[` | `02 00 00` | Distance two |
| `[+[--]+]` | `]+]--[+[` | `07 00 00` | Outer opening bracket |
| `]` | `]` | `00 00 03` | Missing opening bracket |
| `[+` | `+[` | `00 00 0D` | Does not end in a closing bracket |
| An opening bracket and a close at distance 65535 | Long BF reversal | `FF FF 00` | Largest supported distance |
| An opening bracket and a close at distance 65536 | Long BF reversal | `00 00 0A` | Checked overflow |

The 255 and 256 nesting boundary was also checked: depth 255 is admitted where representable and depth 256 is rejected with checked overflow. These are **component-specific temporary data widths**, not global Brainfuck source, application or module limits.

## Important nonconformances and boundaries

Two deliberate negative probes showed **unsafe acceptance of extra bytes after a zero terminator**. Reversing the input hex `5B 5D 00 2B` produced `5D 5B` rather than rejecting the extra final `2B`; giving the lookup `5D 5B 00 2B` returned `01 00 00` without detecting the extra bytes. These are *open host-closure problems*, **not passing correctness cases**. Preflight must reject source NUL bytes, validate complete original annotated source and reconcile exact input length and independently successful transport closure before either component is used. A conventional host cannot be credited with performing production source reversal or bracket lookup.

The backward scanner still needs an integrated BF-authored random-access source buffer/PC, guest command fuel, dynamic tape runtime traps and supported status authority. The required same-COCK-interpreter nested execution of the actual mini compiler is not verified. Android SDK/emulator, ELF, APK and device testing were not undertaken.

## Reproduction and provenance

The local diagnostic executor was compiled outside the repository and supplies generic eight-command Brainfuck execution (eight-bit wrapping cells and growing right tape). It is **not independently qualified** as the mandatory standards-only bootstrap. The outside batch runner does fixture selection, process invocation, exact-byte comparisons and independent oracle calculations; the actual normalized-source reversal and lookup transformations are executed by repository `.bf` code. No C, Python or shell executable source was added to the repository.

Using a compatible external BF executor, feed a legal normalized source prefix plus a zero byte to `src/reverse_normalized_source.bf`; feed **exactly those emitted bytes** plus a zero byte to `src/general_backward_bracket_probe.bf`. Inspect the three resulting bytes separately and corroborate entire input/read/write/exit closure out of band. Full run evidence, raw result triples, compiler-source digests, and exact machine-code payload hashes are in `docs/backward-bracket-evidence.json`.

**Do not promote these source fragments to an Android compiler or self-hosting milestone until the higher level gates have passed.**
