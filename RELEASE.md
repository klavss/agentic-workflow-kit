# Release Process (Framework Repository)

## Scope
This process is for **releasing updates to this framework repo**, not product releases in downstream projects.

## Pre-release checklist
1. Run local validation:
   - `./framework/scripts/lint_framework.sh .`
   - `./framework/scripts/smoke_test_install.sh .`
   - `./framework/scripts/release_check.sh .`
2. Update version in `framework/governance/VERSION.md`.
3. Add release notes to `framework/governance/CHANGELOG.md`.
4. If behavior/contracts changed, update:
   - `framework/governance/MIGRATION.md`
   - `framework/governance/COMPATIBILITY.md`
5. Ensure installer help and README quickstart are accurate.

## Tagging
- Use semantic version tags: `vMAJOR.MINOR.PATCH`.

## Post-release sanity
- Reinstall from clean environment using `--profile full`.
- Re-run lint after installation.
