---
id: FR-STORY-005
type: FR
area: STORY
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Services/StoryService.cs"]
why: A scene jump must not carry over the previous scene's visual state; stale background/character/motif on a new knot would be a presentation bug.
---
JumpToKnot() clears Background, CharacterOnStage, Motif, Art, Audio, CurrentAudioCue, CurrentSfx, CurrentChoices, and the entire timeline before calling story.ChoosePathString(knot).
