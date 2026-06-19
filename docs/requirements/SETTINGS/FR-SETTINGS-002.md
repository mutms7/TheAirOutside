---
id: FR-SETTINGS-002
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs", "src/VisualNovel.Shared/Components/Settings.razor"]
why: The slider range and step size must match the default so Reset restores to a valid position on the slider track.
---
AutoAdvanceDelay defaults to 3.5 seconds; the Settings UI exposes it as a range slider with min=1.0, max=10.0, step=0.5.
