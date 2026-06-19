---
id: FR-STORY-007
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: VisitedScenes drives the scene picker's "visited" highlighting and the StoryMap's path trace.
---
When a tag `scene: N` (N an integer) is encountered, Scene is set to N and N is added to VisitedScenes.
