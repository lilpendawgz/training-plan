# Index

Start here.

## Topics (browse by idea)

See [`topics/`](topics/) — each file is a Map of Content for one theme,
linking every note that touched it. Create a new one whenever a third note
touches a theme that doesn't have a page yet.

- [topics/second-brain-methodology.md](topics/second-brain-methodology.md)

## Library (browse by source type)

- [library/articles/](library/articles/)
- [library/books/](library/books/)
- [library/videos-podcasts/](library/videos-podcasts/)
- [library/social/](library/social/)
- [library/other/](library/other/)

## Inbox

- [inbox/](inbox/) — unprocessed captures. Process weekly; see
  [README.md](README.md#2-weekly-review-promote-inbox--library) for the
  routine.

## Useful commands

```bash
# find anything mentioning a keyword
grep -ri "keyword" second-brain/

# most recently processed notes
ls -t second-brain/library/*/*.md | head

# how many items are sitting unprocessed
ls second-brain/inbox/ | wc -l
```
