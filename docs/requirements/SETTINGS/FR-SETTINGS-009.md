---
id: FR-SETTINGS-009
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs"]
why: Settings must survive a page refresh; persisting on every change is the simplest way to guarantee this without a "save settings" button.
---
Every call to SettingsService.UpdateAsync() immediately serializes the current GameSettings to localStorage under the settings key.
