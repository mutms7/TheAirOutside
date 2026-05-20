// scenes/06-evening.ink — Scene 6: "Charging" (~5 min)
//
// Pacing: slow (the scene needs the doing-nothing minute to breathe).
// Branches by Gate 2:
//   approach — Iris has sent a single "?" message; Wren does not reply
//   avoid    — no message; the same held silence carries a different weight
// Both paths plant Motif 4 reappearance: the song surfaces as a half-memory
// of Wren's grandmother humming in a kitchen. In approach it lingers; in
// avoid Wren shuts it down faster.
//
// Texture choice (S): what to do with the day's decoration before bed.
// Feeds into Scene 7's morning framing.

VAR evening_decoration_choice = ""

=== evening_charging ===
# scene: 6
# pacing: slow
# voice: bare

-> arrival_home


= arrival_home
# bg: bedroom-night
~ wren_in_suit = false
# char: wren bare

Wren's bedroom in the evening. The desk lamp is on. The window is dark — the rain has stopped, but the glass still has water-marks down the side.

The suit stands open in its cradle. The chest plate hinged back, the leg sleeves flexed open at the knees, the small charge indicator pulsing slow.

Wren takes the helmet off last. Sets it on the rest.

The bedroom is quiet in a way that is different from the suit being quiet.

{ gate2 == "approach":
    -> path_message
- else:
    -> path_no_message
}


= path_message

# speaker: hud
NEW MESSAGE — IRIS QUINT (unverified contact).

# speaker: hud
"?"

Just the question mark. Nothing else.

Wren reads it.

Wren does not reply.

Wren marks the message unread. Then read. Then unread again.

Wren leaves the HUD on the desk, face-down on the lamp's wood surface.

-> the_desk


= path_no_message

The HUD is empty. No pings. The group chat is moving — Tae has posted something about Friday's accent plan — but Wren has not opened it.

Wren sets the HUD on the desk, face-down on the lamp's wood surface.

-> the_desk


= the_desk

Wren sits down at the desk.

The clock on the wall changes.

The clock changes again.

The clock changes again.

Wren has not done anything.

Wren has not opened the homework. Wren has not picked up the water glass that is sitting near the lamp. Wren has not turned.

Outside the window, a car passes very far away.

-> the_song


= the_song
# motif: song-grandma

A bar of something surfaces in Wren's head.

A shape, like a melody. Not the boot tune. Not anything on the suit.

For a half-second, Wren remembers a kitchen. Their grandmother humming while she did something at the sink. Wren was small. Wren did not know what the song was. Wren never asked.

{ gate2 == "approach":
    The memory lingers.

    Wren tries to follow the bar. Tries to remember what came after it. Cannot.

    The memory ends, but Wren does not push it away. The bar is somewhere in Wren's head, still, when Wren stops trying.

- else:
    Wren shuts it down.

    Wren stands up from the desk. The chair scrapes. The memory closes like a door.

    Wren picks up the water glass and drinks from it. The water tastes flat.
}

~ song_state = 3

-> decoration


= decoration

# art: wren-bedside-drawer
Wren turns to face the suit.

The peach sticker from this morning catches the lamplight on the shoulder plate. The mint crescent at its rim is exactly where Tae put it.

+ [Leave the decoration on.]
    ~ evening_decoration_choice = "left"
    -> path_leave
+ [Take it off.]
    ~ evening_decoration_choice = "removed"
    -> path_remove
+ [Replace it with something else.]
    ~ evening_decoration_choice = "swapped"
    -> path_swap


= path_leave

Wren leaves the sticker where Tae put it.

The suit closes its chest plate slowly to standby. The seal-glow runs once around the rim and dims.

The peach sticker sits there, catching the lamp.

-> sleep


= path_remove

Wren reaches out. With the bare hand. The shoulder plate is cooler than the air.

Wren peels the sticker off — slowly, because the adhesive is doing its job. The mint crescent comes off intact. Wren sets it on the desk, sticker-side up.

The shoulder plate is bare now. The seal-glow runs once around it and dims.

Wren looks at the sticker on the desk for a moment.

Wren does not throw it out.

-> sleep


= path_swap

Wren opens the small drawer of the desk.

Inside: a few stickers Wren has been keeping for no particular reason. Three of them, all small, none of them on-trend. One of them is older than the others — a plain pale green crescent, no brand markings. Wren cannot remember where it came from.

Wren peels the peach sticker off the shoulder plate. Sets it on the desk.

Wren puts the pale green crescent on the shoulder. It sits a little crooked. Wren straightens it. It is still a little crooked.

The seal-glow runs once around the rim, registers the swap, and dims.

# speaker: hud
Decoration registered.

-> sleep


= sleep

Wren turns the lamp off.

In the dark, the suit's standby light pulses slowly. The room is very quiet.

# speaker: hud
Sleep mode. Suit charging. Calendar tomorrow: HOMEROOM at 7:30.

-> crushed
