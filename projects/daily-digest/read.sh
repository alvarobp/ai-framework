#!/bin/bash

set -e

# Load environment variables if .env exists
if [ -f .env ]; then
    source .env
fi

echo "Fetching daily digests from AWS S3..."

# Get list of digest files from S3, sort by date (newest first), limit to 10
digests=$(aws s3 ls s3://${S3_BUCKET}/${S3_PATH}/ --recursive | \
    grep '\.html$' | \
    sort -k1,2 -r | \
    head -10 | \
    awk '{print $4}')

if [ -z "$digests" ]; then
    echo "No digests found in S3 bucket."
    exit 1
fi

# Build list of filenames for selection
digest_options=$(echo "$digests" | while IFS= read -r digest_path; do
    basename "$digest_path"
done)

# Use gum to let user select a digest
selected=$(echo "$digest_options" | gum choose --header "Select a daily digest to open:")

if [ -z "$selected" ]; then
    echo "No digest selected."
    exit 1
fi

# Find the corresponding S3 path by matching the selected filename
selected_path=$(echo "$digests" | grep "/${selected}$")

# Construct the public URL
public_url="https://${S3_BUCKET}.s3.amazonaws.com/$selected_path"

echo "Opening: $public_url"

# Open in browser (cross-platform)
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$public_url"
else
    xdg-open "$public_url"
fi