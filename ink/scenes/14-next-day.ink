// scenes/14-next-day.ink — Scene 14: "Bare" (~5 min)
//
// Pacing: normal.
// The morning after the climax. Wren returns to school.
//
// GATE 4 (final, major):
//   "stay_out"     — fully without the suit
//   "suit_no_deco" — wearing the suit but unadorned, like Iris and Ozaki
//   "re_enter"     — fully suited and decorated, but the gaze is different
//
// Texture in this scene:
//   - Tae's reaction varies across all three (but in all variants she does
//     not report Wren and does not look away — that is her grace)
//   - Ozaki gives a single nod, no words
//   - Cael says nothing — he does not have a script for this
//   - The mocked student from Scene 4 makes eye contact (longer in some
//     variants — i.e., when gate1 == "speak")

=== next_day ===
# scene: 14
# pacing: normal
# voice: modulated

-> the_morning


= the_morning
# bg: bedroom-morning
# char: wren bare

Wren wakes early. The light through the window is pale and thin. The window is still open from last night. The room smells like outside.

The suit is on the floor where Wren left it — chest plate open in standby, leg sleeves in two careful piles, helmet on the desk beside the external HUD.

Wren sits up. Looks at the suit on the floor.

Wren has to decide.

+ [Leave the suit on the floor. Go to school without it.]
    ~ gate4 = "stay_out"
    -> prepare_stay_out
+ [Put the suit on. Leave the shoulder bare.]
    ~ gate4 = "suit_no_deco"
    -> prepare_no_deco
+ [Put the suit on. Apply the peach. Mint at the rim.]
    ~ gate4 = "re_enter"
    -> prepare_re_enter


= prepare_stay_out

Wren leaves the suit where it is.

Wren puts on plain clothes — what people would wear under the suit, mostly. A long-sleeved shirt. Trousers. Soft shoes. A jacket Wren has not worn in a year because the suit's outer shell handled all weather.

The external HUD goes in a pocket — habit. Wren turns it off.

In the hallway mirror, Wren sees their face. Both eyes. The whole face. The small constellation of two freckles on the left cheek Wren had not seen in person in months.

The house is empty. Wren leaves through the front door, in plain clothes, into morning air that is not filtered.

-> the_walk


= prepare_no_deco

Wren puts the suit on. Slowly. Each piece's seal-glow registers the reconnection, then settles.

But Wren does not open the small case on the desk where last year's stickers and this season's stickers are sorted by color. Wren does not apply anything.

The peach from yesterday is still in Tae's drawer — the second one, the one Tae has kept. Wren cannot apply that one.

The shoulder plate of Wren's suit is bare.

The seal-glow around the empty enamel-mount does its usual one circuit and settles.

# speaker: hud
GOOD MORNING, WREN. Suit power 91%. Calendar: HOMEROOM in 26 minutes. Weather: clear.

Wren leaves through the front door.

-> the_walk


= prepare_re_enter

Wren puts the suit on. Slowly — slower than other mornings.

The chest plate. The leg sleeves. The gauntlets. The helmet.

Wren opens the small case on the desk. The peach sticker — one of Wren's own from last week, an extra — comes out. Wren applies it to the shoulder plate. Mint crescent at the rim. Exactly where Tae would have put it.

The seal-glow runs once around the new attachment.

# speaker: hud
GOOD MORNING, WREN. Decoration registered. Calendar: HOMEROOM in 26 minutes. Weather: clear.

In the mirror, Wren looks the same as yesterday morning.

But the eyes behind the visor are looking out. Wren is looking out.

Wren leaves through the front door.

-> the_walk


= the_walk
# bg: street-morning

The morning street is the morning street. Other suits in motion. The service-class woman with the cart, somewhere up ahead. A delivery suit at the corner. The yellow-suited dinosaur kid is not late this morning; he is walking with his mother, both decorated together.

Wren walks the same route.

{
    - gate4 == "stay_out":
        Wren's bare face is in the air. The morning is cold against the cheekbones. People are looking. Some keep looking. Some look away. One older man slows down and watches Wren pass, his expression unreadable behind his visor. Wren does not look at him. Wren walks.
    - gate4 == "suit_no_deco":
        The empty shoulder catches the morning light. A few suit-cams auto-zoom, briefly, on the absence. Wren does not look back at them.
    - gate4 == "re_enter":
        Wren looks at the morning the way Wren did not look at it yesterday. The way the light hits the side of the building. The patches of grass at the curb where the rain has gone. Wren has not changed how Wren is dressed. Wren has changed what Wren is doing inside the dressing.
}

-> the_curb


= the_curb

The curb comes up. The ant hill is still there, in its half-crushed state. The rebuilders have made progress overnight. The cone is most of the way back, slightly smaller than it was the morning before yesterday.

Wren slows for two breaths. Then keeps walking. The hill will be itself again by tomorrow.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry — Wren has no suit on.) | HOMEROOM in 9 minutes. }

-> arrival


= arrival
# bg: hallway-day
# art: school-exterior

The morning corridor. Suits filing in through the main doors in twos and threes, the way they do every morning.

Wren walks in.

The first ten meters: heads turn. A few. Some not at all. Some that turn quickly and turn quickly back.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry — Wren is bare.) | Pace: nominal. Bio-irregularity logged across approximately 14 nearby suits. }

-> tae_meets


= tae_meets
# char: tae warm

Tae is at her locker.

Tae sees Wren.

{
    - gate4 == "stay_out":
        Tae's face does a series of things in the half-second before she has a chance to compose it. Surprise. Fear. Something that is neither. Then she sees Wren's face — both eyes, the whole face, the constellation of two freckles on the left cheek — and she closes the locker softly and walks toward Wren.
        # speaker: tae
        Oh.
        # speaker: tae
        Oh. Wren.
        She is not telling anyone. Her hand goes up toward her wrist-comm, then away again. She has decided not to flag this.
        # speaker: tae
        Walk with me?
        # speaker: wren
        Yeah.
        They walk to homeroom together, in the same hallway, one of them in plain clothes, one of them in coral, neither of them faster than the other.
    - gate4 == "suit_no_deco":
        Tae sees the empty shoulder. She does not say anything immediately.
        # speaker: tae
        Hi.
        # speaker: wren
        Hi.
        She has her case of stickers in her bag. Wren can see the outline of it. Her hand goes to the bag. Her hand comes back to her side.
        # speaker: tae
        Coral assembly tomorrow, by the way. Just in case.
        # speaker: wren
        I know.
        # speaker: tae
        Okay.
        # speaker: tae
        Walk with me?
        # speaker: wren
        Yeah.
        They walk to homeroom together. Tae does not bring out the case. The empty shoulder is the empty shoulder. Tae does not look away from it. Tae does not stare at it.
    - gate4 == "re_enter":
        Tae sees the peach. Tae sees the mint accent at the rim. Tae sees the eyes behind Wren's visor.
        Tae knows something is different. She does not know what.
        # speaker: tae
        You look good.
        # speaker: wren
        Yeah?
        # speaker: tae
        Yeah. Better than yesterday actually. The placement is — it's the same as yesterday but it's better. I don't know.
        # speaker: tae
        Are you okay?
        # speaker: wren
        Yeah.
        # speaker: wren
        Tae. Yeah.
        Tae does not ask further. She has the half-feeling that a question would close the door.
        They walk to homeroom together, in the same hallway, both in coral and peach, mint accents at the rim, neither of them faster than the other.
}

-> ozaki_passes


= ozaki_passes
# char: ozaki neutral

Across the wide corridor, near the dexterity-hall door, Mr. Ozaki is talking to another teacher. He sees Wren.

He does not pause his conversation.

But he meets Wren's eyes — through the visor or without, depending on whether Wren has one — and he nods once. Small. Not making it into a thing.

Wren nods back.

The other teacher does not notice.

Ozaki goes back to his conversation.

-> mocked_student


= mocked_student
# char: wren

Up ahead, the freshman girl in the faded-blue suit is at her locker. The one with the one star sticker.

She sees Wren.

{
    - gate1 == "speak":
        She holds Wren's gaze for a longer moment than necessary. The kind of look you give a person when you are trying to say something without saying it. Then she nods — very small — and goes back to her locker. The one star sticker on her shoulder catches the corridor light.
    - else:
        She holds Wren's gaze for the length of a breath. Then she looks down and goes back to her locker.
}

Wren walks past.

-> cael_silent


= cael_silent

At the back of the corridor, near the homeroom doorway, Cael is standing with his usual group. He sees Wren.

He sees Wren.

He does not have a script for this.

His mouth opens — for half a second, the start of a sentence forming — and then closes. He turns to one of the kids beside him and says something Wren cannot hear. The kid laughs, but a beat late, because the kid is also looking at Wren.

Cael does not look at Wren again as Wren passes.

This is the closest thing to grace Cael will produce today, and he does not know it.

-> homeroom_door


= homeroom_door

Tae is still beside Wren at the homeroom doorway.

# speaker: tae
After class, can we — just walk somewhere. Anywhere.

# speaker: wren
Yeah.

# speaker: tae
Okay.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry.) | HOMEROOM begins. }

-> coda
