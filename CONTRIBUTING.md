# Contributing

This repository stores small, focused agent skills.

## Before changing anything

1. Read [AGENTS.md](AGENTS.md).
2. Prefer concise, procedural instructions.
3. Keep trigger descriptions explicit.
4. Add optional folders only when they are genuinely needed.

## Adding a new skill

The fastest path is:

```powershell
pwsh -File .\skill-scaffold\scripts\new-skill.ps1 `
  -SkillName "my-skill" `
  -Description "Describe the skill. Use when the trigger conditions apply."
```

Then replace placeholders and remove anything the skill does not need.

## Editing an existing skill

- preserve user-editable text formats
- keep references linked directly from `SKILL.md`
- avoid adding bulky generic filler
- keep names and descriptions aligned with the real trigger conditions

## Pull requests

Good pull requests usually include:

- a clear reason for the skill or change
- a tight `description` field
- a concise `SKILL.md`
- only the optional folders that are justified
