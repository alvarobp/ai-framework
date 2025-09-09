#!/bin/bash

source .env

echo "Generating digest..."
cat project-instructions.md additions-for-unattended.md | \
  claude -p && \
  echo "Uploading digest..." && \
  aws s3 sync --acl public-read digests/ s3://alvarobp-digests/daily-digests/
