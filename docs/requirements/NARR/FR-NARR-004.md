---
id: FR-NARR-004
type: FR
area: NARR
provenance: doc
status: unratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["ink/**/*.ink"]
why: The `pause: climax-window` tag fires the climax mechanic; if it appears more than once, the mechanic breaks on every subsequent occurrence.
---
The tag `pause: climax-window` appears in exactly one scene file (ink/scenes/13-step-outside.ink), once per gate3 branch (iris/stay/tae = 3 non-comment occurrences), so every playthrough path encounters the climax pause exactly once.
