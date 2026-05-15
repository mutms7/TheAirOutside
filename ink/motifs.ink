// motifs.ink — the four recurring motif state machines.
// First appearance plants the motif mundanely; later appearances shift its meaning.
// Characters never narrate motif meaning aloud — Hummel principle (story-bible.md).

// Motif 1 — The ant hill
// 0 = unseen
// 1 = building, on the curb (S1)
// 2 = partially crushed under a tread, rebuilding (S7)
// 3 = eye-level, single ant carrying something three times its size (S15)
VAR ant_state = 0

// Motif 2 — The decoration sticker
// "none"      — Wren has not applied one yet
// "applied"   — freshly stuck to the shoulder (S2)
// "peeling"   — corner lifting; Wren smooths it down without examining (S6+)
// "in_palm"   — comes off with the suit; held in bare hand (S13)
// "window"    — stuck to a window in the coda (S15a)
// "drawer"    — placed in a drawer in the coda (S15b)
// "reapplied" — back on, but with a different feeling (S15c)
VAR sticker_state = "none"

// Motif 3 — Rain
// 0 = unheard
// 1 = muffled white noise heard from inside the suit (S3)
// 2 = seen on a windowpane while someone watches bare (S5)
// 3 = felt directly on bare skin, the screen nearly silent (S13)
VAR rain_state = 0

// Motif 4 — The hummed song
// 0 = unheard
// 1 = subliminal hum from Wren under the boot-up tune (S1)
// 2 = heard from the janitor clearly (S11; foreshadowed S2)
// 3 = remembered as the grandmother's tune (S6)
// 4 = hummed aloud by Wren outside the suit (S13)
VAR song_state = 0
