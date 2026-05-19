// scenes/02-homeroom.ink — Scene 2: "Stickers" (~4-5 min)
//
// Pacing: normal default.
// Establishes: homeroom, desks-as-charging-bays, Tae as decorator-maintainer,
// Cael holding court loud in the background, the janitor at the doorway.
// Lands Motif 2 (the sticker) first appearance. Plants Motif 4 reappearance
// (janitor's hum reaches Wren faintly; Wren does not register it).
// Bio-monitor blip when Wren laughs at a Cael joke they don't find funny.
//
// Branch: small texture-only choice on the sticker. All paths end with a
// sticker applied; Tae's response and Wren's interior weight differ.

=== homeroom ===
# scene: 2
# pacing: normal
# voice: modulated

-> arrival


= arrival
# bg: classroom

The homeroom is filling up. Suits move into their assigned desks, the small hiss of hip-seals locking into the charge contacts under each chair.

# speaker: hud
DESK 14B: docked. Suit power 99%.

Wren sits down. The pin clicks. The seal-glow flickers, settles.

# char: tae warm

Tae is one row over, already seated, suit shimmering — a fresh coral sticker on the left shoulder, three stacked rhinestones along the collar, the small enamel pin she has worn every day this term.

# speaker: tae
There you are. You scared me with that pause. Are you sleeping enough?

# speaker: wren
Yeah. I'm—

# speaker: wren
fine.

# speaker: tae
You'd tell me, right? If you weren't?

# speaker: wren
Yeah.

# speaker: tae
Good. Because I would notice. I do notice.

Tae's voice is warm. She is not interrogating. She is loving Wren in the only language she knows how to speak.

-> cael_background


= cael_background
# audio: cael-court

Across the room, Cael is holding court at the back desks. Four or five of the front-row kids are angled to face him.

# speaker: cael
— and I told him, *that sticker*? That exact sticker? My grandfather had that. On his *charging cradle*. So.

A small ripple of laughter from the back row.

Wren laughs too. A short, polite, suit-warmed laugh.

# speaker: hud
Bio-irregularity logged. (Vital nominal.)

The HUD does not flag the laugh. It does not flag anything. The line scrolls past with the timestamp and is gone.

Tae glances at Cael without turning her head. The smallest amount of her mouth tightens. Then it doesn't.

-> the_sticker


= the_sticker

# speaker: tae
Okay. Ready? Peach today. Mint accent. I've been looking forward to this all morning, you have no idea.

# motif: sticker-applied-preview
~ sticker_state = "applied"

Tae produces it from a small case. A small enamel-finish circle, peach-bodied, a thin mint crescent at the rim. Subtle by Tae's standards. Loud by anyone else's.

She holds it up between two fingers. It catches the homeroom light.

# speaker: tae
I think this one is *you*. Trust me.

+ [Wear it as Tae suggests.]
    -> path_yes
+ [Ask if the mint could go on the cuff instead.]
    -> path_variant
+ [Politely decline a sticker today.]
    -> path_decline


= path_yes

# speaker: wren
Yeah. It's nice.

# speaker: tae
*Thank* you.

Tae leans across. Her gloved fingers — the same coral as her own decoration — smooth the sticker onto Wren's shoulder plate.

# speaker: tae
There. Beautiful. Don't pick at it. I will see if you pick at it.

# speaker: wren
I won't.

-> after_sticker


= path_variant

# speaker: wren
Could the mint go—

# speaker: wren
on the cuff instead?

Tae's smile holds, but something in it adjusts. A measured pause.

# speaker: tae
The cuff. Asymmetric. Hmm.

# speaker: tae
The asymmetric thing is coming back. Next week. Not this week. Trust me, just this week, shoulder.

# speaker: wren
Okay.

Tae leans in. The peach goes on the shoulder. The mint crescent settles at the rim, exactly where Tae put it.

# speaker: tae
Next week we'll experiment. Promise.

-> after_sticker


= path_decline

# speaker: wren
Maybe today I could—

# speaker: wren
just go plain?

Tae's face moves the smallest amount.

# speaker: tae
Plain? Today?

Tae is looking at Wren with concern. Real concern. The smile is still there but it is doing different work.

# speaker: tae
Okay. Okay. You don't have to do the peach. But here — just this one then.

Tae reaches into her case again and pulls out something smaller. A thin enamel arc, the same peach, half the size.

# speaker: tae
You can't go fully bare, Wren. Cael will say something. I don't want him to say something.

Tae presses the smaller sticker onto Wren's shoulder. Her hand stays on the plate a half-second longer than she needs it to.

# speaker: tae
Is something wrong? You can tell me.

# speaker: wren
No.

# speaker: wren
I'm fine.

-> after_sticker


= after_sticker

The sticker sits warm against the shoulder plate. The suit's seal-glow flickers around the new edge for a second, recognizing the attachment, and settles.

# speaker: hud
Decoration registered.

-> the_doorway


= the_doorway

At the open doorway of the classroom, someone passes with a cleaning cart.

# motif: song-foreshadow

It is the janitor. She does not look in. She is humming something to herself, very quietly, the way a person hums while they work.

For a half-second the shape of the hum reaches Wren under the room's noise.

A different shape than the boot tune. Different than the chimes of the suits sealing into their charge contacts. Different than the music coming through someone's helmet speaker two desks over.

Wren does not register it.

The janitor passes on down the hallway. The hum goes with her.

-> bell


= bell

# sfx: bell-soft
# audio: homeroom-bell

A soft chime in the room and in every suit's HUD at once. Homeroom is starting.

Tae faces forward. The teacher's voice begins from the front of the room, something about attendance, something about Friday.

Wren looks at the new sticker on their shoulder.

It catches the light a little.

# speaker: hud
HOMEROOM begins. Calendar next: DEXTERITY in 47 minutes.

-> dexterity_pe
