# Daily Digest

Generates a web page artifact showing highlights based on my interests and objectives from daily digests I'm subscribed to.

## Run manually in Claude AI Projects

### Project setup

Set Project Instructions to [project-instructions.md](./project-instructions.md)
Upload [daily-digest-template.html](./daily-digest-template.html) to the project files.

### Usage

You can generate a new digest as easily as asking "Generate digest" in a new conversation.

## Run unattended from a shell

Requirements:
  - AWS CLI (authenticated with access to s3://alvarobp-content)
  - Set access key environment variables in `.env` by copying `.env.sample`

```shell
bash generate.sh
```

## HTML Template

I generated the template by running the prompt and then asking for refinements. Once the artifact looked good enough, I asked to generate the template with:

```
Generate an html code template to use in a prompt for making sure I can generate this artifact using same style, format and structure in the future.
```

## Deploy as container on Gitlab Registry

To build the fully configured docker image we need to generate Claude Code and Gmail MCP Server credentials and then copy the config files that include them.

First, copy `.env.sample` to `.env` and fill with AWS credentials with access to S3 bucket `alvarobp-digests`.

Now, we'll follow instructions to get authentication credentials for Gmail MCP Server https://github.com/GongRzhe/Gmail-MCP-Server?tab=readme-ov-file#installing-manually

Put `gcp-oauth.keys.json` into `tmp/.gmail-mcp`.

Now to generate claude code credentials from scractch, we'll build the container without those config files first:

```shell
docker build . -t daily-digest
```

Then we run a container to generate config files within it:

```shell
docker run -it --rm --name daily-digest daily-digest bash
```

Once in, first authenticate claude code by running `claude` and doing `/login`.

Now, copy claude config files with:

```shell
mkdir -p tmp/.claude
docker cp daily-digest:/home/dailydigest/.claude/.credentials.json tmp/
docker cp daily-digest:/home/dailydigest/.claude.json tmp/
```

Now you are ready to run `./deploy.sh` which will build the final image and push it to the Gitlab docker registry.

