---
id: FR-STORY-008
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: IsClimaxPause gates the climax mechanic in Stage.razor — the tag is the handshake between Ink and the UI layer.
---
When a tag `pause: climax-window` is encountered during tag processing, IsClimaxPause is set to true.
