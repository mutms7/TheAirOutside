---
id: FR-CLIMAX-005
type: FR
area: CLIMAX
provenance: doc
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor", "src/VisualNovel.Shared/wwwroot/js/audio.js"]
why: mechanics.md §Implementation note 1 specifies a pre-pause silence to make the transition felt as silence before the image appears, not as an abrupt UI change.
---
Before the climax pause renders, a ~3-second silence plays during which music stops and the UI transition is held; only after this silence does the .climax div appear and the ambient audio resume.
