# Repository Guidelines

This file provides guidance to Coding Agents when working with code in this repository.

## Repository Overview

This is a personal AI framework repository containing AI knowledge, practices, methodologies, prompts, and automation tools. The repository is organized into three main areas:

- **Prompts**: Prompt templates and examples
- **Docs**: AI engineering knowledge and best practices
- **Projects**: Command-line automation tools for content processing

## Project Architecture

### Command-Line Interface

The `run` script at the repository root provides a unified CLI for all automation tools. It supports both interactive mode (using `gum` for TUI) and direct command-line invocation.

**Entry point**: `/home/alvaro/code/ai-framework/run`

The script orchestrates three main tools:
1. Daily Digest - Aggregates daily content from subscribed sources
2. Newsletters Digest - Processes newsletter content into web artifacts
3. YouTube Summary - Downloads transcripts and generates summaries

### Digest Projects Structure

Each digest generation project in `projects/` follows a consistent pattern:

**Core files**:
- `generate.sh` - Main generation script
- `instructions.md` - Claude AI Project instructions
- `additions-for-unattended.md` - Unattended automation instructions
- `README.md` - Project documentation
- HTML template file - For web artifact generation

**Generation workflow**:
1. Source `.env` file for configuration (AWS credentials, S3 bucket settings)
2. Concatenate `instructions.md` and `additions-for-unattended.md`
3. Pipe to `claude -p` (Claude CLI in piped mode)
4. Upload generated artifacts to S3 using AWS CLI

**Key requirement**: All digest projects require AWS CLI authentication and `.env` configuration with:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `S3_BUCKET`
- `S3_PATH`

### YouTube Summary Tool

Different from digest projects - uses `yt-dlp` to download transcripts:
- Extracts video ID from URL (supports youtube.com and youtu.be formats)
- Downloads transcript to `tmp/transcript-{VIDEO_ID}.txt`
- Generates summary using Claude CLI: `claude -p "Summarize @transcript Give me the big takeaways"`

**Dependencies**: `yt-dlp`, `claude` CLI

## Git Commit Guidelines

When creating git commits in this repository:
- **DO NOT** add coding agents (including Claude, Claude Code, or any other AI assistants) as co-authors
- Use standard commit messages without AI attribution
- Do not append "Generated with [Claude Code]" or similar footers
- Keep commits clean and focused on the actual changes

## Common Commands

### Running the CLI

```bash
# Interactive mode (requires gum)
./run

# Direct commands
./run daily digest       # Generate daily digest
./run daily read         # Read existing daily digest
./run newsletters digest # Generate newsletters digest
./run newsletters read   # Read existing newsletters digest
./run youtube <url>      # Summarize YouTube video
```

### Individual Project Scripts

```bash
# From project directories
cd projects/daily-digest && ./generate.sh
cd projects/newsletters-digest && ./generate.sh
cd projects/youtube-summary && ./generate.sh <youtube_url>
```
