// scenes/10-taes-drawer.ink — Scene 10: "Tae's Drawer" (~5 min)
//
// Pacing: normal.
// Motif 2 reappearance: the sticker recontextualized in Tae's drawer
// (an old, un-applied one from last year). Tae's small revealing moment.
// Tae confides — small, not a tragedy — that she is afraid she is
// becoming forgettable.
//
// Texture (S): supportive / honest about own drift / change subject.
// The "honest" path costs Tae something visible.

=== taes_drawer ===
# scene: 10
# pacing: normal
# voice: modulated

-> tae_house


= tae_house
# bg: bedroom-night
# char: tae warm

Tae's room is brighter than Wren's. Pink string-lights along the ceiling line. A wall of photos — printed, paper, not on-suit. A standing display of decoration cases by color. Coral. Magenta. Pink. Sunset orange.

The window looks out at the city's evening — the same suit-traffic Wren walks through every day, in lit miniature.

# speaker: tae
Sit anywhere. I'm going to grab us water. Are you a flat-water or sparkling person — never mind, I know you, you'll drink whatever I bring.

Tae disappears down the hall.

# char: tae

Wait — Tae is not on stage anymore.

# char:

Wren is alone in Tae's room.

-> the_drawer


= the_drawer

Wren looks around.

Tae's desk has a small open organizer with the day's removed decorations laid out neatly — the coral she wore today, the rhinestone collar pieces, the enamel pin.

Beside it, a drawer of the desk is open just enough to show its contents.

# motif: sticker-tae-drawer

Inside the drawer: a small flat case. Inside the case, on a square of paper: one enamel sticker.

Peach. With a mint crescent at the rim.

Not last year's color. *This* year's color. *This morning's* color.

But the back has been packed in protective wax paper as if it had never been peeled. The brand sticker on the wax paper has a faded date code — last spring.

It is the same sticker Tae put on Wren this morning. But this one has never been applied. It has been in a drawer for almost a year.

Wren cannot tell if Tae bought two of them last year, or whether Tae kept this one and was waiting for the day Wren's palette caught up.

Either thing is something.

Down the hall, the faucet runs.

Wren slides the drawer not-quite-shut, the way it was before.

-> tae_returns


= tae_returns
# char: tae warm

Tae comes back in with two glasses of water. Sparkling, for both of them, with a sliced strawberry in each. Of course.

# speaker: tae
# art: tae-strawberry-water
Strawberry water. You're welcome.

Tae hands Wren the glass and flops onto her bed.

She has taken her chest decoration off — the coral. Her shoulder is bare, the seal-glow at standby. Her hair is back. She is more herself in here than she is anywhere else in the day.

# speaker: tae
Did you and Cael have a thing today? You were quiet at lunch.

# speaker: wren
No.

# speaker: tae
Was it the joke? The "one sticker" thing? Because — yeah, it wasn't his finest hour.

# speaker: wren
I wasn't really thinking about Cael.

# speaker: tae
Hm.

She drinks. The sparkling water hisses faintly in the glass.

-> the_confession


= the_confession

# speaker: tae
Can I say a weird thing.

# speaker: wren
Yeah.

# speaker: tae
You know what's weird. I'll be at the assembly Friday. I'll have my whole — my whole *thing* on. The new coral and the deep collar and the new pin if it ships. And I'll look at everyone and I'll think —

# speaker: tae
if I stopped showing up. If I just stopped. How many days would it take. For anyone to notice. Like — statistically.

She laughs.

It is a small laugh, the kind she lands too quickly to leave it hanging.

# speaker: tae
I'm being weird. I know.

The room is quiet.

Tae is looking at the strawberry in her glass.

+ [Reassure her.]
    -> path_supportive
+ [Tell her something honest about yourself.]
    -> path_honest
+ [Change the subject.]
    -> path_deflect


= path_supportive

# speaker: wren
Tae, of course people would notice. I would notice.

# speaker: wren
Right away.

Tae looks up. Her face does the warm-Tae thing — the smile she would have used if she had not just said the weird thing.

# speaker: tae
Yeah. I know. Thank you.

# speaker: tae
Sorry. That was — yeah.

# speaker: tae
Tell me about literature today. Was Ozaki actually subbing? Did he read something weird, I bet he read something weird —

The strawberry water hisses. Tae has put the moment away.

-> after_confession


= path_honest

# speaker: wren
I—

# speaker: wren
sometimes I think I don't quite know who I am. Underneath.

# speaker: wren
Like — underneath the suit. Underneath the — the schedule. The stickers. I don't know what's left.

# speaker: wren
And it's not — it's not bad. It's not bad. It's just quiet. It's like a room I haven't been in for a long time.

Wren stops.

The room is heavier than it was a moment ago.

Tae is looking at Wren. She is not smiling now. Her hand is around the glass and the glass is sweating slightly.

# speaker: tae
Yeah.

# speaker: tae
Yeah.

# speaker: tae
That's — that's a thing.

She does not know what to say next. Wren did not know either. The two of them sit with it.

After a minute Tae says —

# speaker: tae
Don't disappear on me. Okay?

# speaker: wren
I won't.

Wren is not sure if that is true.

-> after_confession


= path_deflect

# speaker: wren
What time is it? I should probably—

# speaker: wren
my mom — I told her I'd be back before—

Tae's face holds.

# speaker: tae
Oh. Yeah. Yeah, of course.

# speaker: tae
You should go.

She is not angry. She is somewhere else.

She walks Wren to the door. The strawberry water sits half-finished on the desk.

# speaker: tae
Tomorrow. Coral assembly. Mint accents. Don't forget.

# speaker: wren
I won't.

-> after_confession


= after_confession

The walk home is short and dark and the air outside the building is cold.

Wren has the half-sense of something that did not quite resolve. The HUD does not flag it. There is no log entry for "an evening with a friend that ended a small way wrong."

# speaker: hud
Suit power 42%. CHARGE recommended within 90 minutes.

-> night_hallway
