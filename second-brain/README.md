# Second Brain

A personal knowledge repository: everything you read, watch, or listen to,
plus your own take on it. The goal isn't to archive content — you can
always re-Google an article. The goal is to never lose *your thinking
about* the content: what you agreed with, what you'd change, what you'd
actually do differently because of it.

If a note has no "My Take" or "How I'd Apply This" section filled in, it's
not finished — it's just a bookmark.

## How it's organized

```
second-brain/
├── inbox/              fast captures, unprocessed (link + 1-line reaction)
├── library/             processed notes, one per input, by type
│   ├── articles/
│   ├── books/
│   ├── videos-podcasts/
│   ├── social/
│   └── other/
├── topics/              Maps of Content — evergreen pages that link
│                        related notes together by idea, not by source type
├── templates/           quick-capture.md and full-note.md
└── scripts/
    └── new-capture.sh   creates a new dated note from a template
```

**inbox/** exists so capturing something never costs more than 30 seconds.
**library/** is where a capture becomes a real note — your summary, your
take, your applied takeaway. **topics/** is what makes this retrievable
later: instead of remembering *which article* said something, you browse
by the idea (`topics/deep-work.md`, `topics/marathon-training.md`,
`topics/negotiation.md`, ...) and every note that touched that idea is
linked there.

## Workflow

**1. Capture (as you consume something)**

In a Claude Code session on this repo, just say `/second-brain-add` (or
"add this to my second brain") and paste a URL, title, or your take — the
skill figures out the type, fetches metadata if needed, and writes the
right file. See `.claude/skills/second-brain-add/SKILL.md`.

Or do it by hand — run the script, or copy `templates/quick-capture.md`:

```
second-brain/scripts/new-capture.sh "Title of the thing" article https://source-url
```

This drops a file in `inbox/` with the source, date, and a spot for a
one-line reaction. That's the entire requirement in the moment — don't let
processing overhead stop you from capturing.

If something hits you hard and you have 10 minutes right then, skip the
inbox and write the full note directly into `library/<type>/` using
`templates/full-note.md`. Both paths are valid — capture depth should match
how much the thing is worth right now, not a fixed rule.

**2. Weekly review (promote inbox → library)**

Once a week, go through `inbox/`. For each item:
- Move it to the right `library/<type>/` folder
- Fill in Summary, **My Take**, and **How I'd Apply / Optimize This**
- Add tags
- Link it from any relevant `topics/*.md` MOC (create one if it doesn't
  exist yet)
- Delete it from `inbox/`

An inbox item that's sat for more than 2-3 weeks unprocessed is a signal
it either wasn't that important (delete it) or you're overcapturing
(recalibrate what's worth saving).

**3. Retrieval**

This is plain markdown, so:
- Browse `topics/` for anything you already have an opinion on
- `grep -ri "keyword" second-brain/` for full-text search
- `ls -t second-brain/library/**/*.md` for most recently processed
- Open the folder in Obsidian (or any markdown editor with backlinks) if
  you want a visual graph of how notes connect — the `[[note-name]]` links
  in templates are Obsidian-style wikilinks and work as plain text either
  way
- `git log --oneline --all -- second-brain/library` gives you a timeline
  of everything you've processed, in order
- `second-brain/scripts/search.sh "keyword"` searches topics, library, and
  inbox at once — this is also what Claude runs automatically before
  acting on requests where your prior thinking matters (see
  `../CLAUDE.md`)

## Tagging convention

Lowercase, kebab-case, in YAML frontmatter as a list. Prefer a handful of
reusable tags over a new one-off tag per note — the value is in tags
accumulating enough notes to be worth browsing.

## File naming

`library/<type>/YYYY-MM-DD-slug.md` — sortable by date, human-readable.
`inbox/` files use `YYYY-MM-DD-HHMM-slug.md` since same-day captures are
common.
