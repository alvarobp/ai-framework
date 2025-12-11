#!/bin/bash

source .env

TARGET_DATE="$1"

echo "Generating digest..."

if [ -n "$TARGET_DATE" ]; then
    # Prepend date override instructions when a specific date is provided
    echo "TARGET DATE: $TARGET_DATE

Use $TARGET_DATE as the date for this digest (not today).
Only read unread emails from the Daily Digests label that were received on $TARGET_DATE.
Use $TARGET_DATE for the filename (digests/$TARGET_DATE.html) and in all date references.

---
" | cat - instructions.md additions-for-unattended.md | claude -p
else
    cat instructions.md additions-for-unattended.md | claude -p
fi && \
  echo "Uploading digest..." && \
  aws s3 sync --acl public-read digests/ s3://${S3_BUCKET}/${S3_PATH}/
