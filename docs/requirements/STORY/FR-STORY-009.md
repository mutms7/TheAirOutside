---
id: FR-STORY-009
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: EndingTitle drives the ending screen's title display; it must be captured from the Ink tag, not hardcoded.
---
When a tag `ending: <value>` is encountered, EndingTitle is set to the tag's value string.
