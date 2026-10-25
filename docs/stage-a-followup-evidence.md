# Stage A followup development and tool installation result

**2026-10-24. Classification: development-only diagnostics, not an accepted Stage A or Android application milestone.**

## Installation and feasibility

The x86-64 Debian container already has Java 21, Clang/LLVM and GNU C compiler. There is no `adb`, `sdkmanager`, Android emulator or `/dev/kvm`. The official Google download and an attempted package-manager update could not reach external package servers due network/DNS restrictions. Therefore the SDK, Android Emulator, Android NDK, system image and an independent standards-only BF evaluator **could not be installed**. Native Android loading and logging were **not tested**. See `docs/sdk-environment.md` for the pinned official download, checksum and operator steps for a suitable host.

A temporary, locally authored C diagnostic BF evaluator was compiled to `/usr/local/bin/cock-bf-diagnostic` outside the repository and tested against an existing arithmetic BF evaluator. This is not third-party independently supplied bootstrap software, is not checked into the repository and cannot satisfy the strict root-executor, production-transformation or independent-oracle gates.

## Completed bounded component draft and consolidated diagnostics

The BF-authored `src/raw_subset_gate.bf` reads one unsigned-byte source length, exactly that many raw source bytes, and a required `A5` terminal guard, then emits `01` provisionally for a valid loop-free single-cell `+` or `-` source ending with exactly one `.`; otherwise `00`. Its entire algorithm is Brainfuck commands with safe annotations. The caller must separately attest the **real stream byte count and host closure**. The one-byte length is a configured *slice/invocation* budget, not a universal COCK source-length limit.

After drafting the source and all frozen fixtures, a single consolidated batch checked all seven annotated BF files and ran all **13 fixed acceptance fixtures**, all passing with expected exact single-byte results. Another diagnostic batch ran **400 deterministic seeded differential cases**, all passing against an independent outside-repository predicate. The fixed tests include NUL byte, illegal suffix, missing/double final output, unsupported commands, empty source, missing and corrupted guards, and arithmetic after final output. JSON evidence records the exact component hash and local diagnostic evaluator identity.

This is incremental progress against source preflight, **not** full Part 1 annotated source grammar support. The byte `01` is *not* an authoritative terminal result and cannot be fed to a packaging publication authority without a separate trusted process/transport completion result. The gate does not implement general-length framing, annotated comments, bracket validation of admitted full-language programs, printable ASCII output admission, resource/fuel errors, or full `COCK-FRAME-v1` result synthesis. The compiler still cannot run inside BF-in-BF; nested self interpretation and Android debug APK generation are not done.

## Tested standalone commands

The local diagnostic evaluator (available only inside this container) accepts program path and binary stdin and emits binary stdout:

```text
printf '\002+.\245' | /usr/local/bin/cock-bf-diagnostic /mnt/data/COCK/src/raw_subset_gate.bf | od -An -tx1
```

Observed result is `01`. This is a diagnostic tool invocation, not a one-command compliant COCK production build. To reproduce the 13 fixed exact-byte tests, inspect `fixtures/raw-subset-gate-vectors.json` and use any qualified BF executor with the declared source-input transport contract. The randomized comparison was carried out by a separately executed ephemeral Python diagnostic outside the repository; it is not BF-authored checked-in test logic and does not replace mandatory BF-only oracle/test source required for accepted Stage A.
