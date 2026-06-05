# skills

Reusable agent skills for coding, learning, and skill authoring.

This repository follows the common `skills` ecosystem layout used by tools like `skills.sh`: a root-level `skills/` catalog containing one folder per skill, plus optional plugin marketplace metadata.

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

Entry point: [skills/coding-coach/SKILL.md](skills/coding-coach/SKILL.md)

### `skill-scaffold`

Repository-specific bootstrapper for creating new skills with the local structure and metadata conventions already applied.

Entry point: [skills/skill-scaffold/SKILL.md](skills/skill-scaffold/SKILL.md)

## Quickstart

Install from GitHub with the shared `skills` CLI:

```bash
npx skills@latest add BakerSean168/skills
```

You can then choose which skills to install and which coding agents to install them for.

## Repository structure

```text
skills/
  AGENTS.md
  README.md
  LICENSE
  ROADMAP.md
  .github/
  .claude-plugin/
  scripts/
  skills/
    coding-coach/
    skill-scaffold/
```

## Conventions

Repository-wide rules live in [AGENTS.md](AGENTS.md).

Highlights:

- each skill lives under the root `skills/` directory
- each skill must have a `SKILL.md`
- `SKILL.md` frontmatter uses only `name` and `description`
- optional folders such as `agents/`, `references/`, `assets/`, and `scripts/` are added only when needed
- user-editable plain text is preferred over opaque generated formats
- `.claude-plugin/marketplace.json` can advertise the catalog to plugin-oriented tooling

## Create a new skill

Use the scaffold script:

```powershell
pwsh -File .\skills\skill-scaffold\scripts\new-skill.ps1 `
  -SkillName "my-skill" `
  -Description "Describe the skill. Use when the trigger conditions apply."
```

Optional flags:

- `-IncludeReferences`
- `-IncludeAssets`
- `-IncludeScripts`

Example:

```powershell
pwsh -File .\skills\skill-scaffold\scripts\new-skill.ps1 `
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
2. Put the skill under [`skills/`](skills).
3. Keep the skill narrow and triggerable.
4. Prefer references or templates over bloated `SKILL.md` files.
5. Keep assets and scripts only when they clearly earn their place.

See [ROADMAP.md](ROADMAP.md) for the current direction.

## License

[MIT](LICENSE)
