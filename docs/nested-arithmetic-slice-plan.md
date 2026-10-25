# COCK nested arithmetic smoke slice

Status before execution: planned and drafted; test outcomes recorded separately.

## Scope

Demonstrate COCK owned six cell BF in BF running COCK owned first generation arithmetic interpreter, which in turn runs a real arithmetic BF guest. This is bounded nested interpretation but NOT an inner copy of the six cell interpreter, and NOT the real mini compiler. The final Stage A mandatory nested compiler proof remains unverified.

## Frozen inventory

- `tests/nested_arithmetic_driver.bf`: executable BF authored diagnostic source generator and arithmetic input relay
- `fixtures/nested_arithmetic/*.input.bin` and `*.expected.bin`: inert exact input and expected bytes
- `fixtures/nested_arithmetic/vectors.json`: frozen vector descriptions and hashes
- `docs/nested-arithmetic-slice-plan.md`: this inert plan
- `docs/nested-arithmetic-evidence.md` and `.json`: results after all first pass files have been drafted
- `README.md` and `docs/status.md`: post test status appendices

Preserve both production compiler sources, original six cell kernel, fuel prototype, all six raw native artifacts.

## Diagnostic request

The BF authored driver emits one nonzero chunk count for the normalized 103 command source of `src/bf_in_bf.bf`, exactly those 103 literal BF command bytes in source order, then one zero chunk terminator and forwards raw caller stdin until its first zero or EOF. Its purpose is physical data emission only; it does not parse or validate the guest source, and is not an authorized production compiler router. Caller must validate source and exact input closure independently. The data protocol is the existing six cell development fixture grammar, NOT a BFIO or BHIO standard.

The preserved `src/bf_in_bf_six_cell.bf` receives the emitted bytes and executes the 103 command interpreter. That inner interpreter processes admitted plus and minus arithmetic and emits its final accumulator byte on completion. The outside evaluator launches the COCK BF driver for diagnostic generation only, and separately launches the COCK interpreter on the emitted complete byte stream. No foreign language executable source is added to the repository.

## Acceptance vectors

All thirteen manifest cases: `.` emits zero; `-.` emits FF; addition and subtraction wrapping; multiple canceling steps; printable output `0x20`; ASCII letter A `0x41`; deterministic exact output on each case. Compare both emitted request bytes against a frozen independently constructed inert expectation, and nested results against fixture expected output. Run original and compact compiler single layer on all three frozen apps, ensuring exact raw output hashes unchanged. Audit every authored repository BF source for the strict annotated line grammar and balanced brackets. Negative preflight/transport cases remain unsupported by the driver and cannot be reported as passing.

## Limits and acceptance boundary

The input relay interprets data byte zero the same as EOF, so this smoke path is restricted to already admitted ASCII arithmetic commands. Outer interpreter guest tape capacity is six cells. The original inner arithmetic interpreter uses five cells and has no guest loop/pointer/input support. Neither nested source preflight nor host process/pipe closure is implemented by this driver. The broader COCK source, fuel, tape and Android requirements remain open.
