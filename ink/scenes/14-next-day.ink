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

I wake early. The light through the window is pale and thin. The window is still open from last night. The room smells like outside.

The suit is on the floor where I left it. Chest plate open in standby, leg sleeves in two careful piles, helmet on the desk beside the external HUD.

I sit up. I look at the suit on the floor.

I have to decide.

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

I leave the suit where it is.

I put on plain clothes. What people would wear under the suit, mostly. A long-sleeved shirt. Trousers. Soft shoes. A jacket I have not worn in a year because the suit's outer shell handled all weather.

The external HUD goes in a pocket. Habit. I turn it off.

In the hallway mirror, I see my face. Both eyes. The whole face. The small constellation of two freckles on the left cheek I had not seen in person in months.

The house is empty. I leave through the front door, in plain clothes, into morning air that is not filtered.

-> the_walk


= prepare_no_deco

I put the suit on. Slowly. Each piece's seal-glow registers the reconnection, then settles.

But I do not open the small case on the desk where last year's stickers and this season's stickers are sorted by color. I do not apply anything.

The peach from yesterday is still in Tae's drawer. The second one, the one Tae has kept. I cannot apply that one.

The shoulder plate of my suit is bare.

The seal-glow around the empty enamel-mount does its usual one circuit and settles.

# speaker: hud
GOOD MORNING, {protagonist_name}. Suit power 91%. Calendar: HOMEROOM in 26 minutes. Weather: clear.

I leave through the front door.

-> the_walk


= prepare_re_enter

I put the suit on. Slowly. Slower than other mornings.

The chest plate. The leg sleeves. The gauntlets. The helmet.

I open the small case on the desk. The peach sticker. One of my own from last week, an extra. Comes out. I apply it to the shoulder plate. Mint crescent at the rim. Exactly where Tae would have put it.

The seal-glow runs once around the new attachment.

# speaker: hud
GOOD MORNING, {protagonist_name}. Decoration registered. Calendar: HOMEROOM in 26 minutes. Weather: clear.

In the mirror, I look the same as yesterday morning.

But the eyes behind the visor are looking out. I am looking out.

I leave through the front door.

-> the_walk


= the_walk
# bg: street-morning

The morning street is the morning street. Other suits in motion. The service-class woman with the cart, somewhere up ahead. A delivery suit at the corner. The yellow-suited dinosaur kid is not late this morning; he is walking with his mother, both decorated together.

I walk the same route.

{
    - gate4 == "stay_out":
        My bare face is in the air. The morning is cold against the cheekbones. People are looking. Some keep looking. Some look away. One older man slows down and watches me pass, his expression unreadable behind his visor. I do not look at him. I walk.
    - gate4 == "suit_no_deco":
        The empty shoulder catches the morning light. A few suit-cams auto-zoom, briefly, on the absence. I do not look back at them.
    - gate4 == "re_enter":
        I look at the morning the way I did not look at it yesterday. The way the light hits the side of the building. The patches of grass at the curb where the rain has gone. I have not changed how I am dressed. I have changed what I am doing inside the dressing.
}

-> the_curb


= the_curb

The curb comes up. The ant hill is still there, in its half-crushed state. The rebuilders have made progress overnight. The cone is most of the way back, slightly smaller than it was the morning before yesterday.

I slow for two breaths. Then keeps walking. The hill will be itself again by tomorrow.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry. {protagonist_name} has no suit on.) | HOMEROOM in 9 minutes. }

-> arrival


= arrival
# bg: hallway-day
# art: school-exterior

The morning corridor. Suits filing in through the main doors in twos and threes, the way they do every morning.

I walk in.

The first ten meters: heads turn. A few. Some not at all. Some that turn quickly and turn quickly back.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry. {protagonist_name} is bare.) | Pace: nominal. Bio-irregularity logged across approximately 14 nearby suits. }

-> tae_meets


= tae_meets
# char: tae warm

Tae is at her locker.

Tae sees me.

{
    - gate4 == "stay_out":
        Tae's face does a series of things in the half-second before she has a chance to compose it. Surprise. Fear. Something that is neither. Then she sees my face. Both eyes, the whole face, the constellation of two freckles on the left cheek. And she closes the locker softly and walks toward me.
        # speaker: tae
        Oh.
        # speaker: tae
        Oh. {protagonist_name}.
        She is not telling anyone. Her hand goes up toward her wrist-comm, then away again. She has decided not to flag this.
        # speaker: tae
        Walk with me?
        # speaker: wren
        Yeah.
        We walk to homeroom together, in the same hallway, one of us in plain clothes, one of us in coral, neither of us faster than the other.
    - gate4 == "suit_no_deco":
        Tae sees the empty shoulder. She does not say anything immediately.
        # speaker: tae
        Hi.
        # speaker: wren
        Hi.
        She has her case of stickers in her bag. I can see the outline of it. Her hand goes to the bag. Her hand comes back to her side.
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
        We walk to homeroom together. Tae does not bring out the case. The empty shoulder is the empty shoulder. Tae does not look away from it. Tae does not stare at it.
    - gate4 == "re_enter":
        Tae sees the peach. Tae sees the mint accent at the rim. Tae sees the eyes behind my visor.
        Tae knows something is different. She does not know what.
        # speaker: tae
        You look good.
        # speaker: wren
        Yeah?
        # speaker: tae
        Yeah. Better than yesterday actually. The placement is. It's the same as yesterday but it's better. I don't know.
        # speaker: tae
        Are you okay?
        # speaker: wren
        Yeah.
        # speaker: wren
        Tae. Yeah.
        Tae does not ask further. She has the half-feeling that a question would close the door.
        We walk to homeroom together, in the same hallway, both in coral and peach, mint accents at the rim, neither of us faster than the other.
}

-> ozaki_passes


= ozaki_passes
# char: ozaki neutral

Across the wide corridor, near the dexterity-hall door, Mr. Ozaki is talking to another teacher. He sees me.

He does not pause his conversation.

But he meets my eyes. Through the visor or without, depending on whether I have one. And he nods once. Small. Not making it into a thing.

I nod back.

The other teacher does not notice.

Ozaki goes back to his conversation.

-> mocked_student


= mocked_student
# char: wren

Up ahead, the freshman girl in the faded-blue suit is at her locker. The one with the one star sticker.

She sees me.

{
    - gate1 == "speak":
        She holds my gaze for a longer moment than necessary. The kind of look you give a person when you are trying to say something without saying it. Then she nods. Very small. And goes back to her locker. The one star sticker on her shoulder catches the corridor light.
    - else:
        She holds my gaze for the length of a breath. Then she looks down and goes back to her locker.
}

I walk past.

-> cael_silent


= cael_silent

At the back of the corridor, near the homeroom doorway, Cael is standing with his usual group. He sees me.

He sees me.

He does not have a script for this.

His mouth opens. For half a second, the start of a sentence forming. And then closes. He turns to one of the kids beside him and say something I cannot hear. The kid laughs, but a beat late, because the kid is also looking at me.

Cael does not look at me again as I pass.

This is the closest thing to grace Cael will produce today, and he does not know it.

-> homeroom_door


= homeroom_door

Tae is still beside me at the homeroom doorway.

# speaker: tae
After class, can we. Just walk somewhere. Anywhere.

# speaker: wren
Yeah.

# speaker: tae
Okay.

# speaker: hud
{ gate4 == "stay_out": (no HUD entry.) | HOMEROOM begins. }

-> coda
