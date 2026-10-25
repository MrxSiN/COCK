# BF-generated Android native candidates

These are source-dependent candidate libraries, not accepted Android apps or release artifacts. See [implementation evidence](../../docs/android-native-implementation-evidence.md) and its JSON for exact provenance, inputs, hashes, tests and remaining work.

All three 16,640-byte ELF files contain the actual BF-generated NativeActivity callback and guest entry, with a real dynamic liblog import. Space and bang compute bytes 20 and 21 respectively. Held-out executes 128 subtractions followed by 160 additions, computes byte 20 and reports 289 commands.

Native instructions were generated only by the BF sources. No conventional assembler/linker supplied the runtime. CPU tests exercise identical callback/guest bytes under QEMU. The shared libraries themselves have not been loaded by Android Bionic on a working device. The complete source/offset/framing build graph and mandatory full nested proof remain unfinished.
