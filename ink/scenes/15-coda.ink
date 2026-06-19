// scenes/15-coda.ink — Scene 15: "Watching" (~4-5 min)
//
// Pacing: slow-default.
// Three variants by Gate 4. All end on the same image — a single ant carrying
// something three times its size — but the camera angle, who is in the wide
// shot, where the sticker ends up, and whether the hum is in the air or in the
// suit's audio differ.
//
// Motif 1 third state: ant_state = 3 (eye-level if Wren is bare; deliberately
// zoomed if Wren is suited).
// Motif 2 final state: sticker_state =
//   "window"     (15a, on the corridor windowpane)
//   "drawer"     (15b, in Wren's bedside drawer)
//   "reapplied"  (15c, back on the shoulder)
// Motif 4: in 15a, the hum is in the air, carried by more than one voice.
// In 15b, the hum is at the window, in Wren's actual voice, quieter. In 15c,
// the hum is inside the suit's audio — heard by the player, not by Wren's
// neighbors. The story's promise: Wren will step out again, eventually.

=== coda ===

{
    - gate4 == "stay_out":
        -> coda_stay_out
    - gate4 == "suit_no_deco":
        -> coda_no_deco
    - else:
        -> coda_re_enter
}


= coda_stay_out
# scene: 15
# pacing: slow
# voice: bare
# bg: street-morning

After school. The afternoon light is long and slanting through the trees along the side of the building.

I am walking home. In plain clothes, bare-faced. Iris is walking beside me as far as the corner. Iris will turn off there. We have not spoken much this afternoon. We have not needed to.

# char: iris bare

At the curb. The same curb. I stop.

The ant hill has been rebuilt. The cone is whole again, slightly smaller than before. Tread-print gone or covered.

# motif: ant-hill-eye-level
~ ant_state = 3

I kneel.

The suit-cam is not auto-zooming because I have no suit-cam. My eyes are doing the looking, without an interface.

An ant climbs the side of the hill carrying a grain. Reaches the top. Sets it down. Goes back.

Another ant comes out the other way, with a different grain.

# char: wren bare

Iris is standing beside me, looking too. She does not narrate. She does not tell me what to see.

-> stay_out_tae


= stay_out_tae
# char: tae warm

Down the sidewalk, Tae is walking the other way. Home, probably, after her own afternoon thing. Tae sees me and Iris at the curb.

Tae stops. Tae looks.

She is in full coral. The new pin shipped. It is on her collar. The decoration is more than yesterday's.

Tae does not look away.

She does not come over. She does not call out. She just stops walking, looks, and holds the look.

It is the most she will give today. I can tell that it is real.

After a long beat, Tae lifts a hand at me. Small, almost a wave, more like the hand-lifting you do when you are letting somebody go.

I lift a hand back.

Tae walks on.

-> stay_out_janitor


= stay_out_janitor
# char: janitor neutral
# art: service-class-woman

A minute later, the janitor passes the curb on the way home from work. Her cleaning cart has been left at the school for tomorrow. She is carrying a small bag. Her suit is service-class gray, and against the long afternoon light it is the only saturated thing in the wide shot. Not because her color is loud, but because everyone else has gone neutral inside my decorations.

She sees me and Iris at the curb.

She does not stop walking.

She nods. Small. Held for a beat longer than a polite nod.

She is humming.

It is the song.

# motif: song-final
# audio: hummed-bar-final

For a half-bar, Iris hums it under her breath too.

For a half-bar, I hum it.

The three hums overlap on the sidewalk for the length of two seconds. The janitor's clear, Iris's a little quieter, my quieter still. And then the janitor is past, and the hum goes with her down the sidewalk.

Iris squeezes my bare shoulder once, very lightly. She turns off at the corner. She does not look back.

-> stay_out_sticker


= stay_out_sticker
~ sticker_state = "window"

I walk home alone.

In my pocket: the peach sticker from the cafeteria yesterday. The one Tae put on me. It has been in my pocket since last night when I removed the suit in the field.

# motif: sticker-window

# art: corner-brick-window
At the next-to-last block before home, there is a corner window in a brick wall. A corner window with no glass left, just the open frame, the kind of corner-of-a-building window that nobody uses.

I stop.

I peel the backing off the sticker and press it onto the brick at the corner of the empty frame, where the brick is rough enough to hold it.

The peach catches the long light. The mint crescent at the rim. It will probably fall off within a year.

That is fine.

-> stay_out_final


= stay_out_final
# motif: ant-hill-eye-level

I walk the last block.

I am thinking, without thinking, about the ant on the hill.

The narration follows.

The ant is small. It is carrying a grain of something three times its size. It is climbing the side of the hill. It slips. It climbs again.

It does not know anyone is watching.

It does not need anyone to watch.

But it is being watched.

That is the end.

-> epilogue_dispatch


= coda_no_deco
# scene: 15
# pacing: slow
# voice: modulated
# bg: street-morning

Late afternoon. I am walking home from school, suit on, shoulder bare.

A handful of other shoulders, in the foot traffic around me, are also bare. Not many. Three, maybe four, in the field of view of the suit-cam. More than there were yesterday.

One of them is a freshman boy I have never spoken to. He sees my bare shoulder, then his own, then looks away with a small breath that the suit's bio-monitor records and dismisses.

-> no_deco_curb


= no_deco_curb
# motif: ant-hill-eye-level
~ ant_state = 3

The curb.

I stop. The visor lifts. A private gesture, the same one the cafeteria uses for eating. And I am looking at the ant hill with the visor up, the suit-cam not running.

The hill is rebuilt. The cone is whole again.

An ant climbs the side carrying a grain. Reaches the top. Sets it down.

I watch.

I watch a long time.

The HUD does not log this because the helmet is open and the suit's sensors are partially offline by design.

-> no_deco_sticker


= no_deco_sticker
~ sticker_state = "drawer"
# motif: sticker-drawer

That evening, in the bedroom, I open the drawer in the desk. The small one with the few stickers I have been keeping for no particular reason.

I add the peach to it. The one Tae put on yesterday. The mint crescent at the rim.

I close the drawer.

The drawer is small enough that the sticker will be there if I ever opens it again, and absent enough from daily use that I will not see it tomorrow morning.

I leave the empty shoulder. I do not pick up a different sticker.

The window is open again. The night air is in the room.

# motif: song-final
# audio: hummed-bar-final

I hum, very quietly, the bar from yesterday morning and the bar that comes after it.

In my actual voice. With the helmet off.

The window does not need to be open for the sound to leave. But I have opened it anyway.

-> no_deco_final


= no_deco_final

The narration follows the image one more time.

The ant climbs. Carries a grain three times its size. Slips. Climbs again.

It does not know anyone is watching. It does not need anyone to watch.

But it is being watched.

That is the end.

-> epilogue_dispatch


= coda_re_enter
# scene: 15
# pacing: slow
# voice: modulated
# bg: street-morning

Late afternoon. I am walking home from school in full peach. The mint crescent at the rim of the shoulder. The suit reading nominal.

Tae was beside me for the first three blocks. Tae is gone now, toward her own street.

-> re_enter_curb


= re_enter_curb
# motif: ant-hill-eye-level
~ ant_state = 3

The curb.

I stop walking.

The suit-cam is at standby. It has not auto-zoomed today, because the day has been ordinary, no out-of-pattern movement to flag.

I reach up to the wrist control. Manually.

I initiate a zoom. I am the one doing it now.

# speaker: hud
Manual auto-zoom. Subject: ant hill, curb level.

The HUD narrows its reticle on the rebuilt cone. Inside the visor, the image is large. Magnified. Steady.

An ant climbs the side of the hill carrying a grain. Reaches the top. Sets it down. Goes back.

Another ant comes the other way with a different grain.

I watch.

I have chosen to watch. The suit is mediating, but I am doing the choosing.

-> re_enter_sticker


= re_enter_sticker
~ sticker_state = "reapplied"

The sticker is on my shoulder. The same peach. The same mint accent. The same placement, exactly.

But I put it there this morning. I chose it.

The seal-glow runs once around the rim. I have been wearing it all day. And settles.

-> re_enter_hum


= re_enter_hum
# motif: song-final
# audio: hummed-bar-final-internal

Inside the suit, the boot tune is past. The HUD is silent. The bio-monitor is reading nominal.

The audio track plays the hum.

It is in my head. I am not humming aloud. Not yet, not today.

The player hears it. I hear it. The world does not hear it.

That is enough for now. That is honest.

One day, I will step out again. The clearing will still be there. The window will still open. The song will still be the song.

But not today.

-> re_enter_final


= re_enter_final

The narration follows the image one more time.

The ant climbs. Carries a grain three times its size. Slips. Climbs again.

It does not know anyone is watching. It does not need anyone to watch.

But it is being watched.

That is the end.

-> epilogue_dispatch
