---
name: second-brain-add
description: Add an article, book, video, podcast, social post, or raw note to the second-brain knowledge base in second-brain/. Use when the user shares a URL/title to save, says "add this to my second brain", "save this article", "capture this note", or gives a link plus their reaction/take.
---

# Second Brain: Add Capture

Add whatever the user gives you (a URL, a title, a raw thought, or a full
take) into the `second-brain/` knowledge base in this repo, following the
workflow in `second-brain/README.md`.

## 1. Check for duplicates BEFORE doing anything else

Before fetching any URL, reading the source, or creating any file:

```bash
second-brain/scripts/search.sh "<url or a distinctive keyword from the title>"
```

Try both the URL (or its domain/slug) and a couple of words from the
title if one was given.

- **No match** → continue normally to step 2.
- **A match is found** → stop. Do not fetch the source, do not read
  further into it, do not create or edit any file. Tell the user what
  already exists (file path, its title, whether it's an inbox capture or
  a full note) and ask how they want to proceed — skip it, update the
  existing note instead, or add it anyway as a separate entry. Wait for
  their answer before taking any action.

## 2. Figure out capture depth from what's actually given

Don't ask for information the user hasn't offered unless it's truly
required.

- **Just a URL or title, nothing else** → fast **inbox** capture. Fill in
  what you know, leave the rest blank.
- **URL/title plus a real reaction or take** → write a **full note**
  directly into `library/<type>/`, skipping the inbox roundtrip.
- **Only a URL, no title** → fetch it (WebFetch) to get the title/author
  before writing anything. Don't ask the user to supply metadata you can
  fetch yourself.
- **A raw thought with no source** → treat as type `other`, no
  `source_url`.

## 3. Determine type

`article | book | video | podcast | social | other` — infer from the
domain (youtube.com → video, open.spotify.com/podcast context → podcast,
x.com/twitter.com/reddit.com → social) or context clues (a book title with
no URL → book). If genuinely ambiguous, default to `article` for web
content and `other` otherwise. Don't block on asking.

## 4. Fast path (inbox)

Run:

```
second-brain/scripts/new-capture.sh "<title>" <type> [source_url]
```

Then edit the created file in `second-brain/inbox/` to fill in
`author`/`tags` if known, and the "One-line reaction" / "Why I saved this"
sections with whatever the user actually said.

## 5. Full-note path (library)

Copy the structure of `second-brain/templates/full-note.md` into a new
file at `second-brain/library/<type>/YYYY-MM-DD-slug.md` (today's date,
kebab-case slug from the title). Fill in:

- Frontmatter: title, type, source_url, author, date_consumed,
  date_captured, tags, status: evergreen, rating (only if the user gave
  one)
- Summary: in your own words from the source or what the user told you
- **My Take** and **How I'd Apply / Optimize This**: the user's actual
  words/opinion. **Never invent an opinion, rating, or take on their
  behalf.** If they want a full note but haven't given you a take yet,
  ask them for it directly rather than fabricating one — this field is
  the entire point of the system, not optional filler.

## 6. Link into a topic

Check `second-brain/topics/` for an existing MOC that matches the
subject.

- If one exists, add a link to the new note under its `## Notes` section.
- If none exists and the subject looks likely to recur, propose creating
  one. Don't create topic pages speculatively for a single one-off note.

## 7. Commit and push

```
git add second-brain/
git commit -m "second-brain: capture <short title>"
git push origin main
```

Auto-committing captures is expected here — this session's stop hook
requires a clean working tree anyway, so leaving files staged for later
review isn't viable. If push fails, tell the user the capture is saved
locally but not pushed yet, rather than retrying destructively.

## 8. Report back

State the file path created and, for inbox captures, that it still needs
a take filled in during the next weekly review. Keep this to one or two
lines.

## Style rules

- Never fabricate the user's opinion, rating, or take — leave blank
  rather than guess.
- Keep frontmatter fields consistent with `templates/*.md`.
- Ask the minimum necessary; prefer capturing something imperfect now
  over interrogating the user before you'll save anything.
- Never skip the duplicate check, even when the user seems in a hurry —
  it's cheap (one grep) and prevents silent double-entries.
