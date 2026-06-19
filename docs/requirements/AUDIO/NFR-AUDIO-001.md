---
id: NFR-AUDIO-001
type: NFR
area: AUDIO
provenance: doc
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["src/VisualNovel.Shared/wwwroot/**"]
why: A story about masks removing them must not itself hide behind AI-generated or pre-recorded assets; procedural generation is the only form of audio that ships.
---
No audio files (mp3, ogg, wav, flac, m4a, aac, opus) exist anywhere under src/VisualNovel.Shared/wwwroot/ or src/VisualNovel.Web/wwwroot/.
