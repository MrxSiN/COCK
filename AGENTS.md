# AGENTS.md

Rules for AI assistants working in this repository.

## Project basics

- All repository-authored executable code is annotated eight-command Brainfuck (`.bf`). Do not add code in other languages.
- Read [docs/status.md](docs/status.md) before starting work. It is the source of truth for what is done and what is next.
- Stage A is incomplete. Never describe a component result as stage acceptance.
- Keep original evidence files unchanged. Add new evidence instead of rewriting old results.
- The project is over-engineered on purpose. Do not suggest deleting or merging superseded BF prototypes, frozen fixtures, evidence `.md`/`.json` pairs or later-stage drafts to make the repo smaller. Reviews should look for real defects, not for size.

## Commits

- Write commit messages in plain English that a newcomer can understand.
- Use Conventional Commits: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `chore:`.
- Subject line: under 72 characters, says what changed and why it matters.
- Body: explain the change in short sentences. Avoid internal jargon where a plain word works.
- **Do not add Claude, Anthropic or any AI assistant as an author or co-author.** No `Co-Authored-By: Claude ...` trailer and no "Generated with Claude Code" line.
- Exception: a commit that only adds or changes benchmark results may credit the tool that produced them.

## Pull requests

- Title: a short, plain-English summary of the outcome, for example "Add Android native compiler that builds the app library in one BF program". Never use the branch name as the title.
- Description must include:
  - **Summary**: two or three sentences on what the PR does and why.
  - **What changed**: a short bullet list of the main files or features.
  - **How it was tested**: what was run and on which device or environment.
  - **Known limits**: what still does not work.
- Write for a reader who has not followed the project. Explain abbreviations on first use.
- Do not add "Generated with Claude Code" or similar AI attribution to PR titles, descriptions or comments.

## Documentation

- When you add a doc under `docs/`, add it to [docs/README.md](docs/README.md) in the right table.
- Update the "Updated" date at the top of a doc when you change its content.

<!-- ecosystem-policy v1 (2026-11-13): identical in every MrxSiN first-party repository. Change it everywhere in one coordinated set of PRs, never in one repository alone. -->
## Ecosystem rules (v1)

Shared by MrxSiN's first-party repositories. Any other rule in this file that is stricter or more specific to this repository wins.

- **Who owns what.** XAX owns the semantic graph, verifier, compiler, ABIs, backends, targets and artifacts. BBC owns the Brainfuck frontend, BFX and Brainfuck-specific optimization. XAX-MCP owns MCP transport, tool schemas, sandbox and permissions. Dependencies point one way: consumers -> XAX-MCP / BBC -> XAX.
- **New production logic** is XAX, or Brainfuck + XAX, wherever the toolchains reach the target; this repository's own language rules say where that is. Existing code in other languages is tracked migration debt, not permission to add more. Declarative config, assets, fixtures and licenses are not code to convert.
- **Upstream first.** When a toolchain lacks something this repository needs: reproduce it on the toolchain's latest `main`, search its issues and PRs, then fix a small bounded gap with a PR in the owning repository, or open (or link) an issue for a large one and mark only the affected work blocked-upstream. No consumer-side shims, private toolchain forks or local toolchain patches.
- **Pins.** Build against exact toolchain commits, recorded in one machine-readable place. Check the toolchains' latest commits before nontrivial work; move a pin by reviewed PR once checks pass, and write down why when an older pin stays.
- **No hardcoding** of secrets, personal or machine paths, toolchain locations, obfuscated host names or version-specific offsets. Machine-local paths belong in your own `~/.claude/CLAUDE.md` or `CLAUDE.local.md`, never in the repository. Specification constants (opcodes, ABI layouts, protocol markers, security limits) are fine when named and documented.
- **Design.** SOLID, DRY, KISS, YAGNI, Law of Demeter, Boy Scout Rule and Separation of Concerns, applied with judgment. They never override correctness, safety, verified state or evidence quality.
- **Evidence.** Report only what actually ran: EXECUTED, MEASURED, NOT RUN or BLOCKED, with the reason. Emulator, Wine or qemu runs are not device runs. Never rewrite old evidence; add new.
- **Git.** Work on a branch from the default branch and land it by pull request; the owner reviews and merges. No force-push to the default branch, no history rewrites. No AI attribution in commits, PRs or comments; commits use the repository's git identity. PR titles say what changed in plain words.
- **Security.** Report vulnerabilities privately, never in a public issue. Never print or commit tokens.
<!-- /ecosystem-policy v1 -->
