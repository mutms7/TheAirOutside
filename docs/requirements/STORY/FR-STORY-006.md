---
id: FR-STORY-006
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: An empty name field in the prologue must not produce a nameless protagonist; "Wren" is the canonical default.
---
SetProtagonistName() coerces any null, empty, or whitespace-only input to "Wren" before writing the value to the protagonist_name Ink variable.
