# AI Framework

My personal repository to keep all content possible about how I use AI.

It could be any AI knowledge, practices, methodologies, prompts, patterns, etc

## Contents

- [**Prompts**](./prompts): Effective prompt templates and examples
- [**Docs**](./docs): AI engineering knowledge and best practices
  - [Agentic Coding](./docs/agentic-coding): AI-assisted development practices and frameworks
  - [AI Engineering](./docs/ai-engineering): Building and architecting AI systems
  - [Prompting](./docs/prompting): Prompt engineering techniques
- [**Projects**](./projects): Command-line automation tools
  - [Daily Digest](./projects/daily-digest): Daily content aggregation
  - [Newsletters Digest](./projects/newsletters-digest): Newsletter processing
  - [YouTube Summary](./projects/youtube-summary): Video transcript summarization

## Command-line Tool

The `run` script provides a command-line interface for managing daily digests, newsletter processing, and YouTube video summarization.

### Installation

1. Create an alias in your shell configuration pointing to the `run` script:
   ```bash
   alias ai='~/code/ai-framework/run'
   ```

### Usage

#### Interactive Mode
Run `ai` without arguments to open an interactive menu.

#### Command Line Usage
- `ai daily digest` - Generate daily digest
- `ai daily read` - Read existing daily digest
- `ai newsletters digest` - Generate newsletters digest
- `ai newsletters read` - Read existing newsletters digest
- `ai youtube <url>` - Summarize YouTube video from URL

### Bash Completion Setup

To enable tab completion for the `ai` command:

1. Source the completion script in your bash configuration:
   ```bash
   source ~/code/ai-framework/bash-completion.sh
   ```

2. Restart your terminal or run:
   ```bash
   source ~/.bashrc
   ```

#### Completion Features
- `ai <TAB>` → suggests `daily`, `newsletters`, and `youtube`
- `ai daily <TAB>` → suggests `digest` and `read`
- `ai newsletters <TAB>` → suggests `digest` and `read`
- `ai youtube <TAB>` → accepts YouTube URL

### Requirements

- [gum](https://github.com/charmbracelet/gum) - Required for the interactive interface
- Bash shell

## Purpose

Centralized hub for documenting and refining AI tool usage expertise.
