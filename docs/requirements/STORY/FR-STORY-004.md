---
id: FR-STORY-004
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: Forward playback through the snapshot cache must replay stored state rather than re-running Ink, preserving deterministic history.
---
When Advance() is called while _timelineIndex < _timeline.Count - 1 (i.e. replaying cached history), the snapshot at index+1 is restored instead of calling story.Continue().
