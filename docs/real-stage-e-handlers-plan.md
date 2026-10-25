# Real Stage E handler implementation batch

> Checkpoint document. See [current status](status.md) and [physical-device evidence](windows-device-evidence.md). Results, hashes and environment paths below belong to their recorded checkpoint; use that Git checkpoint to reproduce old commands. Designs are not implementation or whole-stage acceptance.


This second executable batch completes the proposed `examples/stage_e/convert.bf` and `examples/stage_e/coordinates.bf` application source responsibilities. The converter uses raw BF input/EOF. The coordinate handler consumes the complete v1 event frame for handler 7/schema 2 and emits one provisional full action frame with READY, ODD or EVEN based on actual event/state data. It owns its app semantics; a gateway must not substitute a source-name lookup.

Complete both annotated BF programs and `fixtures/real_stage_e/acceptance.json` before running implementation tests; then freeze this exact source/data/plan set. The batch includes independent literal full-frame expected bytes, app-field/guard failures with no action, binary EOF converter checks, BF source admission/normalization, direct root execution, BF exact-byte comparisons and representative actual BF-in-BF execution. As the app ABI requires, envelope/correlation/exact physical input validation is a dispatcher precondition; the handler checks its own IDs/schema/state/event shape and final guard. A valid action is still provisional: no native UI renderer, dispatcher authority, installed app or state commit is fabricated.

Original source/expected fixtures remain unchanged. The first real B–E primitive batch has its own preceding immutable archive. All newly authored executable logic is BF, and externally executed commands only route/persist literal data and independent physical observations. No foreign code generator or conventional reference implementation is introduced.
