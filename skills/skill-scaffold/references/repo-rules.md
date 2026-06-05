# Repo Rules

This skill scaffolds new skills for the local `skills` repository.

Source of truth: [../../../AGENTS.md](../../../AGENTS.md)

## Required conventions

- One skill per folder under `skills/`
- Folder name matches `name` in `SKILL.md`
- Use lowercase kebab-case folder names
- Keep YAML frontmatter limited to `name` and `description`
- Add `agents/openai.yaml` for UI metadata

## Optional folders

Create optional folders only when they are justified:

- `references/`
- `assets/`
- `scripts/`

## Editing stance

- Keep starter files user-editable
- Prefer plain text templates
- Keep the scaffold minimal and remove unused placeholders
- Link reference files directly from `SKILL.md`
