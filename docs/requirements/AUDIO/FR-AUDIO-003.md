---
id: FR-AUDIO-003
type: FR
area: AUDIO
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Services/MusicService.cs"]
why: All audio calls are non-load-bearing; an audio subsystem failure must never block the story or crash the app.
---
Every MusicService method wraps its JS interop call in a try/catch that swallows all exceptions; no exception propagates to the caller.
