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

I turn the corner toward Room 207.

-> the_window


= the_window
# motif: rain-window
~ rain_state = 2

# art: corridor-windows
The corner opens into the long hallway with the high windows along the west side of the building. Rain is steady on the glass, the light gray-green through it.

At the third window. The one nobody usually stops at. There is a girl.

She is not in a suit.

She is in plain clothes. A long olive-gray cardigan over a dark shirt, dark trousers. Her hair is loose. Her hands are on the windowsill, bare.

She is watching the rain.

The suit-cam auto-zooms a quarter-second before I have decided to look.

# speaker: hud
Pace: slowing. Bio-irregularity logged.

I slow.

-> the_hands


= the_hands
# art: iris-bare-hand

The girl's hands.

She is older. A junior, by the build. Two years older than I maybe.

There are small marks on her hands. Old scars across two of the knuckles, a thin pale cut on the back of one finger that healed slightly the wrong way.

She is not hiding them.

# char: iris bare

Nobody else at this school has hands like that visible.

-> she_turns


= she_turns

The girl turns her head. Slowly. Without looking surprised.

She has seen I.

She looks at my face. At where my face would be, behind the visor.

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

I take a step.

Then another.

# char: iris bare

I stop a polite distance away, at the next window over. Not too close. Not pretending the girl isn't there.

I look at the rain too.

For a second they are two people at two windows looking at the same rain.

# speaker: iris
Hi.

Her voice is quieter than I expected. Not warmer than it is. The voice-modulator is not on, because the suit is not on.

# speaker: wren
Hi.

# speaker: wren
Sorry, I...
# speaker: wren
I'm late for...
# speaker: iris
It's okay.

# speaker: iris
You can be late.

A beat.

I do not know what to do with this sentence.

# speaker: iris
The rain sounds different outside.

She does not turn from the window when she says it. She is not selling I on anything. She is just saying a thing she knows.

I listen. From inside the suit, the rain still sounds like ambient pressure on the helmet shell.

I watch the rain for one more beat with her.

Then ...
# speaker: wren
I should...
# speaker: iris
Yeah.

# speaker: iris
Go.

I go.

# speaker: hud
HISTORY in 2 minutes.

I walk the rest of the hallway. The girl is still at the window when I turn the corner. She has gone back to looking at the rain.

-> after_iris


= path_pretend
~ gate2 = "avoid"

I keep walking.

My eyes do not return to the third window.

My eyes go to the floor instead. To the polished line of tile where the wall meets the floor. As if that is what I was looking at all along.

The girl's gaze, at the edge of the suit-cam, holds for another second and then releases.

# speaker: hud
Pace: nominal.

The HUD does not flag anything. The vitals settle.

I pass the third window, the fourth, the fifth.

I reach the corner.

I have the half-second sense of wanting to turn back to see if the girl is still there.

I do not turn back.

-> after_iris


= path_turn_away
~ gate2 = "avoid"

I stop walking.

# speaker: hud
Pace: stopped.

I turn around. Walks back the way they came, three steps, five steps.

The hallway behind goes back to ordinary. No window with a bare girl. Just the wall they came from.

I take the long way around to Room 207. Through the connecting corridor by the gym, past the trophy case, the way that adds a minute to the walk.

# speaker: hud
HISTORY in 1 minute.

I walk faster.

The girl is somewhere behind, at a window, looking at rain. I do not look at her again. I do not know what they would have done if they had.

-> after_iris


= after_iris

The corridor empties as the passing-period clock runs out.

Whatever happened a minute ago, the suit has not recorded as significant.

# speaker: hud
HISTORY begins.

-> evening_charging
