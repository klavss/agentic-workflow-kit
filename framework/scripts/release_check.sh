#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
err=0

version_line="$(grep -E '^current_version:' "$ROOT/framework/governance/VERSION.md" || true)"
version="${version_line#current_version: }"

if [[ -z "$version" ]]; then
  echo "Missing current_version in VERSION.md"
  exit 1
fi

if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version is not semver: $version"
  err=1
fi

grep -q "## ${version} - " "$ROOT/framework/governance/CHANGELOG.md" || {
  echo "CHANGELOG missing heading for version $version"
  err=1
}

grep -q "from_version:" "$ROOT/framework/governance/MIGRATION.md" || {
  echo "MIGRATION.md missing template fields"
  err=1
}

grep -q "Framework version: \`${version}\`" "$ROOT/framework/governance/COMPATIBILITY.md" || {
  echo "COMPATIBILITY.md not aligned to current version $version"
  err=1
}

[[ $err -eq 0 ]] && echo "Release check: PASS" || { echo "Release check: FAIL"; exit 1; }
