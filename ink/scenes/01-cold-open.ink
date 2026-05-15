// scenes/01-cold-open.ink — Scene 1: "Ants" (~3 min)
// Pacing: slow-default. No branches.
// Establishes: world, suit interface, Wren's voice-modulator, opening motifs.
//
// Tags read by the renderer:
//   # scene:   N            scene id
//   # pacing:  slow|normal  per-scene auto-advance speed
//   # bg:      <name>       background placeholder identifier
//   # char:    <name> <expr> character on stage + expression
//   # motif:   <name>-<state>  motif overlay
//   # audio:   <name>       ambient track
//   # sfx:     <name>       one-shot
//   # speaker: <name>       attributes the line; absent = narration
//   # voice:   modulated|bare  dialogue typography style

=== cold_open ===
# scene: 1
# pacing: slow
# voice: modulated

# bg: bedroom-morning
# sfx: suit-boot
The suit boots up. The chest seal warms.

# audio: corporate-ambient
A corporate ambient tune begins to play.

# audio: hummed-bar-subliminal
~ song_state = 1
Underneath, for one bar — barely a sound — Wren hums something else.

Then it's gone.

# bg: street-morning
# char: wren neutral
The street is quiet. Wren walks.

# motif: ant-hill-building
~ ant_state = 1
On the curb, an ant hill is being built.

Wren watches.

A beat longer than necessary.

# sfx: ping
# speaker: tae
Morning. You stopped walking — you good?

Wren composes their voice.

# speaker: wren
Yeah. Just—

on my way.

-> END
