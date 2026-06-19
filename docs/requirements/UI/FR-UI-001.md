---
id: FR-UI-001
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: The prologue must gate the main stage so players set their name before the Ink protagonist_name variable is needed.
---
NameInput is rendered (and the main stage is hidden) when IsPrologueDone is false and Scene equals 0; once the prologue completes, the main stage becomes visible.
