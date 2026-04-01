#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
cd "$ROOT_DIR"
test -f .github/workflows/hugo.yaml
hugo build --gc --minify --destination "$TMP_DIR" --cacheDir /tmp/veblenia-hugo-cache
rg -q 'Veblenia' "$TMP_DIR/index.html"
rg -q 'Notes and Fragments on Institutions' "$TMP_DIR/index.html"
# These menu links are expected to fail until the later page tasks land.
rg -q 'href=https://hey-bebe.github.io/veblenia/contact/' "$TMP_DIR/index.html"
rg -q 'href=https://hey-bebe.github.io/veblenia/tags/' "$TMP_DIR/index.html"
rg -q 'href=https://hey-bebe.github.io/veblenia/archive/' "$TMP_DIR/index.html"
rg -q 'href=https://hey-bebe.github.io/veblenia/about/' "$TMP_DIR/index.html"
# This language assertion is also forward-looking until the final site wiring is in place.
rg -q '<html lang=en-us>' "$TMP_DIR/index.html"
rg -qv 'localhost:1313' "$TMP_DIR/index.html"
