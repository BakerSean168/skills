# skills

Personal skills repository for reusable Codex-style agent skills.

## Included skills

- `coding-coach`: coaching-first coding tutor with persistent `.practice-map` support
- `skill-scaffold`: repository-specific skill generator for bootstrapping new skills

## Repository structure

```text
skills/
  AGENTS.md
  coding-coach/
  skill-scaffold/
```

## Conventions

- Each skill lives in a top-level folder.
- Each skill must have a `SKILL.md`.
- Optional folders such as `agents/`, `references/`, `assets/`, and `scripts/` are added only when needed.
- Repository-wide rules live in `AGENTS.md`.

## Create a new skill

Use the scaffold script:

```powershell
pwsh -File .\skill-scaffold\scripts\new-skill.ps1 `
  -SkillName "my-skill" `
  -Description "Describe the skill. Use when the trigger conditions apply."
```

Add `-IncludeReferences`, `-IncludeAssets`, or `-IncludeScripts` only when the skill actually needs them.

## Current focus

This repository is currently centered on:

- creating durable skills
- keeping skill instructions concise
- making scaffolds editable and repo-specific
