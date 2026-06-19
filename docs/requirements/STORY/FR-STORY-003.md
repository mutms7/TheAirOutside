---
id: FR-STORY-003
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: Back navigation must restore the previous display state exactly — text, speaker, background, scene — so players can re-read without desync.
---
GoBack() decrements the timeline index by one, restores the snapshot at that index, and returns true; when already at index 0 it returns false without modifying state.
