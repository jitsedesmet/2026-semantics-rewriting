#!/bin/bash

set -e

# Locate a Chrome/Chromium executable across platforms.
CHROME=""
for candidate in google-chrome google-chrome-stable chromium-browser chromium; do
  if command -v "$candidate" >/dev/null 2>&1; then
    CHROME="$candidate"
    break
  fi
done

if [ -z "$CHROME" ]; then
  echo "No Chrome/Chromium executable found. Install Google Chrome or Chromium." >&2
  exit 1
fi

# --virtual-time-budget forces Chrome to wait before printing, so the
# @font-face (Libertinus) requests against the localhost dev server have
# time to finish. Without it, --print-to-pdf can fire before the fonts
# load and silently fall back to a system font (wrong glyphs, wrong
# pagination).
"$CHROME" \
  --headless \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --virtual-time-budget=8000 \
  --print-to-pdf="paper.pdf" \
  "http://localhost:3000"
