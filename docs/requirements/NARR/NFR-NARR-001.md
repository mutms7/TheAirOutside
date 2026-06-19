---
id: NFR-NARR-001
type: NFR
area: NARR
provenance: doc
status: ratified
verification: automated
tests: ["tests/TheAirOutside.Tests/NarrTests.cs"]
source: ["ink/**/*.ink"]
why: Em-dashes were stripped in Phase 6; the auto-pause-comma pattern uses ellipses instead. Any em-dash reintroduced would violate the global style rule.
---
No player-visible prose line in any Ink source file under ink/ contains an em-dash character (U+2014, —); Ink `//` comment lines are exempt.
