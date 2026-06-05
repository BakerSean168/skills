---
name: skill-scaffold
description: Scaffold new skills for this repository with consistent folder layout, frontmatter, agent metadata, and optional references, assets, and scripts. Use when the user wants to create another skill in this repo, bootstrap a skill skeleton, normalize a new skill to the local repo conventions, or generate editable starter files instead of writing each skill from scratch.
---

# Skill Scaffold

Create new skills in this repository by following [../AGENTS.md](../AGENTS.md) and using the bundled scaffold script.

## Default workflow

1. Read [../AGENTS.md](../AGENTS.md) to confirm the local repo rules.
2. Derive a lowercase kebab-case skill id.
3. Decide which optional folders are actually needed: `references`, `assets`, `scripts`.
4. Run [scripts/new-skill.ps1](scripts/new-skill.ps1) to generate the skeleton.
5. Replace placeholders with concrete descriptions, prompts, and workflow instructions.
6. Remove any unused optional folders or placeholder files.

## Generate the scaffold

Run the script with the smallest useful set of resources.

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

## After generation

- Tighten the `description` so it clearly triggers on the right requests.
- Keep `SKILL.md` procedural and concise.
- Put bulky details in `references/`.
- Add scripts only when deterministic helpers are justified.
- Keep templates and assets user-editable.

## Placeholder policy

The scaffold is intentionally thin. Replace placeholders rather than expanding them into generic filler.

At minimum, fill in:

- `SKILL.md` frontmatter description
- `agents/openai.yaml`
- the workflow sections in `SKILL.md`

## Resource selection

- Add `references/` when the skill needs mode-specific or domain-specific detail.
- Add `assets/` when the skill needs reusable templates or output files.
- Add `scripts/` when a helper should be deterministic and reused.

Read [references/repo-rules.md](references/repo-rules.md) when you need the local conventions summarized. Reuse the templates in [assets/templates](assets/templates) rather than rewriting the same starter files.
