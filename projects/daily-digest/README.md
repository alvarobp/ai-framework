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
