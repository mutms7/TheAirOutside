---
id: FR-SAVE-002
type: FR
area: SAVE
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SaveTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs"]
why: The settings key is a stable contract; changing it would reset every player's preferences on next launch.
---
Settings are persisted to and loaded from localStorage under the exact key "the-air-outside.settings".
