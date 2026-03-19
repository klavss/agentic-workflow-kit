# mygentic-framework (portable agentic framework)

A reusable, environment-level framework for consistent agentic development across many repositories.

## What is included
- **Core skills**: orchestration, planning, review, milestone execution, drift control, repo bootstrap.
- **Advanced skills**: initiative indexing, scorecards, release gating, dependency governance, security baseline, framework governance.
- **Framework policy**: modes, routing, confidence contract, bypass policy.
- **Artifact templates**: INDEX, Status, Scorecard, Risks.
- **Governance**: version, changelog, migration notes, compatibility matrix.
- **Install tooling**: profile-based installer (`minimal`, `core`, `full`) + uninstall.

## Quickstart ("how to bash it")
```bash
# validate repo integrity
./framework/scripts/lint_framework.sh .

# dry-run install
./install/install.sh --profile full --dry-run

# install to current home
./install/install.sh --profile full

# validate installed environment
~/.agents/framework/scripts/lint_framework.sh ~/.agents
```

## Installer options
```bash
./install/install.sh --help
```
Key flags:
- `--profile minimal|core|full`
- `--dry-run`
- `--target-home <path>`
- `--backup-dir <path>`
- `--no-backup`
- `--force`

## Validation and testing
```bash
./framework/scripts/lint_framework.sh .
./framework/scripts/smoke_test_install.sh .
./framework/scripts/release_check.sh .
```

## Golden scenarios
Representative expected-flow fixtures live under:
- `framework/scenarios/golden/`

They are validated via `framework/scripts/validate_scenarios.sh`.

## CI
GitHub Actions run:
- framework lint (including skill, scenario, and release checks)
- dry-run installs (`full`, `minimal`)
- smoke test install/uninstall
- shellcheck on installer/scripts

## Release
See [`RELEASE.md`](RELEASE.md) for framework-repo release flow.

## Scope model
This framework is meant to live in environment scope:
- `~/.agents/skills/`
- `~/.agents/framework/`
- `~/.codex/AGENTS.md`

Do not copy framework files into project repos by default.
