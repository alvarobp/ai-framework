#!/bin/bash

source .env

cat project-instructions.md additions-for-unattended.md | \
  claude -p && \
  aws s3 sync --acl public-read digests/ s3://alvarobp-digests/daily-digests/
