# Bounded six cell runtime fuel slice

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status: design inventory and diagnostic acceptance vectors. Android deferred.

## Boundaries

This slice prototypes an **independent Brainfuck interpreter** with a six-cell guest tape and execution fuel before integrating these behaviors into the existing compiler-capable `bf_in_bf_six_cell.bf`. The original kernel and compiler candidate bytes remain preserved. Every interpreter instruction algorithm emitted as executable repository source must be eight-command BF. A temporary conventional diagnostic generator and test evaluator outside the repository do not qualify as BF-only production authorship.

## Binary diagnostic request

One fuel byte; one source-length byte (0 to 32); exactly source-length original eight-command bytes; guard A5; one input-length byte (0 to 16); exactly input-length binary bytes; guard A5. No trailing bytes admitted by an independent host. No NUL-as-source sentinel. The nonzero guards detect EOF-zero truncation within the record, but physical closure still requires external attestation.

## Diagnostic result

One status byte (COCK numeric code where applicable), one byte executed-original-command count, one output count byte, one source-position byte (FF when inapplicable or not recorded), then exact output bytes. Failure may return a partial, explicitly counted output. Current source, input, output, tape and fuel limits are **configured prototype capabilities**, never a universal COCK project cap. A resource limit is reported rather than silently truncating.

## Frozen slice inventory

- `src/bf_in_bf_six_cell_fuel.bf` newly authored executable interpreter
- `docs/six-cell-fuel-slice-plan.md` inert interface contract
- `fixtures/six_cell_fuel/*.request.bin` and `*.expected.bin` inert literal input and expected byte data
- `docs/six-cell-fuel-evidence.md` and `docs/six-cell-fuel-evidence.json` result reports after the consolidated test gate
- preserved `src/bf_in_bf_six_cell.bf`, both compiler variants and all six native raw artifacts

## Acceptance vectors

- empty source with zero fuel succeeds with count zero
- zero fuel before plus traps without changing guest state
- `+.` with fuel one traps before the dot, with executed count one and no bytes output
- `[]` with fuel one succeeds after executing only opening bracket
- `+[-]` with fuel three traps before the closing bracket; four succeeds
- `++[-]` completes with seven charged commands (opening bracket charged once)
- `<>` traps at left boundary on first command
- `><` with six cells and sufficient fuel completes, preserving pointer zero
- `>>>>>>` traps when attempting address six (after counting six commands)
- `,.` consumes binary NUL and FF exactly, and emits zero at EOF
- nested finite loops, `]` jump semantics and skipped commands charged zero
- unmatched brackets and illegal suffixes rejected before output/effects
- damaged/missing guard and exact-byte short input rejected
- infinite `+[+]` trips guest fuel, without dependence on host wall timeout
- output-buffer limit causes explicit `UNSUPPORTED_CAPABILITY`
- existing original/compact compiler output candidates remain byte-identical through preserved kernel

The prototype is **not** a self-interpreting full compiler and cannot be promoted to COCK Stage A accepted runtime while the full compiler/nested chain, complete source closure, and Android target are absent.
