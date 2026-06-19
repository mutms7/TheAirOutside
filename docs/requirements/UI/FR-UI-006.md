---
id: FR-UI-006
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Text fade is a purely cosmetic transition; skipping it under ReduceMotion or when TextFadeMs=0 avoids any unnecessary delay for players who prefer immediacy.
---
When ReduceMotion is true or TextFadeMs equals 0, Story.Advance() is called directly without any delay; otherwise the stage waits TextFadeMs milliseconds before calling Advance() and updates the CSS transitioning class around the wait.
