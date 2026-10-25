# Stage A feasibility and scope decisions

Updated 2026-10-26. Development is authorized; **whole-stage acceptance remains incomplete**. [Current evidence](windows-device-evidence.md) supersedes old cloud-host availability statements.

| Item | Decision and observed boundary |
| --- | --- |
| Target | Explicitly selected Pixel 8 Pro / husky, API 37, native `arm64-v8a`, 4096-byte pages |
| SDK policy | Minimum and target remain 35; debug metadata compiled with installed API 36 resources |
| Other connected device | Not selected or modified |
| OS entry | `ANativeActivity_onCreate(ANativeActivity*, void*, size_t)`; BF-generated 220-byte callback at `0x800` |
| Internal entry | `cock_guest_run_v1(context*, result*)`, 40-byte context / 56-byte result, at `0x1000` |
| Observation | One printable byte via system `liblog.so`; invocation tag, PID and installed APK identity |
| Acquisition | At most sixteen exclusive attempts; busy/exhaustion records 14 without guest work |
| ELF | BF-produced ET_DYN, RX/RW separation, 16-KiB load alignment, nonexecuting stack, RELRO, immediate binding |
| Package | NativeActivity, `hasCode=false`, no app DEX/shim; unchanged stored library and 16-KiB ZIP alignment |
| Signing | Fresh disposable key and external SDK tools; never release signing |
| Bootstrap | Unmodified upstream Tritium outside checkout; Android seed passes binary/EOF probes; Windows text-mode builds rejected |
| Authority | Separate BF components exist; trusted complete frontend/build graph not implemented |
| Nesting | Complete identical-interpreter compiler proof remains mandatory; partial output fails |

App subset: one initially zero wrapping byte, source-ordered `+`/`-`, exactly one final `.` and output `0x20..0x7e`. Input, pointer travel, loops, nonprintable output, binary stdout, UI and general Android services are unsupported. Source grammar/brackets precede capability admission; the raw backend cannot authorize arbitrary input.

The original/compact `mini_compiler*.bf` raw return-value instruction producers remain preserved. Their output is not an Android ELF. The later `android_*` modules implement the distinct native ABI/container; full source/transport integration remains absent.

The device proves the chosen loader/log path. It does not certify API 35 execution, a 16-KiB runtime, production packaging or full COCK conformance. Promotion follows [acceptance](acceptance.md) and [issues](stage-a-issues.md).
