---
id: FR-SAVE-003
type: FR
area: SAVE
provenance: code
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/SaveTests.cs"]
source: ["src/VisualNovel.Shared/Services/SaveService.cs"]
why: The serialized shape is the on-disk contract; any field rename or type change is a breaking migration for existing saves.
---
SaveProgress serializes exactly five fields: VisitedScenes (int[]), LastScene (int), LastUpdated (DateTime), PrologueDone (bool), and ProtagonistName (string, default "Wren").
