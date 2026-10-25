# BF executable implementation checkpoint — Linux AArch64 diagnostic

**2026-10-25; executable BF source implemented and locally diagnosed. Not an accepted Stage A Android build.** The archived master prompt and the A01–A14 full design remain authoritative. This bounded addition addresses a real executable gap without claiming that its *Linux* ABI meets the specified Android `arm64-v8a` NativeActivity/ELF/shared-library contract.

## Complete bounded source and executable inventory

- `src/experimental_aarch64_elf_compiler.bf`: actual BF program. Input is a previously admitted normalized arithmetic program, zero byte terminator, then an independently established identical copy, followed by physical EOF. First pass counts every normalized opcode and uses BF cell arithmetic to derive total ELF byte length. It then emits the ELF64 header, one AArch64 `PT_LOAD`, entry wrapper, and runs the **unchanged** compact native BF compiler in its own second-pass code to write the native guest body. Successful stdout is a binary ELF with no prefixed status. Current emitter has a **24-bit output-length implementation width**, not a project-wide source or app-size policy. On that logical overflow it emits a zero rejection byte, not an ELF.
- `src/experimental_aarch64_exec_elf.bf`: separate actual BF program. Input `u16 native_instruction_bytes | exact native_instruction_bytes`. Computes the correct 64-bit ELF `p_filesz`/`p_memsz` from the u16 count (including a third size byte when needed) and emits exactly that many bytes. Uses a linear copy loop for the low byte count followed by full 256-byte blocks for the high count. It is a trusted **diagnostic** native-code wrapper, not a source validator, ELF inspector, or production artifact-output framer.
- `artifacts/{tiny_app_a,tiny_app_b,held_out,heldout_mixed_ascii}.experimental.aarch64-linux.elf`: actual binaries emitted by the first program, rather than fixtures named with an ELF extension. No host compiler/linker supplied the application arithmetic or ELF machine bytes.
- `docs/experimental-aarch64-elf-evidence.json`: all 158 case results and limitations. Existing sources, frozen `.raw` expectations, and saved nested inputs are unchanged.

Static AArch64 entry wrapper: `bl` to the appended guest native function; when the function returns, `mov x8, #93; svc #0` exits the **Linux** process with `w0` as exit status. The entry address is `0x400078`, the guest starts at `0x400084`, load base `0x400000`, segment align `0x1000`, ELF `ET_EXEC`, AArch64 machine 183, flags read/execute. The guest body begins at file offset **132**. Native bytes vary with every arithmetic command; no application-name table supplies them. Example results are predicted exit statuses 32 (space), 33 (exclamation), 34 (quotation mark), and 33; these are **not target-observed exit statuses**.

## Real execution evidence and repairs

The initial consolidated test batch had **36/38 passed**. Two high-count runs (65,280 and 65,535 raw bytes) hit the temporary diagnostic evaluator's 300-million-instruction budget and left partial stdout. The BF wrapper's copying loop was repaired to use a low-count loop plus 256-byte high-count blocks, rather than recopying the remaining length for each byte. The complete affected batch was rerun, not only the failed cases.

The final independent local diagnostic batch completed **158/158 PASS** and **0 FAIL**:

| Check group | Passed / tested | Scope |
|---|---:|---|
| Nested request driver exact fixture vectors | 6/6 | First execution of the previously untested first-pass `tests/nested_request.bf` |
| Nested driver specified counter boundaries | 4/4 | 256 and 257 byte transport, binary-safe |
| Stored real-compiler nested request reconstructions | 2/2 | Exact physical bytes equal historical inputs, **not** successful nested execution |
| Entire checked-out source grammar audit | 1/1 | 61 `.bf` files; accepted code-line alphabet and bracket balance |
| New source admitted by existing BF record serializer and annotated gate | 2/2 | BF-only source checks, not independent host closure |
| Four source-to-AArch64 Linux ELF cases | 4/4 | Correct independent BF oracle value, frozen machine-code bytes, byte-identical two BF emitter methods, valid ELF header/segment under `readelf` |
| Deterministic randomized arithmetic programs | 120/120 | BF oracle, separately specified AArch64 instruction words and ELF bytes; printable outputs |
| Raw binary ELF writer length/binary boundaries | 14/14 | Counts 0–65,535, including header 16-bit wrap to 3rd byte; transport-only cases may contain non-executable raw bytes |
| Separate BF printable profile negative cases | 5/5 | Rejection of nonprintable output, pointer movement, unbalanced brackets, loops and duplicate final dot |

All tests used a **new, temporarily compiled external diagnostic evaluator** (outside the repository) with 8-bit wrapping cells, EOF-zero input, dynamic right tape and precomputed bracket jumps. It is **not independently qualified** to serve as the mandatory COCK root. The testing driver was also outside the repository and is not part of the production compilation path. No Python, C, JS, shell, other conventional executable source or external evaluator was checked into COCK. A one-time outside-repository mechanical authoring aid transcribed ELF literal header bytes and concatenated the unchanged compact BF source; strict end-to-end all-BF development-process provenance is therefore **not certified**. All runtime application-specific binary transformations in this diagnostic are executable Brainfuck.

The independent `readelf -h -l` inspection of each BF-emitted binary succeeded, and NDK-host LLVM `llvm-objdump` decoded the branch, Linux syscall, source-dependent native arithmetic and guest-return words. No AArch64 **execution** took place: this environment lacks a validated AArch64 runtime/emulator, so executable loader behavior and predicted exit statuses are unobserved. ELF syntax and a valid instruction decode alone do not certify device usability.

## Reproduction using an independently supplied BF evaluator

Here `bf-evaluator` is a **placeholder for a real third-party standards-only BF evaluator**, not a repository file or a claimed installed command. Before an acceptance run, qualify its exact cell, EOF, tape, exit and source parsing behavior. For a small exact input, command construction can be entirely literal and physical:

```text
printf '++++++++++++++++++++++++++++++++.\000++++++++++++++++++++++++++++++++.' > /tmp/cock-two-pass.bin
bf-evaluator src/experimental_aarch64_elf_compiler.bf < /tmp/cock-two-pass.bin > /tmp/cock-aarch64.elf
readelf -h -l /tmp/cock-aarch64.elf
llvm-objdump -d /tmp/cock-aarch64.elf
cmp /tmp/cock-aarch64.elf artifacts/tiny_app_a.experimental.aarch64-linux.elf
```

The normal project source path still requires an admitted exact annotated `.bf` file, BF-authored normalization, immutable duplicate stream, independently checked physical byte length and closure, and a BF-owned build coordinator. The literal `printf` command above is a narrow **test vector**, not the missing production coordinator. It cannot authorize compiler acceptance or publication.

## Required gates still NOT MET

1. **Mandatory self-hosting:** The same BF-in-BF kernel executing its own full source and then the complete real compiler has not completed. The five documented 300/600-second attempts timed out. Only the nested request *serializer* and exact request identity were diagnosed here.
2. **Stage A integrated preflight/authority:** Original source-byte offset reports, precedence rules, proven physical source closure, command/source identities, the BF-owned build coordinator, BFIO artifact framing and no-commit finalization are not implemented by these experimental emitters. In particular, deliberately mismatched two-pass inputs are **not compared by the emitter** and must never be trusted.
**Measured negative authority witness:** Supplying different first and second normalized programs (33 versus 34 commands) returned diagnostic process exit **0** and **276 bytes** while the BF header declared **272 bytes**. This is an **expected unsupported security case**, not a valid ELF completion. An independent length/identity validator must veto it, and production must implement BF-owned two-pass identity binding. This concrete counterexample is recorded in the JSON ledger and is not included among the 158 passing admitted-path component checks.

3. **Android contract:** These are Linux `ET_EXEC` files with syscall 93. Android demands a Bionic-compatible `ET_DYN` native shared library, the exact `ANativeActivity_onCreate` callback and internal ABI, source-dependent Android log observation, and a verified 16-KiB compatible package. No such BF emitter, NativeActivity callback, debug APK or device run is claimed. Original A01–A14 scope remains unaccepted.
4. **Root, target and release:** No independently qualified seed, stable ARM64 Android target, debug install/launch or production signing/keys. No measured APK/cold-start/power benefit. The existing restricted compiler baseline and all historical negative evidence remain preserved.

**Publication status:** The two *experimental* BF components are DRAFTED / IMPLEMENTED / diagnostic TESTED. They are not `OPTIMIZED` or `INTEGRATED` into the Stage A Android compiler; the fast copier is a repair to an unusable high-count diagnostic path, not evidence of a validated production optimization. Stage A itself remains **BLOCKED / NOT ACCEPTED**.
