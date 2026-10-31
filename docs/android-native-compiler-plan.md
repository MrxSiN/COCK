# Integrated native producer slice

2026-10-26. Complete first-pass inventory before drafting: `src/android_native_compiler.bf`, `fixtures/android_native_compiler/vectors.json`, this plan and post-test `docs/android-native-compiler-evidence.json`/`.md`. Existing BF source admission, source projection, reference interpreter, arithmetic oracle, binary comparator, guest/callback/ELF sources and native golden artifacts remain unchanged.

The missing complete annotated-source frontend remains a separate Stage A blocker. This slice replaces manual component composition with **one BF program** for admitted normalized application input. It must validate its whole normalized arithmetic input before producing native bytes, then generate the callback, guest and ELF directly with shared-tape BF handoffs. The external host must not compute a native length, supply native code, choose modules or assemble the ELF. Existing BF instruction emitters are edited mechanically into the integrated source; no foreign source generator is maintained or introduced.

## Narrow input and output

Input is eight literal little-endian original-dot-offset bytes, then repeated positive u8 chunk counts and exact normalized source bytes, then zero chunk count and A5. The dot offset is a caller precondition from independently admitted source; this component does not establish that original-source mapping. Binary input records must be sealed with independently known actual read/count/close outcomes. Physical extra bytes fail independent closure; EOF-filled missing guards fail BF admission.

The normalized subset is one wrapping byte, arithmetic plus/minus and exactly one final printable dot. The BF gate buffers every command until complete admission; empty source, further commands after a dot, unsupported instructions, nonprintable results and bad guards reject. Commands span arbitrarily many chunks. The implementation uses u16 command/native-size arithmetic, rejects overflow and documents this representation boundary as a component capability limit, never a universal source/app policy.

Output on rejection is one zero byte. Output on admission is byte one, u32 little-endian ELF byte count, exactly those ELF bytes, and final A5. This is a **diagnostic single-artifact record**, not BFIO or an authoritative whole-build success. The producer computes length and all executable bytes in BF. Complete exact bytes, final guard, root process success and independent output close are all necessary. A good prefix or missing status/guard cannot authorize packaging.

Use the preserved 220-byte bounded callback and native guest/ELF layout without changing Android ABI or protocol identifiers. Native guest size is `452 + 4 * normalized_command_count`, checked before artifact output. ELF extent remains derived from its actual guest size and 16-KiB alignment; no whole-app executable template is copied.

## Test gate

Finish and snapshot all first-pass files before implementation tests. Then run exact admitted/rejected requests, missing/mutated guard, binary NUL, unsupported pointers/input/loops, multiple/missing dots, nonprintable output, multiple chunks, 255/256 boundaries and native-size overflow. Compare complete direct versus reference-interpreted output with BF byte comparison and external byte veto; compare extracted ELF/native instructions to existing producers and inspect with installed LLVM. Run same-reference nesting on the actual integrated program under the declared watchdog; preserve a timeout as failure. Select a fresh held-out arithmetic source after the draft checkpoint. Build/install debug-only APKs only from completely verified outputs; preserve exact ELF identity through SDK packaging and device observation.

The loop-free native body is bounded by admitted command count. This slice does not certify full raw-source grammar/errors/offsets, BFIO, general interpreter traps, production signing or whole Stage A usability. Those gates stay open even if this integrated native producer passes.
