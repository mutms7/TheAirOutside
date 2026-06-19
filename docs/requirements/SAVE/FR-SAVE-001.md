---
id: FR-SAVE-001
type: FR
area: SAVE
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SaveTests.cs"]
source: ["src/VisualNovel.Shared/Services/SaveService.cs"]
why: The localStorage key is a stable contract; changing it would lose all existing player saves.
---
Progress is persisted to and loaded from localStorage under the exact key "the-air-outside.progress".
