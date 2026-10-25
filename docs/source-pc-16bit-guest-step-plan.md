# Stage A sixteen bit guest step slice

## Scope and bounded inventory

- `src/source_pc_16bit_guest_step.bf` is the only new executable repository file. It must contain only the eight BF commands and safe whole line annotations.
- `fixtures/source_pc_16bit_guest_step/*.input.bin` and `*.expected.bin` are inert byte fixtures.
- `docs/source-pc-16bit-guest-step-evidence.md` and `.json` record executed local diagnostic results, hashes and limitations.
- Existing compiler source, fixed AArch64 outputs, and existing BF interpreter source remain unchanged.

## Development-only record contract

Input begins with a one byte count of step records. Every record has twelve bytes in this order: opcode, little endian current PC, little endian matching bracket partner, current cell byte, little endian remaining original command fuel, current pointer, logical tape cell budget, input present flag, and input byte. Output has nine bytes per record: diagnostic status, little endian next PC, little endian remaining fuel, resulting current cell of the original pointer, next pointer, output present flag, output byte. These records are diagnostic only and are not BFIO or BHIO messages.

Recognized opcodes are the original eight BF commands. Unsupported opcode returns status thirteen before consuming fuel. Zero fuel returns status six before guest effects. Valid instructions consume one fuel unit even if left boundary or right logical tape budget traps. A zero cell at an opening bracket and a nonzero cell at a closing bracket jump to the first command following the supplied matching partner; otherwise execution advances one original source command. Arithmetic wraps modulo 256. Input present zero applies the guest EOF zero rule; input present one uses the supplied byte. An input present flag other than zero or one on an input instruction returns unsupported status thirteen before fuel is charged. An output instruction returns an explicit one byte output candidate. A PC result past 65535 reports status ten, a representation limit. Left boundary returns four; logical tape movement budget returns five.

The caller must provide already verified bracket partners, legal step PC and guest pointer under the declared budget, and current tape cell/input state. This BF component does not fetch instructions itself, own the full tape, or authenticate records and transport closure, so its results alone cannot constitute full interpreter acceptance. Test only complete length known inputs from a diagnostic verifier.

## Acceptance planned before drafting

- All eight opcodes and branches in both directions, modulo byte wrapping, EOF versus true input zero, 16 bit fuel borrow and exhaustion, PC carry and overflow, pointer left and logical right boundary.
- Exact byte fixture sets and randomized records with a separately authored outside repository reference model for diagnostic comparison.
- Real compiler source instruction samples and existing six raw AArch64 candidate exact hash/byte preservation via existing diagnostic interpreter, independently from the new component.
- BF annotation and bracket grammar audit and repackage ZIP only after tests.
