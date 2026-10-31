# Local code and data nested repair plan

2026-10-26 frozen before this third bounded interpreter draft. Preserve the two prior dispatch and loading candidates and all failed or cancelled results. Source decoding alone has not yet produced a complete full nested artifact. The remaining structural cost is the separation of a long simulated code segment from its simulated data tape, compounded at each interpreter level.

## Complete inventory

- `src/bf_in_bf_local.bf`: retain Orjan Johansen 2021 mbfi second implementation execution loop and load existing dbfi codes into its contiguous local code layout. Current simulated data sits adjacent to code rather than behind a growing marker prefix. Retain its own code shifting pointer implementation. No algorithm is authored in a foreign language.
- `src/trusted_source_codes.bf`: original separately attributed dbfi ASCII decoding prefix, followed by a BF serializer of codes one through eight and zero. No combination optimization or native code. This is the source reader part of the split trusted BF interpreter.
- `fixtures/local_kernel/vectors.json`: exact literal opcode encodings and existing sixteen semantic controls. Reuse the encoded request BF transport unchanged.
- This plan and post test local kernel evidence Markdown and JSON.

The author source and algorithm description are preserved outside the checkout from `https://esolangs.org/w/index.php?title=Mbfi&oldid=122007`. Attribute Orjan Johansen, Daniel B Cristofani and the case dispatch inspiration from Clive Gifford. The Esolang page identifies CC0; reused dbfi material retains its CC BY SA four attribution and terms. Preserve those distinctions rather than claiming the project authored the third party core.

## Execution and acceptance

This remains a split BF source interpreter: admitted actual normalized BF source goes through the BF source decoder, and the BF execution loop runs those exact instruction records. Record all source and record identities. Both nested execution loops must have identical BF source and execute the same unchanged complete Android native compiler. This internal eight code representation is not the sixteen code representation of the previous candidate and is not a new public ABI. Do not mix record formats. The outer seed compiles only the BF execution loop and never specializes on app input.

Finish all draft files and literal fixtures, snapshot, then run literal decoding, all sixteen one layer and identical nested controls, all two hundred fifty six bytes and zero EOF, BF decoder self hosted equality, direct versus one and two layer actual compiler A B and held out Q packets, negative normalized requests, independent BF byte comparisons and Android ELF identity. Use the declared six hundred second nested watchdog. No prefix, failed process, absent closure or matching partial native code passes. External physical closure and trusted source grammar remain explicit preconditions; no full source error or fuel conformance is claimed.
