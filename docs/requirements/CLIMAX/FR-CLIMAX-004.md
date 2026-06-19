---
id: FR-CLIMAX-004
type: FR
area: CLIMAX
provenance: code
status: ratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/wwwroot/css/stage.css"]
why: The 8-second fade gives the text presence without demanding the player stop and stare; the half-opacity softens the instruction so it reads as an invitation.
---
The .climax__line element fades in via the CSS animation "climax-fade-in 8s ease forwards", reaching a final opacity of 0.55.
