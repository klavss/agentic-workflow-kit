#!/usr/bin/env bash
set -euo pipefail
SCAN_ROOT="${1:-/workspace}"
err=0

echo "Checking for accidental env-scope mirrors under: $SCAN_ROOT"
mapfile -t found < <(find "$SCAN_ROOT" -maxdepth 8 -type f \( -path '*/.agents/skills/*/SKILL.md' -o -path '*/.agents/framework/*' -o -path '*/.codex/AGENTS.md' \) 2>/dev/null || true)

if [[ ${#found[@]} -gt 0 ]]; then
  printf '%s\n' "${found[@]}"
  echo "Scope check: FAIL (env-scope mirrors detected inside scanned tree)"
  err=1
else
  echo "Scope check: PASS"
fi

exit $err
