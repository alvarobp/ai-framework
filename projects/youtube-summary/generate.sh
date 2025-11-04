#!/bin/bash

usage() {
    cat <<EOF >&2
Usage: $(basename "$0") [--codex] <youtube_url>
  --codex    Use the Codex CLI instead of Claude Code

Example:
  $(basename "$0") https://www.youtube.com/watch?v=dQw4w9WgXcQ
  $(basename "$0") --codex https://youtu.be/dQw4w9WgXcQ
EOF
}

CLI_TOOL="claude"
URL=""

while [ $# -gt 0 ]; do
    case "$1" in
        --codex)
            CLI_TOOL="codex"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -*)
            echo "Error: Unknown option: $1" >&2
            usage
            exit 1
            ;;
        *)
            if [ -n "$URL" ]; then
                echo "Error: Multiple URLs provided." >&2
                usage
                exit 1
            fi
            URL="$1"
            shift
            ;;
    esac
done

if [ -z "$URL" ]; then
    usage
    exit 1
fi

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

# Generate summary using the selected CLI tool (only output goes to stdout)
read -r -d '' SUMMARY_PROMPT <<EOF || true
Summarize @$TRANSCRIPT_FILE into a concise, readable Markdown report.
- Add a "Key Takeaways" section with short bullet points.
- Include a "Notable Quotes" section only when there are standout lines.
- Keep the tone neutral and informative.
- Do not mention the transcript file or that you received a file input.
EOF

if ! command -v "$CLI_TOOL" >/dev/null 2>&1; then
    echo "Error: Required CLI tool '$CLI_TOOL' is not installed or not in PATH" >&2
    exit 1
fi

case "$CLI_TOOL" in
    claude)
        claude -p "$SUMMARY_PROMPT"
        ;;
    codex)
        TMP_OUTPUT=$(mktemp -t codex-summary-XXXXXX 2>/dev/null)
        TMP_LOG=$(mktemp -t codex-summary-log-XXXXXX 2>/dev/null)
        if [ -z "$TMP_OUTPUT" ] || [ -z "$TMP_LOG" ]; then
            echo "Error: Failed to create temporary files for Codex output" >&2
            rm -f "$TMP_OUTPUT" "$TMP_LOG"
            exit 1
        fi

        if ! codex exec --output-last-message "$TMP_OUTPUT" "$SUMMARY_PROMPT" >"$TMP_LOG" 2>&1; then
            cat "$TMP_LOG" >&2
            rm -f "$TMP_OUTPUT" "$TMP_LOG"
            exit 1
        fi

        cat "$TMP_OUTPUT"
        rm -f "$TMP_OUTPUT" "$TMP_LOG"
        ;;
    *)
        echo "Error: Unsupported CLI tool '$CLI_TOOL'" >&2
        exit 1
        ;;
esac
