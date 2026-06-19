---
id: FR-UI-004
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Auto-advance must not fire while the player is reading the scene map, settings, or backlog — advancing behind a panel would be disorienting.
---
The auto-advance timer is cancelled and not restarted while _openPanel is not Panel.None, _showPauseMenu is true, or IsClimaxPause is true.
