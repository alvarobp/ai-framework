# Daily Digest

Generates a web page artifact showing highlights based on my interests and objectives from daily digests I'm subscribed to.

Generated digests are automatically uploaded to and stored in an AWS S3 bucket for easy access and sharing.

## Run manually in Claude AI Projects

### Project setup

Set Project Instructions to [instructions.md](./instructions.md)
Upload [daily-digest-template.html](./daily-digest-template.html) to the project files.

### Usage

You can generate a new digest as easily as asking "Generate digest" in a new conversation.

## Run unattended from a shell

Requirements:
  - AWS CLI (authenticated with access to the S3 bucket)
  - Configure `.env` file with:
    - AWS credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)
    - S3 bucket configuration (`S3_BUCKET`, `S3_PATH`)

```shell
bash generate.sh
```

The script will generate the digest and automatically upload it to the configured S3 bucket. You can later read digests using:

```shell
bash read.sh
```

## HTML Template

I generated the template by running the prompt and then asking for refinements. Once the artifact looked good enough, I asked to generate the template with:

```
Generate an html code template to use in a prompt for making sure I can generate this artifact using same style, format and structure in the future.
```


