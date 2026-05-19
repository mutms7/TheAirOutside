// scenes/11-night-hallway.ink — Scene 11: "Humming" (~3 min)
//
// Pacing: slow-default.
// The motif-convergence scene. The janitor working an empty hallway,
// humming the song clearly — Motif 4 reappearance. Iris is also there,
// outside her suit, sitting on a bench listening. They have an arrangement
// they have never spoken about. Wren witnesses both at once.
//
// Texture (S): approach Iris / approach janitor / leave without speaking.

=== night_hallway ===
# scene: 11
# pacing: slow
# voice: modulated

-> arrival_evening


= arrival_evening
# bg: hallway-night
~ wren_in_suit = true
# char: wren neutral

The school after hours. The overhead fluorescents are off; the long maintenance lights run along the floor in a low cool line. The HUD-clock reads 7:48 PM.

Wren has come back for the social-studies binder Wren forgot in the locker. The locker is at the far end of the south corridor.

The south corridor is not empty.

-> the_humming


= the_humming
# audio: hummed-bar-janitor
~ song_state = 2
# motif: song-janitor

At the far end of the corridor, the janitor is working with a long-handled mop, slow circles on the tile floor. The cleaning cart is parked beside her.

She is humming.

She is humming clearly, not under her breath, because she is alone in the hallway and the building is quiet enough.

It is the song.

It is the same shape Wren hummed without meaning to, yesterday morning, under the suit's boot tune.

It is the song Wren's grandmother used to hum in a kitchen.

The hallway carries it well — old plaster, high ceilings, no other sound to compete with.

-> iris_is_there


= iris_is_there
# char: iris bare

Halfway down the corridor, on the bench against the wall, Iris is sitting.

Iris is not in a suit.

She is in plain clothes again — the same olive-gray cardigan, dark trousers. Her shoes are off and lined up under the bench. Her hands are folded in her lap. Her hair is back behind her ears.

She is listening.

She does not look at Wren when Wren rounds the corner.

The janitor does not look up.

They have not spoken to each other tonight. They will not speak to each other tonight.

The hum continues.

-> the_choice


= the_choice

Wren has stopped in the corridor, suit-cam down, HUD logging nothing in particular.

The locker is past Iris. To get to the locker, Wren has to walk past her.

+ [Walk over, quietly, and sit on the other end of Iris's bench.]
    -> path_iris
+ [Walk to the janitor — say something.]
    -> path_janitor
+ [Take the long way around to the locker. Do not break this.]
    -> path_witness


= path_iris

Wren walks slowly down the corridor.

The suit's gait coordination softens the step — even quieter than usual.

Iris does not turn her head. But her eyes shift the smallest amount, to the edge of her vision, where Wren is walking.

Wren reaches the bench. Sits at the far end of it, leaving the empty space between.

The hum is louder from here. The janitor's circle of mop motion is steady.

Iris does not say anything.

Wren does not say anything.

They sit there for the length of the hum's next four bars. Iris's hand on the bench between them is bare. The cut on the back of one finger is right there.

When the hum lifts into the bar Wren almost remembers from this morning, Iris's eyes close briefly. They open again.

The hum continues.

After a long minute, Wren gets up.

Iris does not turn. Wren does not look back.

Wren walks past the janitor to the locker. The janitor does not stop humming. The mop continues its circle.

-> after_hallway


= path_janitor

Wren walks down the corridor. Past Iris on the bench. Past the empty stretch of tile.

To where the janitor is mopping.

The janitor hears Wren coming. The hum pauses for a beat — a small held breath — then resumes.

Wren stops at a polite distance.

# speaker: hud
JANITOR (background voice — unmodulated): Evening.

She does not look up. She does not stop the mop.

Wren has not planned what to say. The voice modulator is on; the breath is composing.

# speaker: wren
The song. The song you're—

# speaker: wren
what's it called?

The hum stops.

The janitor lifts her head. She looks at Wren — at the visor, at the place Wren's face would be.

# speaker: hud
JANITOR: It does not have a name that I know.

# speaker: hud
JANITOR: I learned it from my mother.

A beat.

# speaker: hud
JANITOR: Have a good night, friend.

She goes back to mopping. The hum resumes, the same shape as before, no slower, no faster.

Wren walks to the locker.

Behind Wren, Iris has watched the whole exchange. Wren cannot tell what Iris is thinking.

-> after_hallway


= path_witness

Wren stands at the corner of the corridor a moment longer.

Then Wren walks the long way around — through the connecting corridor by the gym, the way Wren took the day Wren turned away from Iris at the window.

The hum follows for the first few meters of the connecting corridor, then thins out, then is gone.

Wren reaches the locker by the back route. The binder is still there, exactly where Wren left it.

Wren walks out of the school the way Wren came in.

The hum is not audible from the front entrance.

But Wren is carrying it in their head now. The bar of it. The shape.

-> after_hallway


= after_hallway

The walk home is cold.

The HUD does not have a tag for what just happened. It logs nothing of significance.

# speaker: hud
HOME in 12 minutes. Suit power 36%.

-> the_door
