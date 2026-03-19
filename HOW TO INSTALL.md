# HOW TO INSTALL

This file provides **copy/paste-ready installation commands** for:
1. Codex/Claude environment **Setup Script**
2. A normal terminal on your machine

---

## 1) Codex / Claude Setup Script (Environment Settings)

Paste this into the environment's **Setup Script** section:

```bash
#!/usr/bin/env bash
set -euo pipefail

cd /workspace/mygentic-environment

# install framework into environment home
./install/install.sh --profile full --no-backup

# verify installation
~/.agents/framework/scripts/lint_framework.sh ~/.agents
```

### Optional safer first run (dry-run)

```bash
#!/usr/bin/env bash
set -euo pipefail

cd /workspace/mygentic-environment
./install/install.sh --profile full --dry-run
```

---

## 2) Terminal install on your own device

After cloning this repo:

```bash
cd /path/to/mygentic-environment

# optional dry-run first
./install/install.sh --profile full --dry-run

# install
./install/install.sh --profile full

# verify
~/.agents/framework/scripts/lint_framework.sh ~/.agents
```

---

## Recommended default
For your normal environment setup, use `--profile full`.
Treat `minimal` and `core` as advanced/troubleshooting profiles.

## Profiles

- `minimal` → orchestrator + plan/review/drift essentials
- `core` → minimal + milestone execution + project bootstrap
- `full` → all skills, governance, release/security/dependency controls

Use a profile explicitly:

```bash
./install/install.sh --profile minimal
./install/install.sh --profile core
./install/install.sh --profile full
```

---

## Useful installer flags

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

---

## Uninstall

```bash
./install/uninstall.sh
```

Or uninstall from a specific home path:

```bash
./install/uninstall.sh --target-home /some/path
```

---

## Post-install quick checks

```bash
./framework/scripts/lint_framework.sh .
./framework/scripts/release_check.sh .
./framework/scripts/smoke_test_install.sh .
```
