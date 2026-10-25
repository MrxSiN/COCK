# Cloud Android testing environment — 2026-10-25

This report supersedes the archived machine observations in `sdk-environment.md` and `docker-android-feasibility.md` for this cloud instance. Older reports remain historical evidence, not current machine status.

## Scope and provenance

Imported the supplied Stage A workspace unchanged, including its previous evidence, and retained the supplied master engineering prompt as reference material. This task installs external development tools and tests existing BF components; it does not implement the prompt's broader compiler roadmap. Imported historical test counts are not results from this task.

All 50 repository executable sources are still Brainfuck. SDK, evaluator sources, binaries, download archives and the independent verification harness reside outside the checkout under `/workspace`. No conventional compiler/test implementation was added to the project.

## Verified here

- Linux x86_64; OpenJDK 21; no `/dev/kvm`.
- Official SDK command-line tools 19.0 installed at `/workspace/android-sdk/cmdline-tools/19.0`. Its archive matched the checksum in Google's HTTPS repository metadata. SHA-256 and provenance are in `cloud-environment-evidence.json`.
- SDK Manager 19.0 runs, and its remote package listing succeeds with the existing network proxy. An additional official 22.0 tool installation is retained; its deprecated `sdkmanager` does not perform the legacy package-list action. Use the tested 19.0 path.
- Independent upstream Tritium built outside the repository from the pinned upstream commit in the evidence JSON. Installed executable: `/workspace/tools/bin/tritium`.
- **50/50** BF files passed an independent static annotation/command/bracket audit.
- **73/73** stored `source_pc_16bit_eight_cell_loops` fixture replays passed with exact output bytes and successful process completion. Six of these execute the real original/compact mini compilers through the BF-in-BF interpreter and match frozen native instruction payloads plus their terminal diagnostic status.
- Executor probes passed modulo-256 cells, NUL/FF binary transport, EOF-to-zero, nested loops and a 100,000-cell rightward traversal. These are bounded probes, not unlimited-tape proof.

The invocation tested was `tritium -r -b -z -B -O1 -fno-negtape src/source_pc_16bit_eight_cell_loops.bf`, with each stored `.input.bin` supplied on stdin and stdout compared byte-for-byte with its `.expected.bin`. Run from `/workspace/COCK`. Each replay had a 120-second timeout. Detailed results and timings are in `cloud-bf-fixtures.json`. The external Python inspection harness only reads fixtures, invokes the BF evaluator and compares bytes; it does not implement production transformations or a guest-semantics oracle.

## Evaluator qualification limits

Tritium is an independent installed evaluator, but is **not a qualified complete COCK bootstrap**. Unmatched brackets emit warnings yet exit zero and can emit earlier output. A left-boundary probe did not trap. The `-fno-negtape` option must not be represented as a runtime boundary guarantee. The outer memory implementation uses a large finite mmap reservation with lazy physical backing; it is not an unlimited dynamic tape.

An interactive `,.,.` probe produced `AB` correctly at completion but did not expose `A` before the second input was supplied. BHIO interactive routing is therefore unsupported in this tested configuration. Malformed-source admission, trusted closure, guest limits and framing must remain BF-owned responsibilities. The stored fixtures validate only the existing bounded noninteractive component. Full same-interpreter nested self-hosting remains unverified.

## Android status and next steps

SDK license acceptance is pending explicit owner authorization, as required by the supplied workspace instructions. Licensed platform tools, API 35 platform, build tools 35.0.0, NDK 28.2.13676358, emulator and system image have not been installed. No emulator boot, ADB functional request, APK installation or application launch is claimed.

After authorization, use SDK Manager 19.0 to accept the Android SDK license and install `platform-tools`, `platforms;android-35`, `build-tools;35.0.0`, `ndk;28.2.13676358`, `emulator`, and `system-images;android-35;google_apis;x86_64`. Confirm each required license separately if additional terms appear.

Create an AVD outside the repository. Attempt headless software execution with `-accel off -gpu swiftshader_indirect -no-window -no-audio -no-snapshot -no-boot-anim`, and verify completed boot, an actual shell operation, API, ABI list and page size using ADB. No KVM is available; software boot performance and viability are unverified. An x86_64 emulator is not evidence of `arm64-v8a` native compatibility. Verify actual ABI/translation support and native loading separately, or use a physical arm64 device/compatible host.

The imported outputs are raw AArch64 instruction bytes, not ELF libraries or signed APKs. Installing Android tools cannot turn them into an installable app. Android functional acceptance remains blocked on the project's ELF/APK/self-hosting implementation as well as the test device. The saved environment draft is separate from publication; restoring a new task has not been tested.

## Reusable configuration

Saved `install_script` and `start_skill` in the environment draft. The install script reproduces the checksum-verified CLI 19.0 and pinned external Tritium build; its repeat run passed and retained the same evaluator binary hash. The startup guidance records the current BF fixture workflow and unresolved Android prerequisites. Licensed package installation and AVD startup are not claimed as tested. Review and save the draft in environment settings, then publish when appropriate; no publication or fresh-task restoration was performed here.
