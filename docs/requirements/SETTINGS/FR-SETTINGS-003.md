---
id: FR-SETTINGS-003
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs", "src/VisualNovel.Shared/Components/Settings.razor"]
why: Text fade creates the page-turn feel; 0ms disables it completely for players who prefer instant transitions.
---
TextFadeMs defaults to 150; the Settings UI exposes it as a range slider with min=0, max=500, step=25.
