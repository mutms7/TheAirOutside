---
id: FR-UI-005
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Slow-pacing lines are motif moments designed to breathe; 1.7× gives them extra time under auto-advance without hard-blocking manual advance.
---
When AutoAdvance is enabled and Story.Pacing equals "slow", the auto-advance delay is AutoAdvanceDelay × 1.7 seconds; all other pacing values use AutoAdvanceDelay directly.
