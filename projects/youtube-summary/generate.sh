#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <youtube_url>" >&2
    echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ" >&2
    exit 1
fi

URL="$1"

# Extract video ID from URL (support both youtube.com and youtu.be formats)
VIDEO_ID=$(echo "$URL" | sed -n -e 's/.*[?&]v=\([^&]*\).*/\1/p' -e 's/.*youtu\.be\/\([^?]*\).*/\1/p')
if [ -z "$VIDEO_ID" ]; then
    echo "Error: Could not extract video ID from URL: $URL" >&2
    echo "Supported formats:" >&2
    echo "  - https://www.youtube.com/watch?v=VIDEO_ID" >&2
    echo "  - https://youtu.be/VIDEO_ID" >&2
    exit 1
fi

# Create tmp directory if it doesn't exist
mkdir -p tmp

TRANSCRIPT_FILE="tmp/transcript-${VIDEO_ID}.txt"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Download transcript (suppress all output)
if ! "$SCRIPT_DIR/download-youtube-transcript.sh" "$URL" "$TRANSCRIPT_FILE" >/dev/null 2>&1; then
    echo "Error: Failed to download transcript" >&2
    exit 1
fi

# Check if transcript file exists and has content
if [ ! -f "$TRANSCRIPT_FILE" ] || [ ! -s "$TRANSCRIPT_FILE" ]; then
    echo "Error: Transcript file is empty or does not exist" >&2
    exit 1
fi

# Generate summary using claude (only output goes to stdout)
claude -p "Summarize @$TRANSCRIPT_FILE Give me the big takeaways"