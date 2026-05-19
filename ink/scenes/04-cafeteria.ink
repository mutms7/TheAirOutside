// scenes/04-cafeteria.ink — Scene 4: "The Lesser Suits" (~4-5 min)
//
// Pacing: normal.
// Establishes: cafeteria, the visor-lift to eat (worldbuilding), Cael's
// performance-cruelty up close, the unnamed mocked student (a one-sticker
// freshman). GATE 1: Wren stays silent / quietly says something / deflects.
//
// Gate 1 cascades only into Scene 8 (no main-plot fork): whether the mocked
// student speaks to Wren after class.

=== cafeteria ===
# scene: 4
# pacing: normal
# voice: modulated

-> arrival


= arrival
# bg: cafeteria

The cafeteria is bright and loud. Two long rows of tables, the windows along the south wall fogged at the bottom from the rain still falling outside.

Wren joins the food line. The dispenser scans the suit's locker ID and prints a tray — soup, bread, a small wedge of cheese, water.

# speaker: hud
Lunch credit: 1 used. 47 remaining this month.

Wren carries the tray toward the far row of tables.

-> the_visor


= the_visor

At the table, suits eat with the helmet visors lifted — a small mechanical pivot that uncovers the mouth and jaw but keeps the eyes behind shaded glass.

The cafeteria is full of half-faces.

# char: tae warm

Tae is at their usual table, visor up, a small enamel spoon already in her hand.

# speaker: tae
You're late. I got us seats by the window though, which is *very* nice of me.

# speaker: wren
Sorry.

Wren sits. The visor lifts. The cheese is small and slightly dry.

# speaker: tae
Friday is the year assembly. Did you read the bulletin? They want everyone in their "primary palette" for the photo. I'm doing coral, obviously. You're going to be peach, obviously. We need to make a plan for accents.

# speaker: wren
Okay.

# speaker: tae
"Okay." Such enthusiasm.

# speaker: tae
You're funny, Wren.

She is smiling. She means it.

-> cael_starts


= cael_starts
# audio: cael-court

A small swell of laughter from two tables over.

Cael's voice carries — the gold-suit boy from the back of homeroom, surrounded again by the same handful of front-row faces.

# speaker: cael
No, no — listen. Listen. *Look* at it.

Cael is pointing at someone. Not at his own table. At the next table over.

The kid he is pointing at is a freshman girl in a faded-blue suit. One small star sticker on her left shoulder. Eating quickly, head down. Visor up like everyone else's.

She is not looking at Cael. The visor only covers her eyes, but she is using the jaw line of her helmet like a small wall.

# speaker: cael
One sticker. *One.* That is — that is like — that is *worse* than no sticker, you understand what I mean? That is "I tried." That is "I tried and this is what I came up with." That is sad. That is so sad.

# speaker: cael
You either commit or you don't.

Cael's table laughs. Two of them properly, two of them about a beat behind.

Tae's mouth does a small thing.

# audio: ambient-cafeteria-down

Tae looks at Wren. The smallest glance. Checking.

The mocked girl reaches for her water without looking up.

+ [Don't laugh. Don't look back at Tae. Keep eating.]
    -> path_silent
+ [Say something quietly to Tae.]
    -> path_speak
+ [Change the subject.]
    -> path_deflect


= path_silent

~ gate1 = "silent"

Wren keeps their eyes on the soup.

Tae's small laugh ends in the air, uncommitted, and dies.

Tae looks down at her tray.

# speaker: tae
Anyway. Friday. Accents. You're not going to do anything weird, right?

# speaker: wren
No.

The mocked girl finishes her water. Sets the cup down without a sound.

Cael's table has moved on to something else.

-> end_of_lunch


= path_speak

~ gate1 = "speak"

# speaker: wren
That's not really—

Wren says it low, to Tae, almost into the tray.

# speaker: wren
that's not fair.

Tae's face holds for a second. She does not look at Cael. She does not look at the mocked girl. She looks at Wren.

# speaker: tae
Yeah.

# speaker: tae
Yeah, you're right.

Tae does not laugh. The half-laugh she was already laughing finishes itself and is gone. She does not laugh at the next thing Cael says either.

The mocked girl, two tables over, eats one more spoonful of soup. Sets the spoon down. She has not looked up. But her shoulders — for the smallest second — change shape.

She does not look at Wren.

Wren does not look at her.

-> end_of_lunch


= path_deflect

~ gate1 = "deflect"

# speaker: wren
Hey — Friday. What's the assembly actually for?

Tae blinks. Recalibrates.

# speaker: tae
The — oh. It's the founders' thing. The whole-school-history thing. Coach Reilly gives the speech, the choir does the song. You really didn't read the bulletin.

# speaker: wren
I didn't.

# speaker: tae
You're hopeless.

Tae is smiling again. The Cael thing is past for her, now. She is not laughing at Cael's next line either, but only because she is mid-sentence about Friday.

The mocked girl has finished her water. She gets up, picks up her tray.

She walks past Wren's table on the way to the return belt. Her eyes do not lift.

-> end_of_lunch


= end_of_lunch

The cafeteria's overhead chime sounds.

# sfx: bell-soft

# speaker: hud
LUNCH ends. Calendar next: PASSING PERIOD, then HISTORY (lit substitute today).


Trays go to the return belt. Visors come down with a small mechanical snick across the room — a hundred small mouths becoming a hundred sealed visors again.

Tae stands, taps Wren's shoulder plate over the new peach sticker.

# speaker: tae
Try not to be late to history. Coach Ozaki is subbing apparently. *Coach* Ozaki. I cannot wait to see this.

She is gone toward the hallway, suit shimmering through the crowd.

Wren stands more slowly. The cafeteria empties around them.

-> hallway_iris
