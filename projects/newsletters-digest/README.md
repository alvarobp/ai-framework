# Newsletters Digest

Used in a Claude Project to generate a web page artifact.

## Project setup

Set Project Instructions to [instructions.md](./instructions.md)
Upload [newsletters-digest-template.html](./newsletters-digest-template.html) to the project files.

## Usage

You can generate a new digest as easily as asking "Generate digest" in a new conversation.

## Run unattended from a shell

Requirements:
  - AWS CLI (authenticated with access to s3://alvarobp-digests)
  - Set access key environment variables in `.env` by copying `.env.sample`

```shell
bash generate.sh
```

## HTML Template

I generated the template by running the prompt and then asking for refinements. Once the artifact looked good enough, I asked to generate the template with:

```
Generate an html code template to use in a prompt for making sure I can generate this artifact using same style, format and structure in the future.
```

## Known issues

- Digest does not work well with too many unread emails. It is better to use it with a two weeks period at most.
- Wrong total count of Newsletters
- Wrong sorting by date (older to newer)
