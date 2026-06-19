---
id: FR-SETTINGS-004
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs", "src/VisualNovel.Shared/Components/Settings.razor"]
why: Six discrete stops prevent arbitrary fractional sizes that could break layout; the stop list is the canonical multiplier set.
---
TextSize defaults to 1.0; accepts only the discrete values {0.75, 1.0, 1.25, 1.5, 1.75, 2.0}; the Settings UI renders a 6-stop range slider (indices 0–5) mapping index to these values in order.
