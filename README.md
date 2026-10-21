# secret-guard

Stops tokens, keys and passwords from being committed. A global git `pre-commit` hook runs
[gitleaks](https://github.com/gitleaks/gitleaks) on the staged changes only.

## Install

    brew install gitleaks
    git clone <this repo> ~/secret-guard && ~/secret-guard/install.sh

`install.sh` sets `core.hooksPath` globally. It refuses to overwrite an existing value (company
policy may manage it). Undo: `git config --global --unset core.hooksPath`.

## Behaviour

- Scans staged additions only, redacts the secret in output.
- Uses the repo's own `.gitleaks.toml` if it has one, otherwise the shared one here.
- Still runs the repo's own `.git/hooks/pre-commit` afterwards (a global hooksPath would hide it).
- A blocked false positive: add a path or regex to the `[allowlist]`, don't use `--no-verify`.

## Limits

Hooks are local and can be skipped; fresh clones don't have them. The CI workflow
(`.github/workflows/secret-scan.yml`) is the backstop; copy it to repos that matter and make it a
required check. If a secret was ever pushed, rotate it: removing it from history is not enough.

## Company-specific rules

Put your internal token formats in `.gitleaks.toml` (see the commented example). Keep real
internal hostnames and secrets out of this public repo; use patterns, not values.
