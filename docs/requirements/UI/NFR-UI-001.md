---
id: NFR-UI-001
type: NFR
area: UI
provenance: doc
status: unratified
verification: manual
tests: []
source: []
why: Responsive breakpoints ensure the game is playable on tablets and small laptops without horizontal scrolling.
---
The stage layout adapts at two breakpoints: 900px (tablet) and 600px (mobile); at each breakpoint font sizes and layout proportions reflow to maintain readability.

Verification: Manual — open the game in Chrome DevTools responsive mode; at 899px and 599px confirm no horizontal overflow and dialogue text remains legible.
