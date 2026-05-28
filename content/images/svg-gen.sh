#!/bin/bash
file="rewriting.drawio"

mapfile -t pages < <(grep -oP '<diagram[^>]*\sname="\K[^"]+' "$file")

for i in "${!pages[@]}"; do
  safe="${pages[$i]//[^A-Za-z0-9._-]/_}"   # sanitize
  safe="${safe%_}"                          # drop trailing _
  drawio --export --format svg --page-index "$((i + 1))" \
         --output "${safe}.svg" "$file" 2>/dev/null
done
