# Full Stage D design draft

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


Actual implementation continuation: [real CRC-32 and stored ZIP source/results](real-bcde-implementation-evidence.md) now exist. `src/stage_d_crc32.bf` implements the planned checksum primitive; `src/stage_d_stored_zip.bf` generates a real one-entry archive from variable path/data and BF-produced/verified CRC metadata. Neither supplies binary resources, general aligned APK layout or signing. Whole D acceptance remains unpassed.

Prepared 2026-10-25 (Asia/Kuala_Lumpur) against `fe9d57a`, following master Parts 8, 10–11, 19, 21 and 23–25. **D01–D08 documentary draft: complete. Executable first-pass draft: INCOMPLETE. TESTED: NOT RUN. Acceptance/integration: BLOCKED.** This request is for design; no signing key is created, requested or used, and no release is published.

## Product boundary and policy

The first D capability is a BF-authored direct-install APK for the existing API-35/`arm64-v8a` NativeActivity target. BF produces binary manifest, selected resource structures, ZIP metadata/alignment/CRC, content digests, certificate/signature encodings and APK Signature Scheme v2 bytes. Every app-specific executable byte still comes from the accepted BF compiler. Independent external SDK tools may inspect/veto but may not repair or generate the production package/signature.

Initial scheme profile is RSA-2048 or stronger with exponent 65537, SHA-256 and v2 algorithm `0x0103` (RSA PKCS#1 v1.5 with SHA-256), one signer and one self-signed certificate for disposable tests. Minimum/target API remain 35. This is an explicitly narrow scheme/device policy, not support for pre-24 v1/JAR signing, key rotation/v3, v4/incremental install, AAB/Play, arbitrary APK ZIP extensions or other targets. Validate current official scheme/API requirements before source freeze/release; this design is not a fresh channel-policy verification.

Release-key use stays a separate unsupported gate until the master threat-model, entropy, security/side-channel/custody assessment, device evidence and explicit release instruction are satisfied. A correct disposable-key signature is not proof of safe production signing. Retain labeled Stage A/E external debug packaging for functional diagnostics; it cannot close D07.

| ID | Complete draft coverage | Required closure |
| --- | --- | --- |
| D01 | Exact BF/inert inventory and bounded groups below | All actual source, complete independent crypto/package vectors and selected interfaces frozen before any implementation test |
| D02 | [Binary manifest/resources](stage-d-package-draft.md), input-driven package/SDK/native metadata | Independent binary XML/resource decode, malformed data and actual loader mapping |
| D03 | Checked stored ZIP entries, CRC/order/offset/alignment, full actual entry set | Independent ZIP/ELF alignment/inventory validation including overflow and malformed archives |
| D04 | [Hash/RSA/DER/v2 signing contract](stage-d-crypto-draft.md) and release security boundary | Published independently verified primitive/signature KATs, full APK scheme/tampering verification; custody/release states independent |
| D05 | Explicit API/ABI/page-size/packaging matrix | Separate actual 4-KiB and 16-KiB target outcomes, no inferred compatibility |
| D06 | [Whole-file/device acceptance](stage-d-test-draft.md) | Independent signature/tamper checks plus actual installation, launch and lifecycle |
| D07 | Production ownership, exact byte identities, external debug fallback disclosure | BF-only package/sign algorithm provenance; independent tools veto only; no opaque packager/signer or source helper |
| D08 | Correct baseline time/size/memory measurement and rollback | Measured passing baseline; optional optimization only after all required checks pass |

## Exact proposed executable inventory

Except the now implemented/tested CRC-32 path noted below, proposed paths remain **NOT CREATED**. Every authored implementation, test and developer tool is annotated original-eight-command BF. The separate stored-ZIP subcomponent above is not substituted for the full APK writer.

| Path | Responsibility |
| --- | --- |
| `src/stage_d_manifest.bf` | Binary XML strings/nodes/typed attributes/resource IDs from validated target/app plan |
| `src/stage_d_resources.bf` | Shared Android resource-chunk/string-pool encoding and only registered resource forms; unsupported references rejected |
| `src/stage_d_crc32.bf` | **IMPLEMENTED / COMPONENT TESTED**: ZIP CRC-32 over exact guarded chunk bytes; input/output and actual test identities in the implementation ledger |
| `src/stage_d_zip.bf` | Checked stored local/central/EOCD records, canonical entry set and native alignment |
| `src/stage_d_sha256.bf` | SHA-256 compression/padding/streaming digest over exact bytes, checked length |
| `src/stage_d_bigint.bf` | Checked multiprecision parsing/arithmetic/modular exponentiation and key consistency checks |
| `src/stage_d_der.bf` | Strict DER key/certificate/DigestInfo encoding/decoding within declared profile |
| `src/stage_d_rsa.bf` | PKCS#1 v1.5 SHA-256 signature operation, disposable test-key path; no certified real-key claim |
| `src/stage_d_apkv2.bf` | Protected-region chunk digests, signer/attribute/signature block construction and final offsets |
| `src/stage_d_package.bf` | BF-owned plan, staged package/sign operation, artifact status and success routing |
| `tests/stage_d_resource_check.bf` | Independent binary XML/resource structural/literal checks |
| `tests/stage_d_zip_check.bf` | Independent local/central consistency, lengths, paths, CRC/alignment and EOCD/session checks |
| `tests/stage_d_crypto_check.bf` | Independent published primitive/DER/RSA KAT verification, malformed padding/key/length negatives |
| `tests/stage_d_signing_check.bf` | Independent scheme layout/digest-region/tamper decisions; external full-file verifier still mandatory |
| `tests/stage_d_mutations.bf` | BF-owned deterministic protected-region/offset/metadata mutations with exact case identities |
| `devtools/stage_d_build.bf` | Actual self-hosted BF package/build composition and artifact publication requests |
| `devtools/stage_d_smoke.bf` | Whole-stage independent check/device/ownership verdict ledger |
| `devtools/stage_d_bench.bf` | Equivalent-workload baseline/optimization measurement decisions |

Reuse only subsequently accepted Stage A/B native/ELF/artifact/source components and exact physical-IO contracts. Their current absence remains a dependency. Multiple BF modules need BF-owned composition or one reconciled integrated source; a host shell graph/linker is not supplied by this design.

## Complete inert inventory and groups

Present files: `docs/stage-d-full-draft.md`, `docs/stage-d-package-draft.md`, `docs/stage-d-crypto-draft.md`, `docs/stage-d-test-draft.md`, `config/stage-d/policy.json`, `fixtures/stage_d_full/acceptance.json`. Shared issues/archive are in [the C–E checkpoint](stages-cde-draft-checkpoint.md); navigation is updated in README/roadmap/status. No APK, certificate, key or expected full signature is fabricated.

Groups are D-CONTAINER (manifest/resource/CRC/ZIP and independent format sources/vectors), D-PRIMITIVES (SHA/bigint/DER/RSA and complete published KATs), D-SCHEME (APK v2/signing checker/mutations with independently chosen exact signing fixture), and D-END-TO-END (package/build/smoke/bench plus existing artifact/native/device path). Freeze every actual source/dependency and all independent first-pass expectations in a group before testing; couple groups where dependencies cannot be independently delivered. Full stage acceptance needs all groups, not just a hash primitive pass.

All D IDs retain actual DRAFTED **INCOMPLETE**, IMPLEMENTED **NO**, TESTED **NOT RUN**, OPTIMIZED **NO**, INTEGRATED **NO**. The current external debug APKs satisfy neither D04 nor D07. Stage A nesting/production-source and stable Android target failures remain open. D security infeasibility must produce a truthful unsupported production-signing result, not a conventional signer hidden behind BF framing.
