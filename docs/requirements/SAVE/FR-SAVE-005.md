---
id: FR-SAVE-005
type: FR
area: SAVE
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Services/SaveService.cs"]
why: "Play Again" must produce a fully clean state; leftover visited scenes from a prior run would corrupt the StoryMap path highlight.
---
ClearAsync() removes the progress key from localStorage and resets Current to a fresh SaveProgress with default values.
