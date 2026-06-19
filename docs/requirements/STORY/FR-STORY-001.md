---
id: FR-STORY-001
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/StoryServiceTests.cs"]
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: The core narrative loop — each advance must fetch exactly one Ink line and strip whitespace so the UI never shows raw newlines.
---
When Advance() is called and the Ink story canContinue, CurrentText is set to story.Continue() with leading and trailing whitespace trimmed.
