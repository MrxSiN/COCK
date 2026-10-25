# Engineering principles

Apply SOLID, DRY, KISS, YAGNI, least knowledge, separation of concerns and the Boy Scout Rule to actual changes. Original Brainfuck has no classes/interfaces; do not invent an object framework to imitate the terms.

- Give each BF module one transformation or validation boundary: guest semantics, callback ownership, ELF layout, source admission or package inspection.
- Preserve byte contracts and callers during extension. Update dependent counts, layouts, fixtures and documentation together; retain tested error handling.
- Substitute backends only after checking required cell, EOF, binary, tape and error behavior. The Windows bootstrap failed this contract and was rejected.
- Supply only the records each stage needs. Validators may veto but cannot author app behavior; debug packagers handle inert metadata/container/signatures.
- Keep production knowledge in its owning module. Independent literal expectations deliberately remain independent so a producer cannot generate its own passing oracle.
- Reuse BF serializers/comparisons. Avoid dependencies, generic frameworks, speculative optimizers and empty scaffolding.
- Depend on explicit byte/ABI contracts and a declared mechanical host boundary rather than undocumented internals.
- Fix the demonstrated failure at its responsible layer, add a regression and refresh documentation; preserve unrelated behavior and the last checked baseline.

The callback repair follows these rules: one producer owns acquisition; both consumers follow its 220-byte contract; a BF test forces rejection; guest behavior and public entries are preserved. Component results never replace whole-stage acceptance.
