---
id: FR-AUDIO-001
type: FR
area: AUDIO
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor", "src/VisualNovel.Shared/Services/MusicService.cs"]
why: The Web Audio API requires a user gesture before starting; deferring start() to the first stage click satisfies the browser autoplay policy.
---
MusicService.StartAsync() is called on the first advance click after prologue completion; subsequent advances do not call StartAsync() again.
