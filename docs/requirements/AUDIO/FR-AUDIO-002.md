---
id: FR-AUDIO-002
type: FR
area: AUDIO
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor", "src/VisualNovel.Shared/Services/MusicService.cs"]
why: Mood transitions on every scene change keep the ambient music synchronized with the narrative without requiring per-line audio tags.
---
MusicService.SetSceneMoodAsync(scene) is called whenever Story.Scene changes to a new value; it is not called again until the scene number changes.
