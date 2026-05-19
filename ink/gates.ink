// gates.ink — major branch state variables.
// Each gate is set in a specific scene; later scenes read it for callbacks or variants.
// Empty string = "not yet visited / not yet decided."

// Gate 1 — Scene 4 (Lunch: The Lesser Suits)
// "silent"  — Wren says nothing
// "speak"   — Wren quietly defends or deflects on behalf of the mocked student
// "deflect" — Wren changes the subject without naming what is happening
// Cascades into Scene 8 (Classroom: Be More Honest) as a texture callback.
VAR gate1 = ""

// Gate 2 — Scene 5 (Hallway: Out)
// "approach" — Wren walks toward Iris without speaking
// "avoid"    — Wren passes by without acknowledging her
// Drives the Scene 6 (Evening: Charging) variant, plus lines in 8 and 12.
VAR gate2 = ""

// Gate 3 — Scene 12 (The Door)
// "iris" — Wren goes to find Iris (climax variant 13a)
// "stay" — Wren stays in their room alone   (climax variant 13b)
// "tae"  — Wren messages Tae who visits     (climax variant 13c, then 13b form)
VAR gate3 = ""

// Gate 4 — Scene 14 (Next Day: Bare)
// "stay_out"     — Wren returns to school fully without the suit
// "suit_no_deco" — Wren wears the suit but unadorned (Iris / Ozaki form)
// "re_enter"     — Wren returns fully suited and decorated, but seeing differently
// Drives the coda variant 15a / 15b / 15c.
VAR gate4 = ""
