---
id: NFR-STORY-001
type: NFR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: The snapshot must capture all display state so back/forward navigation produces bit-identical UI reconstruction.
---
Each StorySnapshot record contains exactly 13 fields: StateJson, CurrentText, Speaker, Motif, Art, Background, CharacterOnStage, Voice, Pacing, Audio, Scene, IsClimaxPause, and EndingTitle.
