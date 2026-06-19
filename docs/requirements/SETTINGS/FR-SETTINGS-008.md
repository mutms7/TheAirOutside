---
id: FR-SETTINGS-008
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Components/Settings.razor"]
why: Reset must restore every setting to its initial value so players can recover from an accidental configuration without knowing the defaults.
---
"Reset to defaults" sets AutoAdvance=false, AutoAdvanceDelay=3.5, TextFadeMs=150, TextSize=1.0, MasterVolume=0.8, MusicVolume=0.7, SfxVolume=0.8, Theme="light", ReduceMotion=false; save progress and VisitedScenes are not affected.
