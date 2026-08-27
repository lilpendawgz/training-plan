#!/usr/bin/env bash
# Search second-brain/ for anything relevant to a keyword or phrase.
# Usage: search.sh "keyword or phrase"
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SB_DIR="$(dirname "$SCRIPT_DIR")"

if [ $# -lt 1 ]; then
  echo "Usage: $0 \"keyword or phrase\"" >&2
  exit 1
fi

QUERY="$1"

echo "=== topics/ ==="
grep -ril "$QUERY" "$SB_DIR/topics" --include="*.md" 2>/dev/null || echo "(none)"

echo
echo "=== library/ ==="
grep -ril "$QUERY" "$SB_DIR/library" --include="*.md" 2>/dev/null || echo "(none)"

echo
echo "=== inbox/ (unprocessed) ==="
grep -ril "$QUERY" "$SB_DIR/inbox" --include="*.md" 2>/dev/null || echo "(none)"
