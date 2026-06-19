---
id: FR-SETTINGS-005
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs", "src/VisualNovel.Shared/Components/Settings.razor"]
why: Theme drives both the stage's CSS class and the UI ink color inversion; must default to light so the app looks correct out of the box.
---
Theme defaults to "light"; accepts exactly "light" or "dark"; the Settings UI presents these as a segmented control with both options always visible.
