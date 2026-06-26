#!/bin/bash
# Auto-commit and push workspace changes to origin after an agent session ends.

set -euo pipefail

cat > /dev/null

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$REPO_ROOT" ]; then
  exit 0
fi

cd "$REPO_ROOT"

if ! git remote get-url origin &>/dev/null; then
  exit 0
fi

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)"
if [ "$CURRENT_BRANCH" = "master" ]; then
  git branch -M main 2>/dev/null || true
  CURRENT_BRANCH="main"
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A

  if ! git diff --cached --quiet; then
    TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    git commit -m "chore: auto-push after agent session ${TIMESTAMP}" || true
  fi
fi

git push -u origin HEAD 2>/dev/null || true
exit 0
