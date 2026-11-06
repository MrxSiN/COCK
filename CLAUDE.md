# CLAUDE.md

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
