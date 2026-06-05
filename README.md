# skills

Reusable agent skills for coding, learning, and skill authoring.

This repository is a personal skill library built around small, composable skill folders. Each skill is designed to be easy to inspect, edit, and reuse.

## Goals

- keep skills concise and durable
- make new skills fast to scaffold
- support learning-oriented workflows, not just task execution
- keep repository conventions explicit and local

## Included skills

### `coding-coach`

Coaching-first coding tutor for:

- step-by-step explanations
- layered hints
- code review with a teaching bias
- deliberate practice
- persistent `.practice-map` study tracking

Entry point: [coding-coach/SKILL.md](coding-coach/SKILL.md)

### `skill-scaffold`

Repository-specific bootstrapper for creating new skills with the local structure and metadata conventions already applied.

Entry point: [skill-scaffold/SKILL.md](skill-scaffold/SKILL.md)

## Repository structure

```text
skills/
  AGENTS.md
  README.md
  LICENSE
  ROADMAP.md
  .github/
  coding-coach/
  skill-scaffold/
```

## Conventions

Repository-wide rules live in [AGENTS.md](AGENTS.md).

Highlights:

- each skill lives in a top-level folder
- each skill must have a `SKILL.md`
- `SKILL.md` frontmatter uses only `name` and `description`
- optional folders such as `agents/`, `references/`, `assets/`, and `scripts/` are added only when needed
- user-editable plain text is preferred over opaque generated formats

## Create a new skill

Use the scaffold script:

```powershell
pwsh -File .\skill-scaffold\scripts\new-skill.ps1 `
  -SkillName "my-skill" `
  -Description "Describe the skill. Use when the trigger conditions apply."
```

Optional flags:

- `-IncludeReferences`
- `-IncludeAssets`
- `-IncludeScripts`

Example:

```powershell
pwsh -File .\skill-scaffold\scripts\new-skill.ps1 `
  -SkillName "sql-coach" `
  -Description "Coach SQL learning and query practice. Use when the user wants step-by-step SQL help, exercises, or review." `
  -DisplayName "SQL Coach" `
  -ShortDescription "Coaching-first SQL tutor." `
  -DefaultPrompt "Teach SQL through hints, review, and deliberate practice." `
  -IncludeReferences
```

## Contributing

This repo is personal-first, but contributions and ideas are still useful.

Before adding or changing a skill:

1. Read [AGENTS.md](AGENTS.md).
2. Keep the skill narrow and triggerable.
3. Prefer references or templates over bloated `SKILL.md` files.
4. Keep assets and scripts only when they clearly earn their place.

See [ROADMAP.md](ROADMAP.md) for the current direction.

## License

[MIT](LICENSE)
