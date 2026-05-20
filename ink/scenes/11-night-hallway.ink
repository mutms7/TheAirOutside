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

I have come back for the social-studies binder I forgot in the locker. The locker is at the far end of the south corridor.

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

It is the same shape I hummed without meaning to, yesterday morning, under the suit's boot tune.

It is the song my grandmother used to hum in a kitchen.

The hallway carries it well. Old plaster, high ceilings, no other sound to compete with.

-> iris_is_there


= iris_is_there
# char: iris bare

Halfway down the corridor, on the bench against the wall, Iris is sitting.

Iris is not in a suit.

She is in plain clothes again. The same olive-gray cardigan, dark trousers. Her shoes are off and lined up under the bench. Her hands are folded in her lap. Her hair is back behind her ears.

She is listening.

She does not look at me when I round the corner.

The janitor does not look up.

They have not spoken to each other tonight. They will not speak to each other tonight.

The hum continues.

-> the_choice


= the_choice

I have stopped in the corridor, suit-cam down, HUD logging nothing in particular.

The locker is past Iris. To get to the locker, I have to walk past her.

+ [Walk over, quietly, and sit on the other end of Iris's bench.]
    -> path_iris
+ [Walk to the janitor — say something.]
    -> path_janitor
+ [Take the long way around to the locker. Do not break this.]
    -> path_witness


= path_iris

I walk slowly down the corridor.

The suit's gait coordination softens the step. Even quieter than usual.

Iris does not turn her head. But her eyes shift the smallest amount, to the edge of her vision, where I am walking.

I reach the bench. Sits at the far end of it, leaving the empty space between.

The hum is louder from here. The janitor's circle of mop motion is steady.

Iris does not say anything.

I do not say anything.

They sit there for the length of the hum's next four bars. Iris's hand on the bench between them is bare. The cut on the back of one finger is right there.

When the hum lifts into the bar I almost remembers from this morning, Iris's eyes close briefly. They open again.

The hum continues.

After a long minute, I get up.

Iris does not turn. I do not look back.

I walk past the janitor to the locker. The janitor does not stop humming. The mop continues its circle.

-> after_hallway


= path_janitor

I walk down the corridor. Past Iris on the bench. Past the empty stretch of tile.

To where the janitor is mopping.

The janitor hears I coming. The hum pauses for a beat. A small held breath. Then resumes.

I stop at a polite distance.

# speaker: hud
JANITOR (background voice. Unmodulated): Evening.

She does not look up. She does not stop the mop.

I have not planned what to say. The voice modulator is on; the breath is composing.

# speaker: wren
The song. The song you're...
# speaker: wren
What's it called?

The hum stops.

The janitor lifts her head. She looks at me. At the visor, at the place my face would be.

# speaker: hud
JANITOR: It does not have a name that I know.

# speaker: hud
JANITOR: I learned it from my mother.

A beat.

# speaker: hud
JANITOR: Have a good night, friend.

She goes back to mopping. The hum resumes, the same shape as before, no slower, no faster.

I walk to the locker.

Behind me, Iris has watched the whole exchange. I cannot tell what Iris is thinking.

-> after_hallway


= path_witness

I stand at the corner of the corridor a moment longer.

Then I walk the long way around. Through the connecting corridor by the gym, the way I took the day I turned away from Iris at the window.

The hum follows for the first few meters of the connecting corridor, then thins out, then is gone.

I reach the locker by the back route. The binder is still there, exactly where I left it.

I walk out of the school the way I came in.

The hum is not audible from the front entrance.

But I am carrying it in my head now. The bar of it. The shape.

-> after_hallway


= after_hallway

The walk home is cold.

The HUD does not have a tag for what just happened. It logs nothing of significance.

# speaker: hud
HOME in 12 minutes. Suit power 36%.

-> the_door
