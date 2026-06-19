---
id: NFR-SAVE-001
type: NFR
area: SAVE
provenance: code
status: unratified
verification: manual
tests: []
source: ["src/VisualNovel.Shared/Services/SaveService.cs"]
why: localStorage can be full or unavailable in private browsing; audio must not crash silently over a save failure.
---
Save and load failures (localStorage quota exceeded, unavailable, or parse error) are silently swallowed; the game continues running without displaying an error.

Verification: Manual — open the app in a browser with localStorage disabled (Content Settings → Block), play through scene 1, and confirm no error is surfaced and the story advances normally.
