---
id: FR-UI-008
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Dark-bg detection drives UI ink-color inversion so the TopBar and dialogue text remain readable over dark scene backgrounds.
---
IsDarkBackground is true when Theme is "dark", or when Background is one of: "bedroom-night", "hallway-night", "taes-room", "field-night", "field-clearing", "nurse-office-night".
