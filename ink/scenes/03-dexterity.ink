// scenes/03-dexterity.ink — Scene 3: "Smooth" (~5-6 min at slow default)
//
// Pacing: slow-default (motif scene per mechanics.md).
// Establishes: dexterity training as the school's effort to keep body-memory alive
// inside the suit (Ozaki's quiet thesis, never narrated); Ozaki's voice;
// Ozaki's small revealing moment 1 (steps out of his suit to demonstrate).
// Plants Motif 3 first appearance (rain heard as muffled white noise from inside).
// Plants the Iris glimpse through the window for players who take the drift path.
//
// Branch: small texture-only choice on how Wren engages with the drill.
// The drift path sets seen_iris_through_window for Scene 5 phrasing.

VAR seen_iris_through_window = false

=== dexterity_pe ===
# scene: 3
# pacing: slow
# voice: modulated

-> arrival


= arrival
# bg: pe-hall
# char: ozaki neutral

The dexterity hall is a large open room with a sprung floor. Twenty-six suits line up in a loose grid. The light comes in long bars through the high windows along the south wall.

# speaker: ozaki
Three positions today. First. Second. Third. Without breaking the line of your arm.

# speaker: ozaki
Watch. Try. Repeat.

Ozaki demonstrates with the suit on — the three positions, slowly, the suit's measured precision smoothing each motion.

# speaker: ozaki
Begin.

-> drill_starts


= drill_starts

The class moves. Twenty-six suits move into the first position together.

Two suits move into the second position out of sync. A small chime — the out-of-pace marker, soft enough not to embarrass anyone but clear enough to be heard.

Wren's suit moves with the rest. The arm coordination is smooth. The first to the second is almost effortless.

The second to the third is not.

Wren stops between two and three, hesitates, the suit recalibrates.

# speaker: hud
Pace check: 92%.

Across the room, others are also recalibrating. There is a small ripple of out-of-pace chimes.

+ [Close your eyes and feel the second position from the inside.]
    -> path_focus
+ [Raise your hand and ask.]
    -> path_question
+ [Let your eyes drift to the high window.]
    -> path_drift


= path_focus

Wren closes their eyes for a second.

The suit's helmet visor darkens slightly — focus mode, an old feature most students don't use anymore.

The second position is a thing the body holds, not a thing the suit calculates. Wren can almost feel where the arm wants to be. The suit takes them there.

A small chime. Pace check: 96%.

# speaker: hud
Coordination improved.

Wren does not know what to do with this.

-> convergence


= path_question

Wren raises a hand. The suit's signal flag lights up at the wrist.

# speaker: ozaki
Yes.

# speaker: wren
The second position — is the elbow leading, or—

# speaker: wren
or the wrist?

Ozaki considers Wren for a moment longer than other teachers would.

# speaker: ozaki
The elbow.

# speaker: ozaki
Always the elbow.

# speaker: ozaki
The wrist follows. Try again.

Wren tries again. The second position lands cleaner.

# speaker: ozaki
There.

-> convergence


= path_drift

For a second, Wren's eyes leave the drill.

Through the high south window: rain is starting. Tiny lines on the glass.

Beyond the rain, on the path along the side of the building — a figure.

Walking slowly, not in a hurry. No helmet. The shoulder line of plain clothes. No suit at all.

Wren has never seen anyone in this school like this.

The figure is too far for the suit-cam to auto-zoom.

A second more.

The figure passes out of frame behind the row of trees that runs along the path.

Wren's eyes return to the drill. The suit's coordination has held the pose without them.

~ seen_iris_through_window = true

-> convergence


= convergence
# motif: rain-window
~ rain_state = 1

The rain has become steadier. From inside the suit, it sounds like muffled white noise — a low, ambient pressure against the helmet shell. The hall's audio system filters most of it out.

The class is still struggling with the third position. Two-thirds of the room cannot make the second-to-third transition smooth. There are more out-of-pace chimes than not, now.

Ozaki watches for another twenty seconds.

# speaker: ozaki
All right. Stop.

The class stops.

-> ozaki_demo


= ozaki_demo

Ozaki walks to the front of the hall. He stops on the demonstration square.

# speaker: ozaki
It's faster to show you.

# sfx: suit-unseal
The chest plate of Ozaki's suit opens.

The class is suddenly silent.

# char: ozaki bare

Ozaki steps out of the suit. The suit stands behind him on its own — autoframe locked, helmet still on the rest, the blinking diagnostic light running through its cycle softly.

Ozaki is wearing a plain undershirt and plain trousers. He is mid-forties. His shoulders are narrower than the suit suggested. There is a small scar near his collarbone that the suit normally covers.

# speaker: hud
Suit autoframe: standby. Instructor unsuited.

A bio-irregularity blip flashes across the HUDs of several students at the same time — small spikes, recorded and dismissed by the system. The class is not breathing the way it was a second ago.

Wren is one of the spikes.

# speaker: ozaki
First.

Ozaki takes the first position. The line of his arm is long and exact.

# speaker: ozaki
Second.

He moves. Slowly. Without the suit's measured assist. The arm goes through a small arc no suit would have planned.

# speaker: ozaki
Third.

He arrives. The line of his arm is the same as the first. Continuous. Unbroken.

He does it once more, faster.

He does it once more, faster still.

The way a thing is done when the body has known it for a long time.

The class is watching the way a class watches a bird in a room.

-> ozaki_redress


= ozaki_redress

# speaker: ozaki
That.

# speaker: ozaki
That is what we are trying to remember.

He turns. The suit's chest plate opens for him.

# sfx: suit-seal
Ozaki steps back in. The plate closes around his shoulders. The seal-glow runs once around the rim and settles to standby.

# char: ozaki neutral

# speaker: ozaki
Two more attempts each, please. First, second, third. Then we are done for today.

The class moves again. Slower. Paying more attention now.

Wren tries the sequence once. The second-to-third lands cleaner than before.

# speaker: hud
Pace check: 95%.

Wren does not know why.

-> end_of_class


= end_of_class
# sfx: bell-soft

A soft chime. End of class.

# speaker: ozaki
Thank you. Friday is the same drill. Practice between now and then if you can.

The suits begin to disperse toward the charging lockers in the hallway.

The rain outside is steady. Inside the suits it stays a muffled pressure, no more.

# speaker: hud
Calendar next: LUNCH in 12 minutes.

-> cafeteria
