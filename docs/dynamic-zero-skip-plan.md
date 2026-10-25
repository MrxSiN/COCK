# Stage A bounded implementation slice — general zero valued loop skip

## Scope and declared interface

Preserve the compiler capable baseline and the tested dynamic clear loop interpreter. Add one new Brainfuck authored interpreter variant which, upon encountering an opening bracket with a zero guest cell, scans the original commands through the matching closing bracket including nested brackets. For nonzero guest cells retain the original restricted exact clear loops. Existing logical tape budgets from one through two hundred fifty six cells remain in force.

The diagnostic input is one unsigned byte equal to maximum additional guest cells, then raw normalized source commands terminated by zero. Output is raw guest bytes followed by a one byte development status. Source byte NUL, source closure, full annotated grammar, host I O and early source preflight remain external prerequisites. Unmatched or unrepresentable nested scans report unsupported capability. This component is not the complete COCK guest profile.

## Acceptance inventory before tests

- New Brainfuck executable source in src/bf_in_bf_dynamic_zero_skip.bf
- Preserved baseline src/bf_in_bf_dynamic_budget_clear.bf
- Independent expected byte fixtures covering zero loops with arbitrary nesting and ignored I O operations
- Negative fixtures for truncated zero loops and nesting overflow
- Differential comparisons on existing linear and nonzero exact clear loops
- Frozen six original and compact raw AArch64 compiler artifact comparisons through the unchanged six cell interpreter
- Executable source audit for all repository authored BF programs

## Evaluation boundaries

The outside repository BF diagnostic executor runs the source for tests but is not the qualified production root. Success cannot imply exact guest fuel, full compiler execution, nested same implementation self hosting, or Android execution. All such features remain blocked or deferred. No test runs during first pass drafting.
