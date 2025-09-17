#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <youtube_url> [output_file] [browser]"
    echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ transcript.txt"
    echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ transcript.txt brave"
    echo ""
    echo "Supported browsers: chrome, firefox, safari, edge, opera, brave"
    exit 1
fi

URL="$1"
OUTPUT_FILE="$2"
BROWSER="${3:-brave}"

# Function to try downloading with different methods
try_download() {
    local cmd="$1"
    local method="$2"

    echo "Trying method: $method"
    if $cmd --write-subs --write-auto-subs --sub-lang en --skip-download --sub-format vtt --output "$OUTPUT_FILE" "$URL" 2>/dev/null; then
        echo "✓ Success with $method"
        return 0
    else
        echo "✗ Failed with $method"
        return 1
    fi
}

if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="transcript.txt"
fi

echo "Downloading transcript from: $URL"
echo "Output file: $OUTPUT_FILE"
echo ""

# Function to clean transcript
clean_transcript() {
    local base_file="$1"

    # Find the actual VTT file that was downloaded
    local vtt_file="${base_file}.en.vtt"
    if [ ! -f "$vtt_file" ]; then
        vtt_file=$(find . -name "*.vtt" | head -1)
    fi

    if [ -f "$vtt_file" ]; then
        echo "Cleaning transcript from: $vtt_file"
        local clean_file="${base_file%.txt}_clean.txt"

        # Clean the VTT file
        sed -E '
            /^[0-9]{2}:[0-9]{2}:[0-9]{2}/d
            /^WEBVTT/d
            /^Kind:/d
            /^Language:/d
            /^$/d
            s/<[^>]*>//g
            s/align:start position:[0-9]+%//g
            s/&amp;/\&/g
            s/&lt;/</g
            s/&gt;/>/g
        ' "$vtt_file" | \
        # Remove duplicate lines and clean up
        awk '!seen[$0]++' | \
        # Remove lines that are just whitespace
        sed '/^[[:space:]]*$/d' > "$clean_file"

        echo "Clean transcript saved to: $clean_file"

        # Always replace original with clean version
        if [ -f "$clean_file" ]; then
            mv "$clean_file" "$base_file"
            echo "Clean transcript saved as: $base_file"
            # Remove the VTT file
            rm -f "$vtt_file"
            echo "Removed VTT file: $vtt_file"
        fi
    else
        echo "No VTT file found to clean"
    fi
}

# Try multiple methods in order of preference
if try_download "yt-dlp --cookies-from-browser $BROWSER" "cookies from $BROWSER"; then
    clean_transcript "$OUTPUT_FILE"
    exit 0
fi

echo ""
echo "Trying fallback methods..."

# Try with extractor args to bypass some restrictions
if try_download "yt-dlp --extractor-args youtube:player_client=web" "web player client"; then
    clean_transcript "$OUTPUT_FILE"
    exit 0
fi

# Try with different user agent
if try_download "yt-dlp --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'" "custom user agent"; then
    clean_transcript "$OUTPUT_FILE"
    exit 0
fi

# Try without any special options (sometimes works)
if try_download "yt-dlp" "basic method"; then
    clean_transcript "$OUTPUT_FILE"
    exit 0
fi

echo ""
echo "All methods failed. Possible solutions:"
echo "1. Make sure you're logged into YouTube in your $BROWSER browser"
echo "2. Try a different browser: ./$(basename $0) \"$URL\" \"$OUTPUT_FILE\" firefox"
echo "3. Check if the video has captions available"
echo "4. Update yt-dlp: pip install -U yt-dlp"

if [ $? -eq 0 ]; then
    echo "Transcript downloaded successfully to: $OUTPUT_FILE"
else
    echo "Failed to download transcript. Make sure yt-dlp is installed and the URL is valid."
    exit 1
fi