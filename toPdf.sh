#!/bin/bash

google-chrome \
  --headless \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --print-to-pdf="paper.pdf" \
   "http://localhost:3000"
