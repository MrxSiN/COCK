# Dynamic tape interpreter diagnostic evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Status: **COMPONENT DIAGNOSTICS PASSED; STAGE A NOT ACCEPTED**.

The BF-only `src/bf_in_bf_dynamic_linear.bf` reads a **pre-admitted linear five-command subset** (`+ - < > .`) and represents each guest tape cell using a twelve-cell outer BF record. It traverses the logical guest tape rightward on demand; the component contains no fixed tape-cell maximum. Under an already initialized zeroed right-growing BF host, fresh cells start at zero. A guest move `<` at address zero reports `04` without physically moving the outer tape left. Unsupported commands produce `0D`. Guest output is followed by one terminal diagnostic status byte; this is not the official COCK frame/status ABI.

## Consolidated test batch

- **20/20** fixed and boundary cases passed, including right travel beyond 6 and 255 cells, growth past 1000 and 7200 guest cells, wraparound, preservation and zero initialization, return trips and a left-trap after hundreds of cells.
- **500/500** deterministic seeded random guest programs matched a separate outside-repository diagnostic reference implementation for exact guest-output plus status bytes. Seed: `20261024`.
- **6/6** unchanged original and compact compiler artifacts remain byte-identical when executed using the **separate unchanged six-cell interpreter**; these regressions do not show that the new dynamic component can execute a compiler.
- **21/21** `.bf` modules passed the annotation syntax and bracket audit.
- The highest independently modeled rightward guest address reached was **7200** (the physical external interpreter preallocates storage, so do not confuse its reserved capacity with observed committed/visited guest addresses).
- BF-authored component SHA-256: `c2648b8b33648696dbd222a5bfa2605f72acd87767faa8344df8203c1edb0c55`. Commands: **801**.

## Defect found and fixed during batch

Initial negative probing of `<` at logical address zero exposed an outer interpreter left-boundary failure. Its control branch was corrected to suppress pointer travel after the guest left-boundary trap. All fixed and randomized tests reported above were rerun with the corrected source. That initial failure is not counted as a pass.

## Evidence limitations

This is a deliberately restricted *linear* interpreter and **not** the `COCK` complete guest profile. Loops and guest comma-input remain unsupported. It executes commands as they arrive, so an invalid suffix can leave partial output; complete-source preflight, source offsets, guest fuel, configurable logical tape budgets, physical I/O errors, and independent transport closure are missing. A zero terminator alone cannot distinguish genuine `00` from EOF under the COCK guest contract. Inputs in this test batch are sealed diagnostic fixture bytes only. The evaluator was a locally built diagnostic BF evaluator outside the repository, **not an independently qualified Stage A root bootstrap**. The Python comparison model and testing coordinator were outside the repository, so strict BF-only development-process authorship is not certified.

The full same-interpreter nested mini compiler proof and Android ELF/APK/device testing remain **NOT VERIFIED**. The original six-cell interpreter, its source and all six frozen outputs were preserved. No target compiler, APK, device launch, release signing or production claim follows from this new primitive.
