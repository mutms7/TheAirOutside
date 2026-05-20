// scenes/13-step-outside.ink — Scene 13: "Step Outside" — the climax (~6-8 min)
//
// Pacing: slow throughout. This is the only scene that uses the climax-window
// pause line (mechanics.md Candidate C). The line "Look up if you'd like…" is
// tagged with # pause: climax-window. The renderer detects that tag and:
//   - hides all other UI, fades the screen to a single still composition
//   - disables auto-advance
//   - waits for a single click anywhere to continue
//   - no skip-counter, no minimum dwell
//
// Three variants by Gate 3:
//   gate3 == "iris" → climax_iris   (outdoor field, Iris as witness)
//   gate3 == "stay" → climax_alone  (bedroom, alone)
//   gate3 == "tae"  → climax_after_tae (bedroom after Tae has left)
//
// Iris's one-sentence reveal lives in climax_iris. It is the heaviest line in
// the script. Soul constraint: existential darkness, never violent.

=== step_outside ===

{
    - gate3 == "iris":
        -> climax_iris
    - gate3 == "tae":
        -> climax_after_tae
    - else:
        -> climax_alone
}


= climax_iris
# scene: 13
# pacing: slow
# voice: modulated
# bg: bedroom-night

The walk to the north field takes twelve minutes.

The suit's gait coordination smooths the pace. The HUD goes quiet — no pings tonight, no calendar entries, the weather steady. Wren walks past the chain-link fence behind the athletic complex, down the small slope, into the trees.

# bg: field-night
# char: iris bare

The clearing is in moonlight. Iris is already there.

# art: fallen-tree-trunk
She is sitting on the trunk of a fallen tree — the only seat. She has not lit anything. She does not stand when Wren arrives. She does not turn.

She makes a small motion of one bare hand toward the trunk beside her.

Wren walks to her. Sits.

The grass is wet. The air smells like wet grass and trees.

# speaker: hud
GPS — outside school grounds. Suit standby. No active sensors.

They are quiet for a long time.

-> iris_removal


= iris_removal
# pacing: slow

Then Wren reaches up and finds the chest plate's release.

# sfx: suit-unseal

The chest plate hinges back.

The seal at the collarbone breaks. Cool air on the bare skin Wren did not let touch air this morning. The collarbone where the seal cracked open in the corridor today.

Wren takes the leg sleeves off. Bare ankles. The wet grass is colder than expected.

The right gauntlet. Then the left.

The helmet last. The helmet last.

# sfx: helmet-lift

Wren lifts it off.

~ wren_in_suit = false
# char: wren bare

Iris turns. Iris looks at Wren's face.

Iris's face is uncovered too. The two of them are looking at each other for the first time.

The clearing is very quiet.

-> iris_pause


= iris_pause
# motif: rain-bare
~ rain_state = 3
# audio: bare-night-field

It is not raining now. But the air is the kind that rain has just been in. Damp. Cool. Smelling of trees and turned earth.

The wind moves through the trees once. The branches respond. The branches stop. The wind moves through them again.

A small night-animal moves through brush, somewhere a long way off.

# pause: climax-window
Look up if you'd like. Take in one ordinary thing where you are. Come back when you're ready.

-> iris_after_pause


= iris_after_pause

Wren has been sitting with their bare face open to the air for some time.

Wren's hands are open on their lap, palms up. The HUD is on the trunk beside the helmet. The HUD has been logging nothing since the suit standby.

Wren may have cried. The narration does not press.

Iris is still there. Her bare hand is on the trunk between them, not reaching, not pulling away.

After a long time, Iris speaks. Once.

# speaker: iris
My mother died last year.

# speaker: iris
I had not let her see my face in two years.

# speaker: iris
I was wearing the helmet when she went.

She does not look at Wren when she says it. She does not need to.

The clearing is still.

-> iris_close


= iris_close

Wren does not say anything.

Iris does not need Wren to.

After another while, the two of them get up — without speaking — and Wren begins to dress.

# sfx: suit-seal

The chest plate closes. The seal warms. The hum of standby begins again under the skin of the suit.

Wren leaves the helmet off for the walk back. Iris walks part of the way with Wren, through the trees, in plain clothes, with bare hands and a bare face. At the chain-link fence she stops. Wren stops too. They look at each other once more.

# speaker: iris
Go home, Wren.

# speaker: iris
Sleep.

Wren goes.

-> after_climax


= climax_alone
# scene: 13
# pacing: slow
# voice: modulated
# bg: bedroom-night
# char: wren neutral

Wren is in the bedroom. The suit is on. The room is the same room.

Wren stands.

Wren walks to the long mirror on the back of the closet door. The mirror Wren almost never uses.

Wren looks at the suit in the mirror. At the visor. At the place where Wren's face would be, if the suit were not in the way.

Wren reaches up to the helmet's release.

# sfx: helmet-lift

The helmet hisses, lifts back.

Wren sets it on the desk, beside the external HUD, which is still face-down.

# sfx: suit-unseal

The chest plate hinges open. The leg sleeves come off in turn. The right gauntlet. The left one is already off, where Wren has not put it back on since Tae left this evening — except Tae did not visit. The left one is already off from earlier in the day, then. Or it was off because Wren had taken it off to scratch a knuckle that did not need scratching.

Wren removes the suit in pieces. Each piece set down on the floor with the seal-glow running once around its rim, registering the disconnect.

It takes a few minutes. The suit is not designed to be removed all at once.

Wren is standing in the bedroom in the plain undersuit they almost never see.

~ wren_in_suit = false
# char: wren bare

The room is the same room.

The window is the same window.

Wren walks to the window. Opens it.

# audio: bare-night-bedroom
# art: wren-window-open

The air outside the window comes in. Cool. The smell of wet pavement, faintly, where the rain has been earlier.

-> alone_pause


= alone_pause

# pause: climax-window
Look up if you'd like. Take in one ordinary thing where you are. Come back when you're ready.

-> alone_after_pause


= alone_after_pause
# motif: song-hummed-aloud
~ song_state = 4

Wren does not know they are humming until they are humming.

The first bar of it. The bar from yesterday morning — the bar that surfaced under the boot tune for one breath before Wren noticed it.

Wren's actual voice. Without the modulator. The voice is quieter than the modulator made it sound. A little flatter. A little rough. Wren's actual voice.

Wren hums it once.

Wren hums it twice.

The third time, Wren tries to remember the bar that comes after it. The bar Wren tried to remember at the desk last night. The bar the janitor was humming tonight.

It comes. Most of it. Wren hums it through.

Wren stays at the window for a while.

The HUD on the desk does not log any of this. The suit on the floor does not log any of this. There is no record of the song being hummed except in the air of the bedroom, and the air has nowhere to keep it.

-> after_climax


= climax_after_tae
# scene: 13
# pacing: slow
# voice: modulated
# bg: bedroom-night
# char: wren neutral

The room is quieter than it was before Tae was here.

The almost-said sentence is still in the air. Wren can almost see it, the way the steam from the strawberry water sat above the glass tonight at Tae's.

The gauntlet Tae held the hand of is still on the desk.

Wren stands. Walks to the long mirror on the back of the closet door.

Wren looks at the suit in the mirror.

Wren reaches up to the helmet's release.

# sfx: helmet-lift

The helmet hisses, lifts back. Wren sets it on the desk next to the gauntlet.

# sfx: suit-unseal

The chest plate. The leg sleeves. The right gauntlet, joining the left where it has been since Tae left.

Wren removes the suit in pieces. The almost-said sentence is in the room with Wren while Wren does this. The room makes space for it.

~ wren_in_suit = false
# char: wren bare

Wren is standing in the bedroom in the plain undersuit they almost never see.

Wren walks to the window. Opens it.

# audio: bare-night-bedroom

The air outside the window comes in.

-> after_tae_pause


= after_tae_pause

# pause: climax-window
Look up if you'd like. Take in one ordinary thing where you are. Come back when you're ready.

-> after_tae_after_pause


= after_tae_after_pause
# motif: song-hummed-aloud
~ song_state = 4

Wren hums the bar from yesterday morning.

Then the bar after it. The two bars together, the way they were meant to go together.

Wren's actual voice. A little flatter than the modulator made it sound. A little rough.

The almost-said sentence does not need to be said now. It has done its work by being almost-said. Tae knows. Tae will know that Tae knows, tomorrow.

Wren stays at the window for a longer while than they would have if Tae had not come over tonight.

The HUD on the desk does not log any of this. The suit on the floor does not log any of this.

-> after_climax


= after_climax

The night goes on.

Eventually Wren sleeps. The window stays open. The wind moves the curtain very slightly, every so often.

-> next_day
