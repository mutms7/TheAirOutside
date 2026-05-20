// scenes/05-hallway.ink — Scene 5: "Out" (~3-4 min)
//
// Pacing: slow-default (motif scene).
// Establishes: Iris, fully outside her suit, at a hallway window watching rain
// — the second bare person Wren has seen today (after Ozaki's demonstration).
// Motif 3 reappearance: rain seen on a windowpane while someone watches bare.
// GATE 2 (major): approach / pretend / turn away.
// Note: "pretend" and "turn away" both set gate2 = "avoid" — the menu offers
// three flavors but two of them are the same outcome. By design.

=== hallway_iris ===
# scene: 5
# pacing: slow
# voice: modulated

-> passing_period


= passing_period
# bg: hallway-day

The passing period bell has rung. The hallway is full of suits in motion, heading to seventh-period classes.

# speaker: hud
HISTORY (lit substitute) in 5 minutes. Room 207.

Wren turns the corner toward Room 207.

-> the_window


= the_window
# motif: rain-window
~ rain_state = 2

# art: corridor-windows
The corner opens into the long hallway with the high windows along the west side of the building. Rain is steady on the glass, the light gray-green through it.

At the third window — the one nobody usually stops at — there is a girl.

She is not in a suit.

She is in plain clothes — a long olive-gray cardigan over a dark shirt, dark trousers. Her hair is loose. Her hands are on the windowsill, bare.

She is watching the rain.

The suit-cam auto-zooms a quarter-second before Wren has decided to look.

# speaker: hud
Pace: slowing. Bio-irregularity logged.

Wren slows.

-> the_hands


= the_hands
# art: iris-bare-hand

The girl's hands.

She is older — a junior, by the build. Two years older than Wren maybe.

There are small marks on her hands — old scars across two of the knuckles, a thin pale cut on the back of one finger that healed slightly the wrong way.

She is not hiding them.

# char: iris bare

Nobody else at this school has hands like that visible.

-> she_turns


= she_turns

The girl turns her head. Slowly. Without looking surprised.

She has seen Wren.

She looks at Wren's face — at where Wren's face would be, behind the visor.

She does not say anything.

She does not smile.

She does not frown.

She just looks.

The silence is offered. It is not demanded.

# speaker: hud
Bio-irregularity logged. (Vital nominal.)

Outside, the rain.

+ [Approach.]
    -> path_approach
+ [Pretend not to see her.]
    -> path_pretend
+ [Turn back the way you came.]
    -> path_turn_away


= path_approach
~ gate2 = "approach"

Wren takes a step.

Then another.

# char: iris bare

Wren stops a polite distance away, at the next window over. Not too close. Not pretending the girl isn't there.

Wren looks at the rain too.

For a second they are two people at two windows looking at the same rain.

# speaker: iris
Hi.

Her voice is quieter than Wren expected. Not warmer than it is. The voice-modulator is not on, because the suit is not on.

# speaker: wren
Hi.

# speaker: wren
Sorry, I—

# speaker: wren
I'm late for—

# speaker: iris
It's okay.

# speaker: iris
You can be late.

A beat.

Wren does not know what to do with this sentence.

# speaker: iris
The rain sounds different outside.

She does not turn from the window when she says it. She is not selling Wren on anything. She is just saying a thing she knows.

Wren listens. From inside the suit, the rain still sounds like ambient pressure on the helmet shell.

Wren watches the rain for one more beat with her.

Then —

# speaker: wren
I should—

# speaker: iris
Yeah.

# speaker: iris
Go.

Wren goes.

# speaker: hud
HISTORY in 2 minutes.

Wren walks the rest of the hallway. The girl is still at the window when Wren turns the corner. She has gone back to looking at the rain.

-> after_iris


= path_pretend
~ gate2 = "avoid"

Wren keeps walking.

Wren's eyes do not return to the third window.

Wren's eyes go to the floor instead — to the polished line of tile where the wall meets the floor — as if that is what Wren was looking at all along.

The girl's gaze, at the edge of the suit-cam, holds for another second and then releases.

# speaker: hud
Pace: nominal.

The HUD does not flag anything. The vitals settle.

Wren passes the third window, the fourth, the fifth.

Wren reaches the corner.

Wren has the half-second sense of wanting to turn back to see if the girl is still there.

Wren does not turn back.

-> after_iris


= path_turn_away
~ gate2 = "avoid"

Wren stops walking.

# speaker: hud
Pace: stopped.

Wren turns around. Walks back the way they came, three steps, five steps.

The hallway behind goes back to ordinary. No window with a bare girl. Just the wall they came from.

Wren takes the long way around to Room 207 — through the connecting corridor by the gym, past the trophy case, the way that adds a minute to the walk.

# speaker: hud
HISTORY in 1 minute.

Wren walks faster.

The girl is somewhere behind, at a window, looking at rain. Wren does not look at her again. Wren does not know what they would have done if they had.

-> after_iris


= after_iris

The corridor empties as the passing-period clock runs out.

Whatever happened a minute ago, the suit has not recorded as significant.

# speaker: hud
HISTORY begins.

-> evening_charging
