---
id: FR-CLIMAX-002
type: FR
area: CLIMAX
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: The auto-advance timer must not fire at the climax; rapid-skipping behavior is deliberately broken here so the player must make a conscious click to proceed.
---
ResetTimer() returns without starting a timer when IsClimaxPause is true, even if AutoAdvance is enabled.
