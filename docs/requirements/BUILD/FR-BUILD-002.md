---
id: FR-BUILD-002
type: FR
area: BUILD
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["src/VisualNovel.Shared/wwwroot/story.json"]
why: The Ink runtime requires a valid inkVersion field to load the story; a corrupt or empty file would cause a silent blank-screen failure.
---
story.json parses as valid JSON and contains a top-level "inkVersion" integer field with a value greater than 0.
