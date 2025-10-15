#!/bin/bash

source .env

echo "Generating digest..."
cat instructions.md additions-for-unattended.md | \
  claude -p && \
  echo "Uploading digest..." && \
  aws s3 sync --acl public-read digests/ s3://${S3_BUCKET}/${S3_PATH}/
