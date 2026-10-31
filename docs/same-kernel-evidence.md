# Same-reference nested compiler execution

2026-10-26. **Partial compiler proof passed; mandatory complete Android compiler nesting remains blocked. Stage A is not accepted.** [Plan](same-kernel-plan.md), [machine ledger](same-kernel-evidence.json), [integrated native/device evidence](android-native-compiler-evidence.md).

Two copies of the unchanged 423-command reference interpreter actually execute the real original and compact raw AArch64 compilers. The new BF request driver preserves both exact source streams and inserts their separators. Expected results are complete frozen native artifacts, checked with the independent BF binary comparator and an external byte veto. An interpreter's complete return plus independently successful root exit is required; a matching prefix never passes.

| Real compiler/input | Watchdog | Seconds | Exit | Actual / expected bytes | Result |
| --- | ---: | ---: | ---: | ---: | --- |
| Original / A | 600 | 560.8055668 | 0 | 264 / 264 | Exact; BF comparison zero |
| Original / B | 600 | 600.3478578 | 124 | 267 / 272 | FAIL; BF comparison one |
| Compact / A | 600 | 353.2109242 | 0 | 140 / 140 | Exact; BF comparison zero |
| Compact / B | 600 | 440.3909945 | 0 | 144 / 144 | Exact; BF comparison zero |
| Android callback | 600 | 600.2555195 | 124 | 1 / 220 | FAIL |
| Android guest / A | 600 | 600.2836186 | 124 | 0 / 584 | FAIL |
| Entire integrated native compiler / A, 64-MiB root | 600 | 600.3306425 | 124 | 0 / 16,646 | FAIL |

An initial whole-integrated attempt with the smaller root was cancelled with exit 143 after 135.8431929 seconds to change the physical tape capacity. It is superseded by the explicit 64-MiB test, not silently converted into a pass. The reference's two tape expansions justify checking capacity separately; the larger-capacity run still timed out. No hotspot profile or performance fix is claimed.

The root seed's externally generated C representation of the unchanged BF reference was compiled outside the checkout using installed NDK Clang, `--target=aarch64-linux-android35 -include stdlib.h -O3 -fwrapv`. The first root provisions 2,097,152 tape bytes; the expanded root provisions 67,108,864. These are disclosed invocation resource envelopes, not app-size limits or deterministic guest fuel. Compiled root execution is seed acceleration, not a COCK-produced native host compiler.

The reference is a trusted-tool experiment with byte cells and EOF-zero; it does not implement the dynamic-PC kernel's counted-source, fuel, logical-pointer trap or COCK framed-status profile. No failed dynamic-kernel result is relabeled. Its existing third-party attribution/license remain in force. Both root configurations repeat all 256 byte values and EOF-zero controls, and the new request driver passes three exact literal/binary cases. Full source, process and physical closure remain independent obligations.

Single-reference execution of the **entire** new native producer passes for A, B and fresh Q and yields real device-tested APKs. That is a substantial component result, but the smaller raw-compiler nested proofs do not establish the required same complete compiler at both levels. Keep Stage A open, preserve the passing components and do not optimize/promote an unverified whole-stage candidate.
