---
id: FR-STORY-010
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: IsEnded must be computed correctly so Stage.razor knows when to show the ending screen vs dialogue.
---
IsEnded is true when the story is loaded, CanAdvance is false, and IsAtChoice is false.
