---
id: FR-SETTINGS-006
type: FR
area: SETTINGS
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SettingsTests.cs"]
source: ["src/VisualNovel.Shared/Services/SettingsService.cs", "src/VisualNovel.Shared/Components/Stage.razor"]
why: Reduce motion accommodates vestibular sensitivity; when on, all CSS fade transitions are skipped and advance is instantaneous.
---
ReduceMotion defaults to false; when true, TransitionAdvance() calls Story.Advance() directly without the TextFadeMs delay.
