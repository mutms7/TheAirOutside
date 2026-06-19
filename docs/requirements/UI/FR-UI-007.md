---
id: FR-UI-007
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: CSS class composition is the primary theming mechanism; all scene- and state-specific styling derives from these classes so no inline style overrides are needed.
---
The stage root div carries CSS classes composed from: voice-{Voice}, pacing-{Pacing}, scene-{Scene}, background-{Background}, audio-{Audio}, theme-{Theme}, "reduce-motion" (when ReduceMotion), "climax-pause" (when IsClimaxPause), "bg-dark"/"bg-light", and "stage--menu-open" (when pause menu is open).
