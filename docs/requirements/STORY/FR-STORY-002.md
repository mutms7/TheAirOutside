---
id: FR-STORY-002
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: Choices must be surfaced immediately after Continue() so the stage can render choice buttons.
---
After each Advance(), CurrentChoices is populated from story.currentChoices; calling Choose(index) calls story.ChooseChoiceIndex(index) then Advance().
