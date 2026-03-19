# Compatibility Matrix (Framework-internal)

## Scope
This matrix tracks compatibility of **framework versions** with framework contracts and tooling behavior.

## Current
- Framework version: `1.1.0`
- Installer contract: `install/install.sh` supports `--profile`, `--dry-run`, `--target-home`, `--backup-dir`, `--no-backup`, `--force`.
- Validation contract: `lint_framework.sh` invokes skill + profile + scenario + release checks.
- Skill contract baseline: each skill requires YAML frontmatter (`name`, `description`), `# Purpose`, and single-purpose wording.

## Notes
This is not product/runtime compatibility; it is change-tracking for this personal framework's behavior contracts over time.
