// scenes/12-the-door.ink — Scene 12: "The Door" (~3 min, ~6 min on "tae" path)
//
// Pacing: slow. The held silence is the point.
// GATE 3 (major): seek Iris (→ 13a) / stay (→ 13b) / message Tae (→ 13c).
// The "tae" path embeds the Tae visit in this scene before diverting to
// the climax, per outline.md.

=== the_door ===
# scene: 12
# pacing: slow
# voice: bare

-> the_room


= the_room
# bg: bedroom-night
~ wren_in_suit = true
# char: wren neutral

Wren's room. The same room as last night. The desk lamp on. The window dark.

Wren is sitting on the edge of the bed, still in the suit. The suit has been on all evening — through the walk home, through dinner with the kitchen empty, through the long sit at the desk that did not become homework.

Tonight the suit has not come off.

The external HUD — the small handheld that mirrors the suit's notifications when needed — is face-down on the desk.

-> the_pause


= the_pause

Wren has been sitting like this for a while.

The clock on the wall changes.

The clock changes again.

The clock changes again.

Outside the window, a car passes very far away.

Wren does not move.

Wren has been thinking — without thinking, the way you think when you have stopped trying to direct your own thinking — about the song. About the bench. About the bar of something a grandmother used to hum at a sink.

Wren has been thinking about the way the chest seal cracked open today and how cold air felt on the collarbone.

Wren has not let either thought finish.

The room is quiet.

-> the_choice


= the_choice

Wren could put the suit on. Wren could walk to where Iris is. Wren has a guess about where Iris would be, on a night like this.

Wren could stay here. Wren could just sit. Wren could be alone with what is happening.

Wren could message Tae. Tae would come over. Tae would be warm. Tae would not let it be heavy unless Wren made it heavy.

+ [Put the suit on. Go find Iris.]
    ~ gate3 = "iris"
    -> path_iris
+ [Stay. Be alone with it.]
    ~ gate3 = "stay"
    -> path_stay
+ [Message Tae.]
    ~ gate3 = "tae"
    -> path_tae


= path_iris

Wren stands.

The suit is already on. The HUD reads cool. Calendar: nothing. Weather: clear, cool, dew expected after midnight.

Wren goes to the door. Wren has guessed where Iris is. The guess feels like a place Wren has known how to find for a long time without knowing it.

The door closes behind Wren.

-> climax


= path_stay

Wren does not stand.

The clock changes.

The clock changes.

After a minute Wren stands up. Not to leave. To go to the suit in the cradle.

-> climax


= path_tae

Wren picks the HUD up off the desk. Turns it face-up.

Wren opens the message thread with Tae. The cursor blinks for a long time. Wren writes —

# speaker: hud
TYPING: are you up?

Wren sends it.

Three seconds later, the reply.

# speaker: hud
TAE: yeah. you ok?

# speaker: hud
TYPING: can you come over

# speaker: hud
TAE: omw.

-> the_visit


= the_visit
# char: tae warm
# art: tae-from-doorway

Tae is at the door in less than ten minutes.

She is in her suit but without decoration — she has come straight from her room, the chest plate plain coral, no rhinestones, no pin. Her helmet visor is half-lifted in the casual way she only does at home or in cars. One gauntlet is off. Her right hand is bare.

# speaker: tae
Hi.

# speaker: wren
Hi.

# speaker: tae
You said come, I came.

# speaker: wren
Yeah. Thanks.

They sit on Wren's bed, on opposite ends, the way they did when they were nine.

Tae does not push. She does not ask "what's wrong" the way a worse friend would. She is just sitting there.

# speaker: tae
Tell me a thing. Any thing. I'll do the rest.

Wren tries.

# speaker: wren
I—

# speaker: wren
something happened today. With the suit. The chest seal—

# speaker: wren
no, I—

# speaker: wren
sorry. Never mind.

# speaker: tae
Okay.

Tae waits, in case more is coming.

More is not coming. Wren can feel it almost coming, and Wren can feel themselves stop it. Wren cannot tell if Wren is stopping it for Tae's sake or for Wren's own.

# art: bare-hands-clasp
After another minute Tae reaches across the bed with her bare right hand and finds Wren's gauntleted left. She presses the bare hand against the armor where Wren's knuckles are. Then she waits.

Wren slips the left gauntlet off. Slowly. The seal at the wrist breaks with a small hiss. Wren's bare hand comes out into the room air.

Tae takes Wren's bare hand in her bare hand. The two of them are still in their suits, mostly. Just hands.

# speaker: tae
Whenever you can. Okay? Whenever you can.

# speaker: wren
Yeah.

Tae stands up. Looks at Wren one more time. Looks at the suit in the corner of the room.

# speaker: tae
I love you, weirdo.

# speaker: wren
You too.

Tae goes.

The door closes behind her.

The gauntlet stays off the desk where Wren had set it down. Wren does not put it back on.

-> after_tae


= after_tae

The room is quieter than it was before Tae was here.

The almost-said sentence is still in the air. Wren can almost see it.

After a while Wren stands. Not to leave. To go to the suit in the cradle.

-> climax


= climax

{ gate3 == "iris":
    # speaker: hud
    Walking. ETA — north field — 12 minutes.
- else:
    # speaker: hud
    Suit standby. The bedroom is yours.
}

-> step_outside
