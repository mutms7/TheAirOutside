// scenes/08-classroom.ink — Scene 8: "Be More Honest" (~5 min)
//
// Pacing: slow (the passage and the worksheet beat both deserve it).
// Ozaki substitutes for the sick literature teacher and reads a short
// passage with the cadence of the 1984 prole-woman moment — about a working
// woman at a basin, watched from a window, the watcher feeling gratitude
// rather than pity. (Drafted here; can be revised in the script-edit pass.)
//
// Ozaki's revealing moment 2: a student's poem with his pencil note in the
// margin — "be more honest" — visible in passing as Wren leaves.
//
// Gate 1 callback: the mocked student speaks to Wren / no one speaks to Wren /
// a classmate nods, depending on Scene 4 cafeteria choice.
//
// Texture (S): Wren contributes to discussion / stays silent / writes a
// private note in the suit's text buffer.

VAR class_engagement = ""

=== classroom_ozaki ===
# scene: 8
# pacing: slow
# voice: modulated

-> seating


= seating
# bg: classroom
# char: ozaki neutral

The history classroom is a different room than homeroom. The chairs are arranged in a half-circle facing the front. The literature teacher's name is still on the board from yesterday, in her handwriting — small and tidy.

Ozaki is standing where she usually stands. He has brought no slides. He has brought a single thin paperback book.

# speaker: ozaki
Ms. Carraghan is sick today. I am subbing. We are reading one short passage. Then we are discussing it. That is the lesson.

A small ripple of glance-exchange among the students. Wren cannot see Tae from this seating — Tae's history is the period after.

# speaker: ozaki
This passage is from a book older than any of you, by an author older than that. The setting does not matter. The setting is not what we are reading for.

# art: literature-book
Ozaki opens the paperback. The spine has been read enough that it falls open at the right page.

-> the_passage


= the_passage
# pacing: slow

# speaker: ozaki
# art: basin-passage
At the basin in the courtyard, a woman was washing.

# speaker: ozaki
Small methodical motions of the wrist — the kind the body has learned over a long time.

# speaker: ozaki
The sleeves were pushed up. The afternoon light fell on the back of her hands.

# speaker: ozaki
She was humming a song he did not know.

# speaker: ozaki
He stood at the window and watched her for a long minute. And what he found himself feeling was not pity, and not curiosity.

# speaker: ozaki
It was something nearer to gratitude.

# speaker: ozaki
That she existed. That her work existed.

# speaker: ozaki
That the world had her in it and had not bothered to know it.

Ozaki closes the book.

He puts it down on the lectern, flat.

He waits.

-> discussion


= discussion

The classroom is quiet for longer than usual.

# speaker: ozaki
Anyone.

A student in the back row raises their hand.

# speaker: ozaki
Yes.

# speaker: hud
STUDENT, BACK ROW: it's about the watcher, right? Not about the woman. Like, the lesson is about him — that he sees her and that changes something in him.

# speaker: ozaki
Possibly.

# speaker: ozaki
Anyone else.

A pause. Another hand goes up — front row this time.

# speaker: hud
STUDENT, FRONT ROW: it's about her dignity. He sees her work as having worth even though she doesn't know he's there. He grants it to her by noticing.

# speaker: ozaki
Hm.

Ozaki does not respond to that one for a moment. He is considering it.

# speaker: ozaki
What does she lose, if he does not watch her?

A longer pause.

# speaker: hud
SAME STUDENT: nothing. She does not know he is there.

# speaker: ozaki
Right. So.

# speaker: ozaki
So what is the passage doing.

Wren's HUD is logging the discussion. Wren's name is not in the participants list.

+ [Raise your hand.]
    -> path_contribute
+ [Stay quiet.]
    -> path_silent
+ [Open the suit's private text buffer and write something.]
    -> path_note


= path_contribute
~ class_engagement = "contribute"

Wren raises a hand. The wrist signal flag lights up.

# speaker: ozaki
Yes, Wren.

# speaker: wren
Maybe it's about him learning to—

# speaker: wren
to look without needing anything back.

Wren says it more quietly than they meant to.

Ozaki considers Wren for a longer moment than the others.

# speaker: ozaki
Yes.

# speaker: ozaki
That. Is one of the things it is doing.

He does not elaborate. He moves on to the next raised hand.

But once during the next minute, when Wren is not looking at him, Ozaki glances at Wren.

-> end_of_class


= path_silent
~ class_engagement = "silent"

Wren does not raise a hand.

Three more students contribute over the next few minutes. The discussion goes on. Ozaki listens more than he talks.

Wren listens too. Wren listens harder than usual, perhaps. The HUD does not record this.

-> end_of_class


= path_note
~ class_engagement = "note"

Wren keeps both hands down.

Wren opens the suit's private text buffer — a feature most students do not use. It is for in-class notes nobody else can see.

Wren writes one sentence.

# speaker: hud
PRIVATE BUFFER: The woman at the basin.

Wren does not write anything else.

Wren saves it. Closes the buffer. Watches the rest of the discussion.

-> end_of_class


= end_of_class
# sfx: bell-soft

The end-of-period chime.

# speaker: ozaki
Read whatever you like before next class. Anything. Not for an assignment. Just to remember that reading is a thing you can do.

The classroom begins to dismiss.

As Wren passes the front of the room toward the door, the lectern is on the right; Ozaki's desk is on the left. On the desk is a stack of student work — yesterday's, ungraded.

The top one is a poem. Half-on, half-off the stack.

# art: be-more-honest-worksheet
Wren does not stop walking. Wren reads it sideways anyway.

# speaker: hud
STUDENT POEM (visible margin): "...the colors we / wear so as to be / accidentally seen..."

In the margin, in pencil, a single note in tidy handwriting:

# speaker: hud
*be more honest*

Wren keeps walking.

-> the_doorway


= the_doorway

{
    - gate1 == "speak":
        -> callback_speak
    - gate1 == "silent":
        -> callback_silent
    - gate1 == "deflect":
        -> callback_deflect
    - else:
        -> after_class
}


= callback_speak

In the doorway, waiting near the wall, is the freshman in the faded-blue suit. The one with the one star sticker.

She is not looking at Wren directly. She is looking at a point three feet to Wren's left.

As Wren passes her, she says — just loud enough, into the air —

# speaker: hud
FRESHMAN (faded-blue): Thanks for yesterday.

Wren has the half-second sense of not knowing what to say.

The girl is already walking the other way down the hallway.

Wren keeps walking.

The HUD does not flag the exchange.

-> after_class


= callback_silent

Wren walks out of the classroom alone.

The hallway is filling up — students from a dozen other classrooms moving toward fifth period.

# speaker: hud
Pace: nominal.

No one approaches Wren. No one greets Wren. Tae is in another wing.

For a half-second, Wren registers something: that no one has spoken to Wren since the cafeteria.

Not Cael, not anyone at lunch after the joke, not a teacher all afternoon. The HUD does not flag this. It is not something the HUD knows to flag.

Wren keeps walking.

-> after_class


= callback_deflect

A classmate Wren has barely spoken to — one of the back-row students who answered Ozaki's question — passes Wren in the doorway.

He does not stop. He does not slow.

But as he passes, he gives Wren a nod. Small. Not making it into a thing.

Wren nods back, more out of habit than intention.

Then they are gone in opposite directions, and Wren is in the hallway with the half-feeling of having had a conversation Wren cannot remember.

-> after_class


= after_class

# speaker: hud
PASSING PERIOD. FIFTH PERIOD in 4 minutes.

-> malfunction
