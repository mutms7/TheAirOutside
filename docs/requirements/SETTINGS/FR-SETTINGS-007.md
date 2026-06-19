---
id: FR-SETTINGS-007
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs"]
why: Sensible volume defaults ensure the ambient music is audible without startling; UI-only until audio is wired.
---
MasterVolume defaults to 0.8, MusicVolume defaults to 0.7, SfxVolume defaults to 0.8; all three are range-bound 0.0–1.0.
