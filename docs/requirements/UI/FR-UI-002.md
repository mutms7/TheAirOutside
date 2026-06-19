---
id: FR-UI-002
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Clicking the stage is the primary advance affordance; it must be blocked when any overlay is open to prevent accidental double-advances.
---
A click on the stage div calls AdvanceRequested(); AdvanceRequested() is a no-op if IsPrologueDone is false, a panel is open, the pause menu is open, a pending jump modal is showing, a prologue replay is open, CanAdvance is false, or a transition is in progress.
