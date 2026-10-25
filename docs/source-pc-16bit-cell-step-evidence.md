# COCK Stage A sixteen bit executable arithmetic step evidence

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


**Result:** LOCAL DIAGNOSTIC PASS. This is **not** full Stage A selfhosting acceptance. Android remains deferred.

## Implemented BF only component

`src/source_pc_16bit_cell_step.bf` contains **5,056 executable original Brainfuck commands** and valid nonexecuting annotations. Its SHA256 is `bbaa4e2d353aaf11f532fc7571d1babd4b262b2080686cf2d369fa539bc505d3`. It keeps the baseline PC and sixteen bit original command fuel selection intact and additionally performs one modulo byte guest cell update for admitted executed `+` and `-`. Every other instruction preserves the supplied cell byte; failing status prevents the update.

Each development only input batch begins with a one byte count then that number of records of exactly eight bytes: opcode, sixteen bit PC, sixteen bit matching bracket position, current guest cell, sixteen bit fuel. The output has exactly six bytes per record: status, next PC two bytes, remaining fuel two bytes, and resulting guest cell byte. All integers are little endian. The first five output bytes must exactly reproduce the previous `source_pc_16bit_fuel_branch.bf` decisions. This program processes *independent* record decisions, not a mutable multi cell guest tape.

## Completed consolidated diagnostics

| Test group | Batches | Decision records | Result |
|---|---:|---:|---|
| legacy branch fixtures | 23 | 2,557 | Passed |
| wrap edge cases | 4 | 512 | Passed |
| exhaustive byte values | 4 | 512 | Passed |
| randomized records | 20 | 4,000 | Passed |
| **Total** | **51** | **7,581** | **Passed** |

The suite compared exact six byte records with baseline five byte PC and fuel outputs plus an independently computed arithmetic cell oracle. It exercised all 256 byte values for each arithmetic opcode, wrapping at zero and 255, both loop branch conditions, low/high PC and fuel boundaries, invalid opcode precedence, fuel exhaustion and PC overflow. The compiler source control flow records came from both unchanged 515 command and 452 command BF compilers. Fixtures are literal byte files in `fixtures/source_pc_16bit_cell_step/`. A local compiled outside repository BF evaluator produced the recorded bytes; it is not a verified production bootstrap.

## Unchanged native candidate evidence

| Frozen artifact | Bytes | SHA256 | Result |
|---|---:|---|---|
| `tiny_app_a.aarch64.raw` | 264 | `04008592e9c873d3e8e9eaebeaed4000c55c85e78ff1bce5d2006c03b43365d3` | Exact match |
| `tiny_app_b.aarch64.raw` | 272 | `860d6f0bd7df32d0e93fc50268c25180ef2694b1df3f32c68fdbd23cb2d31624` | Exact match |
| `held_out.aarch64.raw` | 280 | `bbe379ca1beca74c941aebf057be95facc470a46b06f72933e05f9488c2de9c8` | Exact match |
| `tiny_app_a.compact.aarch64.raw` | 140 | `2a252722e1679156d109c8994f0fd0e9eb2f211a68e1f444c5a631ac9529601f` | Exact match |
| `tiny_app_b.compact.aarch64.raw` | 144 | `36af586b0929f05ef8bff362928d9e61ad494fe89a72eb2f2a88e902d845fbe6` | Exact match |
| `held_out.compact.aarch64.raw` | 148 | `76ae6e5ba3a154be3af547a0b8fc0d84b032188d86009f56da98ebe95e5fc12a` | Exact match |

All six frozen raw code candidates were rerun through the **unchanged** BF compiler-capable `bf_in_bf_six_cell_preflight.bf`, not through this new record-level step. The existing generated artifact bytes match exactly; these are not complete Android ELF or APK files. All **47 repository `.bf` files** passed strict line-format and bracket syntax audits. The compressed workspace archive is separately checked after packaging.

## Negative observations and unfinished authority

The following *failed* trust boundaries were observed. They are not counted as successful acceptance tests:

- `short_physical_record`: input `012b000000000701` caused output `000100000008`. missing final record byte treated as guest EOF zero; no trusted byte count.
- `trailing_bytes`: input `0001020304` caused output ``. unconsumed trailing physical bytes not detected by component.
- `forged_bracket_partner`: input `015b04006300000100` caused output `006400000000`. caller-supplied partner must be independently authenticated against the exact BF source.

The component does not decode source, authenticate the supplied partner, execute guest comma or dot operations, retain a guest tape across records, or provide process and transport completion authority. The next required step is to tie the BF-owned stored source, validated bracket map, 16-bit PC/fuel decision, and checked growing guest tape into a *single* interpreter and verify real compiler execution. Same-interpreter nested real compiler execution remains **NOT VERIFIED**.

A temporary outside repository mechanical layout aid assisted drafting, and the independent verification model was not BF source. The repository contains only BF executable source, but full BF-only development-process provenance is **NOT CERTIFIED**.
