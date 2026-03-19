#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
err=0

required_sections=("# Scenario:" "## trigger" "## expected_mode" "## expected_flow")

for f in "$ROOT"/framework/scenarios/golden/*.md; do
  [[ -f "$f" ]] || continue
  for s in "${required_sections[@]}"; do
    grep -q "$s" "$f" || { echo "Scenario missing '$s': $f"; err=1; }
  done
  grep -q 'delivery-orchestrator' "$f" || { echo "Scenario missing orchestrator in flow: $f"; err=1; }
done

[[ $err -eq 0 ]] && echo "Scenario validation: PASS" || { echo "Scenario validation: FAIL"; exit 1; }
