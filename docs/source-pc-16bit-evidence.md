# Stage A source program counter ledger evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Status: LOCAL DIAGNOSTIC PASS. Not an accepted Stage A interpreter or Android build.**

`src/source_pc_16bit_ledger.bf` is a BF executable component that indexes already normalized source commands with little endian sixteen bit source positions. It does not interpret instructions or change any of the existing production compiler sources. This intermediate diagnostic layout is not a new compatibility wire protocol or document release number.

## Development input and output

Input consists of repeated one byte nonzero chunk counts followed by exactly that many command bytes, then a zero count. Each valid command emits three provisional bytes containing index low, index high, and original opcode. The BF component admits only the original eight source opcodes. The three byte terminal marker `FF FF 00` denotes successful local lexical and length checks, and `FF FF FF` denotes a failed local check. These markers are not trusted host process status and not `COCK-FRAME-v1` frames.

The index representation admits 65,535 source commands with offsets from 0 through 65,534. A subsequent source command fails before its indexed record is emitted. Partial source records printed before a later failure are **provisional and must never be published or passed to guest execution**. A BF downstream consumer must verify the whole record stream, terminal marker, independent source admission, and host closure first.

## Current observed results

- Exact byte diagnostic cases **572 of 572 passed**, including all 256 single input byte values, 300 seeded randomized inputs, ten source length and index boundaries, two complete real compiler sources, malformed suffix, and 65,535 and 65,536 source command limits.
- Original compiler **515 commands**, compact compiler **452 commands**, both indexed without index wrap. The last ledger record for the original is offset 514 followed by a `FF FF 00` marker.
- The preexisting `bf_in_bf_six_cell_preflight.bf` reran both actual compilers on three example inputs each and reproduced **6 of 6** frozen AArch64 raw binaries, from 140 to 280 bytes. This is an **independent baseline regression**, not a compiler running under the new ledger component.
- All **43 annotated repository BF files** passed a source grammar and bracket-depth audit. The new ledger source contains **3,863 BF executable commands**.
- The outside repository compiled diagnostic BF evaluator provided the runs. It is not a qualified independent bootstrap executor and is not part of the repository.

## Confirmed unacceptable transport outcomes

Two deliberately failing closure probes were observed. With a valid zero chunk count followed by extra bytes, the BF component ignored the extra bytes and emitted `FF FF 00`. With the zero count missing, the diagnostic host's EOF-zero behavior made the BF program emit `FF FF 00`. This component cannot prove exact physical source closure. Production use requires independent host actual read count, successful file and pipe close, invocation status and identity, plus BF-authored whole-source admission. A terminal marker is not a substitute for those facts.

## Remaining acceptance gates

The new ledger must be consumed by a BF-authored program counter interpreter with widened offsets and guest fuel, dynamic tape storage that cannot collide with the source region, complete validated source handoff and genuine output authority. The 255-command dynamic interpreter is unchanged and cannot yet execute the complete compilers. Full same-interpreter nested compiler execution and Android ELF/APK and device verification remain **NOT VERIFIED / DEFERRED**. Source authoring used a temporary external layout aid, so the stronger pure BF development process provenance requirement is not certified.

Machine readable case hashes, sample sizes and results are in `docs/source-pc-16bit-evidence.json`.
