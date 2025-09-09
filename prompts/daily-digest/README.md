# Daily Digest

Used in a Claude Project to generate a web page artifact showing highlights based on my interests and objectives from daily digests I'm subscribed to.

## Project setup

Set Project Instructions to [project-instructions.md](./project-instructions.md)
Upload [daily-digest-template.html](./daily-digest-template.html) to the project files.

## Usage

You can generate a new digest as easily as asking "Generate digest" in a new conversation.

## HTML Template

I generated the template by running the prompt and then asking for refinements. Once the artifact looked good enough, I asked to generate the template with:

```
Generate an html code template to use in a prompt for making sure I can generate this artifact using same style, format and structure in the future.
```

## Known issues

- Digest does not work well with too many unread emails. It is better to use it with a two weeks period at most.
- Wrong total count of Newsletters
- Wrong sorting by date (older to newer)
