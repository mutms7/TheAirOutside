---
id: FR-SETTINGS-001
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs"]
why: Auto-advance must be off by default so first-time players read at their own pace without needing to disable it.
---
AutoAdvance defaults to false; when true, the story advances automatically after AutoAdvanceDelay seconds if CanAdvance is true and no panel or pause menu is open.
