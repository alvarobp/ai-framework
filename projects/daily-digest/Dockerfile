FROM node:20

# Set timezone
ARG TZ=UTC
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    awscli \
    && rm -rf /var/lib/apt/lists/*

# Set Claude Code version
ARG CLAUDE_CODE_VERSION=latest

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

# Create non-root user
RUN useradd -m -s /bin/bash dailydigest
USER dailydigest
WORKDIR /home/dailydigest

# Copy claude settings and credentials
RUN mkdir -p /home/dailydigest/.claude
COPY --chown=dailydigest:dailydigest tmp/.claude/.credentials.json /home/dailydigest/.claude/.credentials.json
COPY --chown=dailydigest:dailydigest tmp/.claude.json /home/dailydigest/

# Copy gmail-mcp-server settings and credentials
RUN mkdir -p /home/dailydigest/.gmail-mcp
COPY --chown=dailydigest:dailydigest tmp/.gmail-mcp/gcp-oauth.keys.json /home/dailydigest/.gmail-mcp/

# Copy .env file including AWS credentials
COPY --chown=dailydigest:dailydigest .env /home/dailydigest/.env

# Copy project files
COPY --chown=dailydigest:dailydigest . /home/dailydigest/daily-digest/

# Set working directory to the project
WORKDIR /home/dailydigest/daily-digest

# Ensure clean state
RUN mkdir -p digests
RUN rm -rf tmp digests/*.html

# Default command
CMD ["./generate.sh"]
