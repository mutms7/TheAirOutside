---
id: FR-SAVE-004
type: FR
area: SAVE
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Services/SaveService.cs", "src/VisualNovel.Shared/Components/Stage.razor"]
why: Progress must be auto-saved on every story state change so a browser close never loses more than one line of progress.
---
SaveAsync is called on every StoryService.StateChanged event after IsPrologueDone is true, persisting the current VisitedScenes, Scene, PrologueDone flag, and protagonist_name variable.
