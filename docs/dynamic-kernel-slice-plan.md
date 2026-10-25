# Compiler-capable dynamic tape kernel slice

Status: BULK TEST COMPLETE / BLOCKED ON NESTED RUNTIME. The original pretest plan is preserved in the immutable draft archive. See `dynamic-kernel-evidence.md` for actual outcomes; no default integration or optimization is authorized by the passing component checks.

This implements a candidate successor to the fixed eight-cell interpreter, not a new wire ABI or an accepted Stage A release. The original kernels, compilers and frozen native payloads remain unchanged. Android API 35 / arm64-v8a / NativeActivity remains the selected application target; actual native entry, ELF/APK and device evidence remain blocked or unimplemented as recorded in the current Android report. No host executable is substituted for an Android proof.

The new diagnostic request is `u16le normalized source count | u32le original-command fuel | u16le logical cell budget | source bytes | guest stdin`. Budget zero encodes 65,536 cells; other values encode their unsigned count. These are invocation-format bounds, not universal application limits. Source count is at most 65,535 commands. All eight commands, complete normalized lexical/bracket admission, modulo-byte data, EOF-zero, pre-effect fuel, left trap and right-budget trap are required. Output remains guest bytes followed by one provisional diagnostic status: 0 success, 4 left, 5 right, 6 fuel, 13 invalid source. This is not authoritative BFIO/BHIO framing or annotated-original-offset admission.

Sixteen-cell records share source storage and guest storage in different fields. Source-PC and guest-pointer prefix markers permit traversal without a fixed eight-cell switch. Capacity markers are prepared from the supplied budget; physical space is O(max(source count, budget)), and traversal costs scale with position. This is an intentionally unoptimized, capacity-backed logical growing tape, not demand-paged physical allocation. The bounded nested attempt provisions enough outer guest cells for the inner kernel's actual records. Arithmetic counters must not silently wrap into another profile.

## Frozen inventory before source drafting

- `src/source_pc_dynamic_tape.bf`: complete new kernel, handwritten eight-command BF.
- `tests/wide_request.bf`: counted source/input request serializer.
- `tests/wide_request_from_legacy.bf`: BF-only adapter for the existing stored sixteen-bit-fuel fixtures.
- `tests/source_guard_records.bf`: exact-count physical-source record serializer for the preserved BF annotated-source gate.
- `tests/byte_compare.bf`: independent counted binary comparison, including NUL/FF.
- `tests/small_request.bf`: adapter to the preserved independent one-byte dynamic BF interpreter for common-profile differential checks.
- `tests/dynamic_boundary_source.bf`: BF-authored producer of the literal 257-command growth boundary fixture.
- `fixtures/dynamic_kernel/vectors.json`: literal vectors, expected bytes and resource contracts; no executable test DSL.
- `docs/dynamic-kernel-slice-plan.md`, `docs/dynamic-kernel-evidence.md`, `docs/dynamic-kernel-evidence.json`: workflow, measured results and failures.
- Existing `tests/oracle.bf`, annotated source gate/normalizer, small dynamic interpreter, six frozen compiler payloads and 73 fixed-kernel fixtures are dependencies, not rewritten implementations.

All inventoried first-pass source and data must be complete before the consolidated batch. A tar snapshot and hashes outside the checkout preserve the pretest draft. No Python/C/layout generator, host semantic oracle or foreign executable source is authored for this slice. External installed Tritium starts BF modules; POSIX file tools supply exact bytes/counts and independently compare/hash outputs. All new framing/comparison algorithms are BF. Existing external Python diagnostic scripts are not used for this implementation.

## Consolidated acceptance batch

1. BF-owned annotated-source gate on every new BF file, normalized stream identity, bracket checks and repository executable-language inspection.
2. Literal success/failure vectors: empty source; arithmetic wrapping; NUL/FF and EOF; unmatched/illegal suffix before effects; nested forward/backward loops; fuel zero and exact cutoffs; checked left/right moves; zero-initialized new cells; return to earlier guest cells; capacities greater than eight and byte-counter boundaries.
3. Common-profile results against the independent preserved BF dynamic interpreter and arithmetic BF oracle. Compare exact binary results with the new BF comparator and independent `cmp`.
4. Actual original and compact mini compilers under the new kernel on both examples and the held-out program: all six frozen AArch64 payloads plus success byte must match. Legacy fixed-kernel regressions remain available.
5. The same new kernel under itself executing the actual compact and original compiler, with exact payload comparison. Bound external wall time separately from guest fuel; a timeout is not a nested-self-hosting pass.
   Select an additional previously unlisted valid arithmetic guest only after the draft checkpoint and compare its value with the independent BF oracle; the old archived held-out app is not a new held-out selection.
6. Known physical truncation, trailing bytes, source annotation/original offsets and root bootstrap qualification remain explicit negative/unsupported boundaries. Android and ELF/APK checks are NOT RUN without a usable target or producer.

Batch all related repairs, rerun affected checks and the full slice suite. No optimization before a passing baseline. Never promote a failing candidate or claim full Stage A acceptance. Update the five feature statuses separately and preserve the old verified compiler path.

## Postdraft evidence files

The test batch froze generated growth requests, a newly selected ASCII held-out source and its compiler requests/expected bytes, and both nested requests/expected bytes under `fixtures/dynamic_kernel`. The postdraft held-out input is canonically annotated in `examples/heldout_mixed_ascii.bf`; its BF-produced normalized stream is identical to the originally selected literal input. Native disassembly text and the evidence ledger were added as inert results. No new interpreter or test-tool implementation was added after the draft checkpoint. Historical test cases and generated fixtures are separate from accepted application artifacts.
