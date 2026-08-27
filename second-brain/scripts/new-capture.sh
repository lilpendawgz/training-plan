#!/usr/bin/env bash
# Create a new quick-capture note in second-brain/inbox/ from the template.
#
# Usage:
#   new-capture.sh "Title of the thing" <type> [source_url]
#
# <type> is one of: article book video podcast social other
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SB_DIR="$(dirname "$SCRIPT_DIR")"

if [ $# -lt 2 ]; then
  echo "Usage: $0 \"Title\" <article|book|video|podcast|social|other> [source_url]" >&2
  exit 1
fi

TITLE="$1"
TYPE="$2"
SOURCE_URL="${3:-}"

SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
TIMESTAMP="$(date +%Y-%m-%d-%H%M)"
DATE_ONLY="$(date +%Y-%m-%d)"
OUT_FILE="$SB_DIR/inbox/${TIMESTAMP}-${SLUG}.md"

mkdir -p "$SB_DIR/inbox"

cat > "$OUT_FILE" <<EOF
---
title: $TITLE
type: $TYPE
source_url: $SOURCE_URL
author:
date_captured: $DATE_ONLY
tags: []
status: inbox
---

## One-line reaction


## Why I saved this

EOF

echo "Created $OUT_FILE"
