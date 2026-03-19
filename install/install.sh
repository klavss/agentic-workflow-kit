#!/usr/bin/env bash
set -euo pipefail

PROFILE="full"
DRY_RUN=0
FORCE=0
NO_BACKUP=0
TARGET_HOME="$HOME"
BACKUP_DIR=""

usage() {
  cat <<USAGE
Usage: ./install/install.sh [options]

Options:
  --profile <minimal|core|full>  Install profile (default: full)
  --dry-run                       Show planned operations without writing
  --force                         Overwrite existing files without backup
  --no-backup                     Do not create backups (ignored when --force)
  --backup-dir <path>             Directory for backup copies (default: alongside file with .bak suffix)
  --target-home <path>            Install into alternate HOME root (for testing)
  --help                          Show this help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile) PROFILE="$2"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --force) FORCE=1; shift ;;
    --no-backup) NO_BACKUP=1; shift ;;
    --backup-dir) BACKUP_DIR="$2"; shift 2 ;;
    --target-home) TARGET_HOME="$2"; shift 2 ;;
    --help) usage; exit 0 ;;
    *) echo "Unknown arg: $1"; usage; exit 1 ;;
  esac
done

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROFILE_FILE="$ROOT/install/profiles/$PROFILE.txt"
[[ -f "$PROFILE_FILE" ]] || { echo "Missing profile: $PROFILE"; exit 1; }

DEST_SKILLS="$TARGET_HOME/.agents/skills"
DEST_FRAMEWORK="$TARGET_HOME/.agents/framework"
DEST_CODEX="$TARGET_HOME/.codex"

log() { echo "$*"; }

# Avoid backup filename collisions by preserving relative path within backup dir.
backup_path_for() {
  local dst="$1"
  local rel="${dst#/}"
  rel="${rel//\//__}"
  if [[ -n "$BACKUP_DIR" ]]; then
    echo "$BACKUP_DIR/${rel}.bak"
  else
    echo "${dst}.bak"
  fi
}

do_backup() {
  local dst="$1"
  [[ -e "$dst" ]] || return 0
  [[ $FORCE -eq 1 ]] && return 0
  [[ $NO_BACKUP -eq 1 ]] && return 0

  local backup_path
  backup_path="$(backup_path_for "$dst")"

  if [[ $DRY_RUN -eq 1 ]]; then
    log "DRY-RUN backup $dst -> $backup_path"
  else
    mkdir -p "$(dirname "$backup_path")"
    cp "$dst" "$backup_path"
  fi
}

copy_file() {
  local src="$1" dst="$2"
  [[ -f "$src" ]] || { echo "Source missing: $src"; exit 1; }
  do_backup "$dst"
  if [[ $DRY_RUN -eq 1 ]]; then
    log "DRY-RUN copy $src -> $dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

copy_tree_contents() {
  local src_dir="$1" dst_dir="$2"
  [[ -d "$src_dir" ]] || { echo "Source dir missing: $src_dir"; exit 1; }
  while IFS= read -r -d '' file; do
    local rel="${file#$src_dir/}"
    copy_file "$file" "$dst_dir/$rel"
  done < <(find "$src_dir" -type f -print0)
}

if [[ $DRY_RUN -eq 0 ]]; then
  mkdir -p "$DEST_SKILLS" "$DEST_FRAMEWORK" "$DEST_CODEX"
fi

while read -r skill; do
  [[ -z "$skill" ]] && continue
  copy_file "$ROOT/skills/$skill/SKILL.md" "$DEST_SKILLS/$skill/SKILL.md"
done < "$PROFILE_FILE"

copy_file "$ROOT/framework/Framework-Policy.md" "$DEST_FRAMEWORK/Framework-Policy.md"
copy_file "$ROOT/framework/Architecture-Map.md" "$DEST_FRAMEWORK/Architecture-Map.md"
copy_file "$ROOT/framework/ENVIRONMENT-SCOPE.md" "$DEST_FRAMEWORK/ENVIRONMENT-SCOPE.md"

copy_tree_contents "$ROOT/framework/artifacts" "$DEST_FRAMEWORK/artifacts"
copy_tree_contents "$ROOT/framework/governance" "$DEST_FRAMEWORK/governance"
copy_tree_contents "$ROOT/framework/scripts" "$DEST_FRAMEWORK/scripts"
copy_tree_contents "$ROOT/framework/examples" "$DEST_FRAMEWORK/examples"
copy_file "$ROOT/framework/scenarios/README.md" "$DEST_FRAMEWORK/scenarios/README.md"
copy_tree_contents "$ROOT/framework/scenarios/golden" "$DEST_FRAMEWORK/scenarios/golden"

copy_file "$ROOT/codex/AGENTS.md" "$DEST_CODEX/AGENTS.md"

log "Installed profile: $PROFILE"
log "Target HOME: $TARGET_HOME"
log "Run: $DEST_FRAMEWORK/scripts/lint_framework.sh $TARGET_HOME/.agents"
