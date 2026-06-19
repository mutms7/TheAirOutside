---
id: FR-CLIMAX-001
type: FR
area: CLIMAX
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: When IsClimaxPause is true the normal art/character/dialogue layers must be invisible so the player sees only the single invitational line against silence.
---
When IsClimaxPause is true, the background art, atmosphere, motion, motif, spot-art, and dialogue-wrap layers are not rendered; only the .climax div containing CurrentText is shown.
