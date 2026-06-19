---
id: FR-CLIMAX-003
type: FR
area: CLIMAX
provenance: doc
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: The whole screen must be the advance affordance — no specific button, no "press SPACE" overlay. The click is the only required act.
---
A single click anywhere on the stage advances past the climax pause using the same AdvanceRequested() path as normal line advances; no dedicated climax-continue button exists.
