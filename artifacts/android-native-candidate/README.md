# BF-generated Android native candidates

Current candidate libraries use the repaired 220-byte callback. Each file is 16,640 bytes and retains the real source-derived guest, NativeActivity export, checked context/result ABI and dynamic `liblog` import. [Current evidence](../../docs/windows-device-evidence.md) records exact hashes and the [acceptance matrix](../../docs/acceptance.md) records remaining gates.

| Library | Application behavior on the tested Pixel 8 Pro |
| --- | --- |
| `space.so` | 32 additions emit space (`20`) |
| `bang.so` | 33 additions emit exclamation (`21`) |
| `heldout.so` | Earlier mixed/wrapping 289-command fixture emits space (`20`) |
| `fresh-h.so` | Fresh 79-command held-out fixture emits H (`48`) |

All four load through Bionic in verified externally debug-signed native-only APKs. Exact packaged/installed identities are checked. No conventional assembler/linker supplies these app instructions. The three prior guest regions are unchanged by the callback repair; original libraries remain recoverable from Git history.

These remain **candidates, not an accepted complete Stage A compiler or release**. Full same-interpreter nesting, exact-source/build authority and a usable BF build entry are unfinished. External debug packaging does not satisfy Stage D.
