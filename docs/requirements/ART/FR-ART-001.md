---
id: FR-ART-001
type: FR
area: ART
provenance: code
status: unratified
verification: automated
tests: []
source: ["src/VisualNovel.Shared/Components/Background.razor"]
why: Background.razor must render a non-empty SVG element for any background tag the Ink script emits; a missing background leaves the stage blank.
---
Background.razor renders a non-empty SVG element when passed a recognized Background Id string; unrecognized ids fall back to a default (empty/sky) background without throwing.
