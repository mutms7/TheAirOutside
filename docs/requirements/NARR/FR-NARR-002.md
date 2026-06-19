---
id: FR-NARR-002
type: FR
area: NARR
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["src/VisualNovel.Shared/Services/SceneRegistry.cs"]
why: GateOptions must match the gates in the Ink script; a mismatch would cause the StoryMap to display wrong gate labels.
---
GateOptions.ByGate contains exactly four gates ("gate1", "gate2", "gate3", "gate4") with 3, 2, 3, and 3 choices respectively, corresponding to SceneRegistry scenes 4, 5, 12, and 14.
