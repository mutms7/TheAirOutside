// scenes/01-cold-open.ink — Scene 1: "Ants" (~5-7 min at slow default)
//
// Pacing: slow-default. No branches.
// Establishes:
//   - bedroom, suit cradle, the physical act of stepping into the suit
//   - HUD/suit-interface vocabulary (calendar, ping, pace, locator)
//   - voice-modulator as a real audio feature, not metaphor
//   - the morning rhythm of a suit-culture street
//   - Wren's quiet curiosity (the ant-hill watching beat)
//   - Tae's voice and her relationship to Wren via the ping
// Plants Motif 1 (ant hill, building) and Motif 4 (subliminal hum from Wren).

=== cold_open ===
# scene: 1
# pacing: slow
# voice: modulated

-> bedroom


= bedroom
# bg: bedroom-morning

Six fifty-three in the morning.

The light through the window is pale and thin.

Wren's room is quiet. The desk is tidy. The bed is made. On the desk: the homework Wren finished last night, the cover sheet aligned with the edge of the desk by habit.

In the corner, the suit stands open in its cradle, lit faintly from inside. The chest plate is hinged back. The leg sleeves are flexed open at the knees.

Waiting.

# sfx: bedroom-floor
Wren gets out of bed. The floor is cold under bare feet.

Wren crosses the room, raises one arm, and steps in.

# sfx: suit-seal
The chest plate closes with a soft thunk. The hip seal warms.

# sfx: suit-boot
# audio: corporate-ambient
The boot tune begins. Eight notes. Brand-neutral and friendly — the small chime they play at every approved waking transition.

# audio: hummed-bar-subliminal
~ song_state = 1
Underneath the boot tune, for one bar, Wren hums something different. A different shape. Barely audible.

Wren does not notice. The hum trails off mid-bar, the way a held breath releases.

Then it is gone.

# speaker: hud
GOOD MORNING, WREN. Suit power 98%. Calendar: HOMEROOM in 27 minutes. Weather: cloudy, rain by afternoon.

# speaker: hud
Three unread pings. Two from group chat. One from TAE VANCE — flagged warm.

Wren looks at the pings without opening them.

Wren turns the volume on the group chat down by a notch. Not muted. Just down.

-> leaving

= leaving

The house is quiet. The kitchen is clean. There is nothing in the fridge that Wren needs.

# sfx: door-soft
The front door closes behind Wren.

# bg: street-morning
# char: wren neutral

The morning street is quiet, the way it is most mornings — quiet inside the suits.

A woman in a service-class suit, gray and unadorned, pushes a wheeled cart toward the next intersection. She does not look up.

A kid in a yellow suit covered in dinosaur stickers runs past, satchel banging against the hip seal. The kid's HUD chimes once, low — late-warning ping. The kid keeps running.

Wren falls in with the foot traffic toward the school. The suit's gait coordination smooths their step — half a pace longer than Wren's body would manage on its own.

# speaker: hud
Pace: nominal. Step count: 248.

-> ant_hill

= ant_hill
# motif: ant-hill-building
~ ant_state = 1

On the curb, something moves.

The suit-cam picks it up — a soft auto-zoom, the way the cam does for movement in the path of the foot. The small reticle in the corner of the HUD lights up and narrows.

An ant hill. Small. Cone-shaped. The size of a fist.

Tiny grains of sand, stacked.

Wren slows.

-> watching

= watching

An ant comes out of the hill carrying a grain of something. Reaches the top. Sets it down.

Goes back in.

Another ant comes out, going the other way. With a different grain.

Wren has stopped walking.

# speaker: hud
Pace: stopped.

The auto-zoom holds.

The boot tune is over. The street is quiet inside the suit. Outside, somewhere a block away, a delivery vehicle makes a low sound and is gone.

An ant climbs up the side of the hill, slips, climbs again.

Wren watches it.

A beat longer than necessary.

A beat longer than that.

-> the_ping

= the_ping

# sfx: ping
# audio: ping-tae
# speaker: hud
INCOMING — TAE VANCE.

# speaker: tae
Wren? You good?

# speaker: tae
I've got your locator paused on a curb.

# speaker: tae
Suit acting up? I can ping the tech line.

# audio: voice-mod-warm
The voice-modulator warms the mic.

Wren takes a breath the suit will compose into something a half-pitch warmer than it actually is.

# speaker: wren
Yeah, I—

# speaker: wren
just—

# speaker: wren
on my way. Sorry.

# speaker: tae
You sure? You've been paused like ninety seconds.

# speaker: wren
Yeah. It's fine.

# speaker: tae
Okay. Well — hurry up! We're putting peach on you today. I found a really good one. Mint accents. You'll like it.

# sfx: ping-end

-> resume

= resume

Wren resumes walking.

The auto-zoom releases. The reticle fades.

The ant hill recedes behind them.

# speaker: hud
Pace: nominal.

The boot tune does not start again. The hum is gone.

The school comes into view a few blocks ahead — low building, suits filing in through the main doors in twos and threes.

# speaker: hud
HOMEROOM in 18 minutes.

-> homeroom
