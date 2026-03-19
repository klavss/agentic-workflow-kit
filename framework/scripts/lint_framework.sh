#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
missing=0

required_skills=(
  delivery-orchestrator
  spec-to-plan
  checkpoint-review
  milestone-autopilot
  drift-audit
  project-init
  initiative-index
  milestone-scorecard
  release-gate
  dependency-governance
  security-baseline
  framework-governance
)

for s in "${required_skills[@]}"; do
  f="$ROOT/skills/$s/SKILL.md"
  [[ -f "$f" ]] || { echo "MISSING: $f"; missing=1; continue; }
  grep -q '^name:' "$f" || { echo "missing name in $f"; missing=1; }
  grep -q '^description:' "$f" || { echo "missing description in $f"; missing=1; }
done

for p in "$ROOT"/install/profiles/*.txt; do
  [[ -f "$p" ]] || continue
  while read -r skill; do
    [[ -z "$skill" ]] && continue
    [[ -f "$ROOT/skills/$skill/SKILL.md" ]] || { echo "Profile $p references missing skill: $skill"; missing=1; }
  done < "$p"
done

for f in framework/Framework-Policy.md framework/ENVIRONMENT-SCOPE.md framework/governance/VERSION.md framework/governance/CHANGELOG.md framework/governance/MIGRATION.md framework/governance/COMPATIBILITY.md framework/scenarios/README.md; do
  [[ -f "$ROOT/$f" ]] || { echo "MISSING: $ROOT/$f"; missing=1; }
done

[[ $missing -eq 0 ]] || { echo "Framework lint: FAIL"; exit 1; }

"$ROOT/framework/scripts/validate_skills.sh" "$ROOT"
"$ROOT/framework/scripts/validate_scenarios.sh" "$ROOT"
"$ROOT/framework/scripts/release_check.sh" "$ROOT"

echo "Framework lint: PASS"
