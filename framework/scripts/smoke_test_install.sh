#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
TMP_HOME="$(mktemp -d)"
trap 'rm -rf "$TMP_HOME"' EXIT

echo "Smoke test HOME: $TMP_HOME"

# minimal profile sanity
"$ROOT/install/install.sh" --profile minimal --target-home "$TMP_HOME"
for s in delivery-orchestrator spec-to-plan checkpoint-review drift-audit; do
  [[ -f "$TMP_HOME/.agents/skills/$s/SKILL.md" ]] || { echo "Missing minimal skill: $s"; exit 1; }
done
[[ -f "$TMP_HOME/.agents/framework/Framework-Policy.md" ]] || { echo "Missing policy after minimal install"; exit 1; }

# full profile + full lint
"$ROOT/install/install.sh" --profile full --target-home "$TMP_HOME" --force
"$TMP_HOME/.agents/framework/scripts/lint_framework.sh" "$TMP_HOME/.agents"

"$ROOT/install/uninstall.sh" --target-home "$TMP_HOME"
[[ ! -d "$TMP_HOME/.agents/skills" ]] || { echo "Uninstall failed: .agents/skills still exists"; exit 1; }
[[ ! -d "$TMP_HOME/.agents/framework" ]] || { echo "Uninstall failed: .agents/framework still exists"; exit 1; }
[[ ! -f "$TMP_HOME/.codex/AGENTS.md" ]] || { echo "Uninstall failed: AGENTS still exists"; exit 1; }

echo "Smoke test: PASS"
