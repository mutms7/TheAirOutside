---
id: FR-NARR-001
type: FR
area: NARR
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["src/VisualNovel.Shared/Services/SceneRegistry.cs"]
why: SceneRegistry is the canonical scene list; any discrepancy between it and the Ink script would break the scene picker and StoryMap.
---
SceneRegistry.Scenes contains exactly 15 entries with IDs 1–15, each with a unique Knot string and Title string.
