#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
err=0

required_sections=("# Purpose")

for skill in "$ROOT"/skills/*/SKILL.md; do
  [[ -f "$skill" ]] || continue

  head -n 1 "$skill" | grep -q '^---$' || { echo "Invalid frontmatter start: $skill"; err=1; }
  grep -q '^name:' "$skill" || { echo "Missing name: $skill"; err=1; }
  grep -q '^description:' "$skill" || { echo "Missing description: $skill"; err=1; }

  for section in "${required_sections[@]}"; do
    grep -q "^${section}" "$skill" || { echo "Missing required section '${section}': $skill"; err=1; }
  done

  grep -qi 'single-purpose' "$skill" || { echo "Missing single-purpose boundary wording: $skill"; err=1; }
done

[[ $err -eq 0 ]] && echo "Skill validation: PASS" || { echo "Skill validation: FAIL"; exit 1; }
