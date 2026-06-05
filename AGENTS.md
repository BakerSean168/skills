# Skills Repo Guide

This repository stores agent skills as standalone folders.

## Layout

Each skill lives under the repository's `skills/` catalog directory:

```text
skills/
  <skill-name>/
    SKILL.md
    agents/
      openai.yaml
    references/
    assets/
    scripts/
```

Only `SKILL.md` is required. Create other folders only when they are useful.

## Naming

- Use lowercase kebab-case for skill folder names.
- Keep names short and action-oriented.
- Match the skill folder name with the `name` field in `SKILL.md`.
- Place every real skill inside `skills/<skill-name>/`.

## `SKILL.md`

Every skill must start with YAML frontmatter:

```yaml
---
name: skill-name
description: What the skill does. Use when specific triggers or contexts apply.
---
```

Rules:

- Include only `name` and `description` in frontmatter.
- Make the description concrete enough to trigger correctly.
- Put all "use when" guidance in the description, not in a body section.
- Keep the body procedural and concise.

## `agents/openai.yaml`

Add UI metadata for the skill:

```yaml
version: 1
agent:
  display_name: Human Name
  short_description: Short UI summary.
  default_prompt: Default coaching or execution stance for the skill.
```

Keep this file aligned with `SKILL.md`.

## References

Use `references/` for details that should not bloat `SKILL.md`.

Rules:

- Link reference files directly from `SKILL.md`.
- Keep references one hop away from `SKILL.md`.
- Split by mode, domain, or workflow when that reduces irrelevant context.

## Assets

Use `assets/` for reusable output templates or files that should be copied or adapted, not loaded into context by default.

## Scripts

Use `scripts/` only when a deterministic helper is genuinely useful. Do not add scripts for work that is better expressed as concise instructions.

## Editing policy

- Prefer plain text formats the user can edit directly.
- Preserve user-authored fields and sections when updating skill-owned files.
- Keep templates minimal and durable.
- Avoid time-sensitive guidance unless the skill is explicitly meant to manage current-state data.

## Review checklist

Before considering a skill ready, check:

- frontmatter is valid
- description has explicit triggers
- terminology is consistent
- references are linked from `SKILL.md`
- optional folders exist only if needed
- templates are user-editable
- the skill lives under `skills/`
