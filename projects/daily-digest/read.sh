#!/bin/bash

set -e

# Load environment variables if .env exists
if [ -f .env ]; then
    source .env
fi

echo "Fetching daily digests from AWS S3..."

# Get list of digest files from S3, sort by date (newest first), limit to 10
digests=$(aws s3 ls s3://alvarobp-digests/daily-digests/ --recursive | \
    grep '\.html$' | \
    sort -k1,2 -r | \
    head -10 | \
    awk '{print $4}')

if [ -z "$digests" ]; then
    echo "No digests found in S3 bucket."
    exit 1
fi

# Prepare the list for gum with readable names (extract date from filename)
digest_options=""
declare -A digest_map

while IFS= read -r digest_path; do
    # Extract filename from path
    filename=$(basename "$digest_path")
    
    # Try to extract date from filename (assuming format contains date)
    # This will show the filename as the option
    readable_name="$filename"
    
    digest_options+="$readable_name"$'\n'
    digest_map["$readable_name"]="$digest_path"
done <<< "$digests"

# Use gum to let user select a digest
selected=$(echo -n "$digest_options" | gum choose --header "Select a daily digest to open:")

if [ -z "$selected" ]; then
    echo "No digest selected."
    exit 1
fi

# Get the corresponding S3 path
selected_path="${digest_map[$selected]}"

# Construct the public URL
public_url="https://alvarobp-digests.s3.amazonaws.com/$selected_path"

echo "Opening: $public_url"

# Open in browser
xdg-open "$public_url"