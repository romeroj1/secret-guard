#!/bin/sh
# Installs the hook globally by pointing git at this checkout's hooks/ directory.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
current=$(git config --global --get core.hooksPath || true)
if [ -n "$current" ] && [ "$current" != "$here/hooks" ]; then
  echo "core.hooksPath is already set to: $current" >&2
  echo "Not overwriting it. Merge the hooks by hand or ask your security team, then re-run." >&2
  exit 1
fi
command -v gitleaks >/dev/null 2>&1 || { echo "Install gitleaks first (brew install gitleaks)." >&2; exit 1; }
git config --global core.hooksPath "$here/hooks"
echo "Installed. Every repo on this machine now scans staged changes before commit."
echo "Remove with: git config --global --unset core.hooksPath"
