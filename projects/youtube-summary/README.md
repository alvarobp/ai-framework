# YouTube Summary Generator

A tool to download YouTube video transcripts and generate AI-powered summaries using Claude.

## Requirements

- `yt-dlp` - For downloading YouTube transcripts
- `claude` CLI tool - For generating summaries

### Installing yt-dlp

```bash
# Using pip
pip install yt-dlp

# Using brew (macOS)
brew install yt-dlp

# Using apt (Ubuntu/Debian)
sudo apt install yt-dlp
```

## Usage

### Generate Summary

```bash
./generate.sh <youtube_url>
```

Example:
```bash
./generate.sh https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

### Download Transcript Only

```bash
./download-youtube-transcript.sh <youtube_url> [output_file] [browser]
```

Examples:
```bash
./download-youtube-transcript.sh https://www.youtube.com/watch?v=dQw4w9WgXcQ
./download-youtube-transcript.sh https://www.youtube.com/watch?v=dQw4w9WgXcQ transcript.txt
./download-youtube-transcript.sh https://www.youtube.com/watch?v=dQw4w9WgXcQ transcript.txt brave
```

## How it Works

1. **generate.sh** extracts the video ID from the YouTube URL
2. Calls **download-youtube-transcript.sh** to download the transcript to `tmp/transcript-videoID.txt`
3. Uses the Claude CLI to generate a summary with the prompt: "Summarize @<transcript-file> Give me the big takeaways"

## Output

- Transcripts are saved in the `tmp/` directory
- Summaries are displayed in the terminal