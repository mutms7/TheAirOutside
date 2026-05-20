// scenes/07-crushed.ink — Scene 7: "Crushed" (~3 min)
//
// Pacing: slow-default.
// Mirrors Scene 1 structurally — Wren walks to school — but the ant hill is
// now partially crushed under a suit-tread. Ants rebuild. Motif 1 reappearance:
// meaning shifts from wonder to obedience-after-damage. (Hummel principle:
// never narrated.)
//
// The framing acknowledges the previous evening's decoration choice in a
// single line so the player feels the carry-over.
//
// Texture choice (S): stop / hurry past / linger for a beat.

=== crushed ===
# scene: 7
# pacing: slow
# voice: modulated

-> morning_walk


= morning_walk
# bg: street-morning
~ wren_in_suit = true
# char: wren neutral

Seven-twelve in the morning. The sky is still gray. The street is wet but the rain has stopped.

I walk the same route as yesterday. The suit's coordination smooths the step. The boot tune is past. The HUD reads cool.

{
    - evening_decoration_choice == "left":
        The peach sticker is on the shoulder where Tae put it yesterday. The mint crescent still exactly where it was.
    - evening_decoration_choice == "removed":
        The shoulder plate is bare. The morning light catches the empty enamel-mount, and the seal-glow runs once around it absent-mindedly.
    - evening_decoration_choice == "swapped":
        The pale green crescent sits on the shoulder where the peach was. It is still a little crooked.
    - else:
        The shoulder has whatever it had last night.
}

# speaker: hud
Pace: nominal. Step count: 207.

-> the_curb


= the_curb

The curb comes up.

The same curb. The same place I stopped yesterday.

# motif: ant-hill-crushed
~ ant_state = 2

The ant hill is not the same.

A tread mark crosses it diagonally. A half-circle of pressed-flat sand, a fresh print from a suit boot. Maybe an hour old.

Most of the cone is gone. The shape is wrong now.

At the edge of the damage, three ants are working. Carrying small grains. Re-stacking.

The suit-cam picks them up. The reticle narrows.

+ [Stop.]
    -> path_stop
+ [Hurry past.]
    -> path_hurry
+ [Linger for a beat, then keep walking.]
    -> path_linger


= path_stop

I stop.

# speaker: hud
Pace: stopped.

An ant brings a grain up from below the damage line, climbs the sloped side, places it.

Goes back down.

I watch it happen four times.

# speaker: hud
HOMEROOM in 14 minutes.

The HUD nudge does not move me immediately.

I watch a fifth time. Then a sixth.

Then I start walking. The suit-cam releases the zoom.

-> after_curb


= path_hurry

I keep walking.

The suit-cam holds the reticle on the hill for half a second, then releases when my pace does not change.

# speaker: hud
Pace: nominal.

I register, distantly, that the hill is different. The thought does not surface fully. The school is six minutes away and Tae has already pinged twice this morning.

The ant hill recedes behind me.

-> after_curb


= path_linger

I slow.

Not stopping. Just slower for the length of three breaths.

An ant places a grain. I see it.

I do not stop.

# speaker: hud
Pace: 80%.

I resume the morning's pace.

The suit-cam releases the zoom. The reticle fades.

-> after_curb


= after_curb

The school comes into view ahead.

The boot tune is not playing. The street is quiet inside the suit.

# speaker: hud
HOMEROOM in 12 minutes.

-> classroom_ozaki
