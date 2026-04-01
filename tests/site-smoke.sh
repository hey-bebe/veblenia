#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
cd "$ROOT_DIR"
test -f .github/workflows/hugo.yaml
hugo build --gc --minify --destination "$TMP_DIR" --cacheDir /tmp/veblenia-hugo-cache
rg -q '<html lang=en-us>' "$TMP_DIR/index.html"
rg -q 'Veblenia' "$TMP_DIR/index.html"
rg -q 'Welcome to Veblenia' "$TMP_DIR/index.html"
rg -qv '<div class=site-description>' "$TMP_DIR/index.html"
rg -q 'href=/veblenia/>Veblenia</a>' "$TMP_DIR/index.html"
test -f "$TMP_DIR/about/index.html"
test -f "$TMP_DIR/contact/index.html"
test -f "$TMP_DIR/archive/index.html"
test -f "$TMP_DIR/posts/2026-04-01-welcome/index.html"
rg -q 'href=/veblenia/>Veblenia</a>' "$TMP_DIR/posts/2026-04-01-welcome/index.html"
rg -q 'About Veblenia' "$TMP_DIR/about/index.html"
rg -q 'institutions, norms, and the structures that shape ordinary life' "$TMP_DIR/about/index.html"
rg -q 'Contact' "$TMP_DIR/contact/index.html"
rg -q 'repository profile or site-linked channels for correspondence' "$TMP_DIR/contact/index.html"
rg -q 'Archive' "$TMP_DIR/archive/index.html"
rg -q 'Welcome to Veblenia' "$TMP_DIR/archive/index.html"
rg -q 'Apr 1, 2026' "$TMP_DIR/archive/index.html"
rg -q '/veblenia/posts/2026-04-01-welcome/' "$TMP_DIR/archive/index.html"
rg -q 'running notebook for short posts on institutions and related fragments' "$TMP_DIR/posts/2026-04-01-welcome/index.html"
rg -q '/veblenia/tags/housekeeping/' "$TMP_DIR/posts/2026-04-01-welcome/index.html"
rg -q '/veblenia/tags/notes/' "$TMP_DIR/posts/2026-04-01-welcome/index.html"
test -f "$TMP_DIR/tags/index.html"
test -f "$TMP_DIR/tags/housekeeping/index.html"
test -f "$TMP_DIR/tags/notes/index.html"
rg -q 'All tags' "$TMP_DIR/tags/index.html"
rg -q 'Tag: housekeeping' "$TMP_DIR/tags/housekeeping/index.html"
rg -q 'Welcome to Veblenia' "$TMP_DIR/tags/housekeeping/index.html"
rg -q 'description = ""' archetypes/default.md
rg -q 'tags = \[\]' archetypes/default.md
rg -q 'sort \$pages "Date" "asc"' layouts/archive/single.html

if [[ "${VEBLENIA_PHASE:-}" != "full" ]]; then
  exit 0
fi

# These menu links are expected to fail until the later page tasks land.
rg -q 'href=/veblenia/contact/' "$TMP_DIR/index.html"
rg -q 'href=/veblenia/tags/' "$TMP_DIR/index.html"
rg -q 'href=/veblenia/archive/' "$TMP_DIR/index.html"
rg -q 'href=/veblenia/about/' "$TMP_DIR/index.html"
rg -qv 'localhost:1313' "$TMP_DIR/index.html"
