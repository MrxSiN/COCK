# Stage D binary resources and APK container draft

**Design only.** The input is the exact accepted BF-generated file set plus a validated non-executable app/target plan and independently sealed byte identities. The BF packager derives entries from that set; no fixed sample APK, host path enumeration or externally generated manifest is a production template.

## Binary manifest and resource scope

Generate Android binary XML with checked little-endian resource chunk headers `(u16 type,u16 header_size,u32 total_size)`. The XML root is type `0x0003`; string pool `0x0001` has correct counts/offsets/UTF-8 encoding flag and length prefixes, NUL terminators and four-byte padding. Generate resource map `0x0180` entries consistent with the attribute-name string indexes. Namespace/start/end node chunk types are `0x0100`/`0x0101`/`0x0102`/`0x0103`; node and attribute layouts, type widths and total sizes must match pinned primary Android resource definitions. No arbitrary unaligned byte concatenation is accepted as binary XML.

Generate namespace, package/application/activity/intent/SDK nodes and correctly typed `hasCode`, `debuggable`, `exported`, `extractNativeLibs`, library metadata and capability-derived permissions. Package/application label/SDK/entry names derive from the plan. Validate exact Android attribute resource IDs against the pinned API definitions before native/resource golden freeze; guessed IDs block the emitter. Preserve string/attribute/reference consistency under changed app inputs and enforce min<=target in the verified matrix.

The first native-only target uses literal string labels and no icon/resource reference requiring `resources.arsc`. Emit only the actually required manifest/string-pool/resource-map chunks; do not include empty/fake resource tables. More resource types and references require complete resource encoder fixtures before their capability is admitted. Unknown resource features fail UNSUPPORTED_CAPABILITY, never silently replace a requested icon/theme with a sample. Stage E's resource extension has its own inventory.

Independent `aapt2`/APK inspectors decode the **BF-emitted** manifest/resources, not regenerate them. Compare decoded fields to inert expectations and inspect malformed offsets/string encodings/node lengths separately. External generated XML can be an independent reference observation but cannot supply production bytes or be copied as a template.

## Stored ZIP policy

Use stored entries initially, canonical unsigned normalized UTF-8 path order, unique paths and explicit UTF-8 flag. Each local record has the ZIP local-file signature, supported version, flags, method 0, reproducible configured DOS timestamp, exact CRC-32, checked compressed/uncompressed size, filename and valid extra fields. No data descriptor in this initial mode: BF computes sizes/CRCs from the same sealed bytes before emitting headers. Native bytes must be unchanged through both passes.

Central entries must agree exactly with local path/flags/method/CRC/sizes and point to the correct local header. EOCD must describe the single-disk central directory and all entries with no trailing junk. Use fixed timestamp 1980-01-01 00:00:00 for reproducible test fixtures unless a separately selected metadata policy changes identity; record that policy. DOS fields, 16-bit names/counts and 32-bit sizes/offsets have checked representation limits. Reject overflow explicitly; initial ZIP64, compression, encryption, split archives and arbitrary ZIP extension support are UNSUPPORTED, not a permanent project-size rule.

Stored native library **data** offsets must be 16-KiB aligned; ELF `PT_LOAD` alignment is checked separately. Other stored-entry alignment follows the selected verified Android policy, initially at least four bytes where required. Insert valid typed local extra-field padding and include its full lengths in layout; pin the exact padding-field format and independent bytes before source freeze. Raw unstructured extra bytes, unchecked extra-length wrap, alignment after signing and a matching filename with changed ELF are failures. Do not claim 16-KiB runtime compatibility from ZIP padding alone.

The actual set may include manifest, generated `.so`, declared non-executable assets and later registered resources/DEX. Inventory every executable entry and loading role; files with harmless extensions cannot smuggle executable code. Reject duplicate local/central paths, traversal/aliases, unexpected files, symlink-like entries and unsupported compression/load modes. Case/NFC equivalence must match the actual destination/Android interpretation.

## Finalization and signing order

BF validates source/native/file identities; emits aligned unsigned local entries; computes layout and signing digests; inserts the BF-produced APK Signing Block immediately before central directory; emits central directory and EOCD with adjusted actual central-directory offset; independently validates exact final bytes. No archive byte is patched or realigned after signing except inside a freshly generated full candidate whose signatures are recomputed.

All unsigned/final files stay in unique staging paths with BF-selected names. The unchanged artifact-output declaration/chunk/END/status grammar and independent producer/write/close/validator facts are required before publication. Failed or unknown signing/close/validation/cancellation never publishes a completed artifact. Preserve the prior validated package. Atomic rename/durability claims require actual same-filesystem evidence and proper sync outcomes; otherwise state unsupported/unknown.

Pin unsigned-content hash, final APK hash, source/generator/plan identity, certificate fingerprint, scheme/API/ABI policy and actual validator/device outcomes. Secrets are excluded. APK equality is a separate claim from native equality: externally signed debug containers may differ while extracted BF-generated `.so` must still match exactly. Production D requires every package/sign byte to be BF-authored, not just its native entry.
