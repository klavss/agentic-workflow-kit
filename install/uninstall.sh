#!/usr/bin/env bash
set -euo pipefail

TARGET_HOME="$HOME"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-home) TARGET_HOME="$2"; shift 2 ;;
    --help)
      echo "Usage: ./install/uninstall.sh [--target-home <path>]"
      exit 0
      ;;
    *) echo "Unknown arg: $1"; exit 1 ;;
  esac
done

rm -rf "$TARGET_HOME/.agents/skills" "$TARGET_HOME/.agents/framework"
rm -f "$TARGET_HOME/.codex/AGENTS.md"
echo "Removed framework from: $TARGET_HOME"
