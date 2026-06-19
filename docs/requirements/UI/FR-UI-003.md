---
id: FR-UI-003
type: FR
area: UI
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Stage.razor"]
why: Forward jumps bypass unread scenes and their gate choices; the modal warns players that context will be missing without blocking them.
---
When HandleJump() receives a scene with Id greater than Story.Scene, a confirmation modal is shown; the jump executes only after the player clicks "Jump anyway". Jumps to the current or an earlier scene execute immediately without a modal.
