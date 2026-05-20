// scenes/16-epilogue.ink — Final epilogue dispatch + 9 ending knots
//
// Every coda variant ends with -> epilogue_dispatch.
// This file routes the player to one of nine unique endings based on
// gate3 (the climax choice: iris/stay/tae) and gate4 (next-day:
// stay_out/suit_no_deco/re_enter). Each ending has its own title,
// closing paragraphs, and final art.

=== epilogue_dispatch ===
# scene: 16

{
    - gate3 == "iris" && gate4 == "stay_out":     -> ending_together_outside
    - gate3 == "iris" && gate4 == "suit_no_deco": -> ending_together_half_bare
    - gate3 == "iris" && gate4 == "re_enter":     -> ending_together_looking
    - gate3 == "stay" && gate4 == "stay_out":     -> ending_alone_outside
    - gate3 == "stay" && gate4 == "suit_no_deco": -> ending_quiet_step
    - gate3 == "stay" && gate4 == "re_enter":     -> ending_looking_again
    - gate3 == "tae"  && gate4 == "stay_out":     -> ending_out_with_friend
    - gate3 == "tae"  && gate4 == "suit_no_deco": -> ending_half_step_out
    - gate3 == "tae"  && gate4 == "re_enter":     -> ending_returning_changed
    - else: -> ending_quiet_step
}


// ──────────────────────────────────────────────────────────────────────────
// Iris paths × 3
// ──────────────────────────────────────────────────────────────────────────

=== ending_together_outside ===
# scene: 16
# pacing: slow
# voice: bare
# bg: street-morning
# art: epilogue-together-outside
# ending: Together, Outside

A year on, or close enough.

We walk together sometimes, when the weather is good.

Not every day. Iris has her quiet days and so do I. But when we do walk, we walk slow, and we look at the things along the curb, and we let the silence be a third person between us.

We are not telling anyone how to live. We are not telling anyone anything.

We are two people who took our helmets off and found that the world still held us. That is all. That is enough.

The ants are still on their hill.

The song is still being hummed by people I do not know.

I am one of them now.

That is the end.

-> END


=== ending_together_half_bare ===
# scene: 16
# pacing: slow
# voice: bare
# bg: hallway-day
# art: epilogue-together-outside
# ending: Together, Half-Bare

I wear the suit, most days, with nothing on it.

Iris does the same. We pass in the corridor, and the bare shoulders read each other before the eyes do.

We are not making a statement. We are not joining a movement. There is no movement.

There is only the morning, and the shoulder, and the small piece of the world where I used to put a piece of color, and where now the suit's surface catches the light in its plain coral-undertone.

It is the most honest thing I am able to wear right now. One day it might be less. One day it might be nothing at all.

For now, this is where I have arrived.

The ants are still on their hill.

That is the end.

-> END


=== ending_together_looking ===
# scene: 16
# pacing: slow
# voice: modulated
# bg: hallway-day
# art: epilogue-together-looking
# ending: Together, Looking

I am back inside the suit. Decorated, more or less the way I was before.

But I am the one looking, now. The cam zooms because I told it to. The HUD reports what I asked it to report. The voice-modulator is half a step warmer than my real voice and I know exactly what that costs.

Iris is also suited, when she has to be. She is also looking.

We pass in the corridor and we lift a hand, and Cael walks by and does not look at either of us, and the world goes on.

I am not free. Not yet, not all the way.

But I know that I am inside something, and I know what it is, and I will step out again, eventually.

The ants are still on their hill.

That is the end.

-> END


// ──────────────────────────────────────────────────────────────────────────
// Stay paths × 3 (alone climax)
// ──────────────────────────────────────────────────────────────────────────

=== ending_alone_outside ===
# scene: 16
# pacing: slow
# voice: bare
# bg: field-night
# art: epilogue-alone-outside
# ending: Alone, Outside

The bedroom window stays open more nights than not.

I sleep with my bare shoulder against the cold pillowcase and the cold air coming in over the windowsill.

Nobody has joined me. Nobody is supposed to.

I am not a teacher. I am not a movement. I am one fifteen-year-old who took off a suit one night and decided not to put it all the way back on the next morning.

Some days that decision feels small. Some days it feels like the only honest thing I have ever done.

The ants are still on their hill.

The song is still being hummed by people I do not know. I hum it sometimes too. In my own voice, with no helmet between the air and the tune.

That is the end.

-> END


=== ending_quiet_step ===
# scene: 16
# pacing: slow
# voice: modulated
# bg: hallway-day
# art: epilogue-quiet-step
# ending: A Quiet Step

I wear the suit. I do not decorate it.

My shoulder is bare in the way that Ozaki's shoulder has always been bare. Plain factory finish. Nothing on it.

People notice for a week. Then they do not.

That was always the surprising thing. How fast the thing you were afraid to do becomes the thing you simply do.

Tae and I are still friends. She still picks decorations for herself with the same care. She does not pick for me anymore. I do not pick anything either. Sometimes she catches my empty shoulder in the side of her eye and she does not say anything.

The ants are still on their hill.

That is the end.

-> END


=== ending_looking_again ===
# scene: 16
# pacing: slow
# voice: modulated
# bg: hallway-day
# art: epilogue-looking-again
# ending: Looking Again

I am inside the suit. Decorated, more or less the way I was the morning of the ant hill.

But I am the one looking now. That is the difference.

I look at the ant hill on the way to school. I look at the rain on the corridor windows. I look at Tae's gloved fingers when she presses the sticker onto my shoulder, and I let her do it, and I know exactly what I am letting happen.

The suit is the suit. It is not the enemy. The thing that was the enemy was always behind it.

I do not know when I will step out again. I know that I will.

The ants are still on their hill.

That is the end.

-> END


// ──────────────────────────────────────────────────────────────────────────
// Tae paths × 3
// ──────────────────────────────────────────────────────────────────────────

=== ending_out_with_friend ===
# scene: 16
# pacing: slow
# voice: bare
# bg: street-morning
# art: epilogue-out-with-friend
# ending: Out, With a Friend

Tae and I are still friends. That part did not break.

She is still in her coral, mostly. Sometimes a little less coral than last year. She would deny this. I do not point it out.

I am out of the suit, most days. Bare-faced on the walk to school. Bare-shouldered in the classroom.

She comes over on Tuesdays. She brings strawberry water. We sit at the desk in my bedroom and she does not pick at the empty mount on the shoulder of the suit that hangs in my cradle.

She is doing her own version of being seen.

I am doing mine.

The ants are still on their hill.

That is the end.

-> END


=== ending_half_step_out ===
# scene: 16
# pacing: slow
# voice: modulated
# bg: hallway-day
# art: epilogue-half-step-out
# ending: Half-Step Out

Suit on. Shoulder bare.

Tae comes by on Tuesdays. She brings strawberry water. She sits at my desk while I do homework, and she looks at the empty shoulder of my suit hanging in the cradle, and she does not say anything.

Once, she reached out and rested her bare hand on the empty mount, the way someone touches a frame where a photograph used to hang.

She did not bring it up again.

I think she might be carrying the weight of her own un-applied sticker home and back to school the same way I am carrying my bare shoulder. Different versions of the same morning.

We do not talk about it.

The ants are still on their hill.

That is the end.

-> END


=== ending_returning_changed ===
# scene: 16
# pacing: slow
# voice: modulated
# bg: classroom
# art: epilogue-returning-changed
# ending: Returning, Changed

I am back inside the suit. Tae picks the morning's sticker again. I let her, and I notice myself letting her, and I let her anyway.

This is also a choice. It is the choice of someone who has been outside the suit, briefly, and decided to step back in with the knowledge of what they stepped back into.

That is not the same as never having stepped out. That is the difference Tae will never have, until she has it.

The strawberry water glass sits on her desk on Tuesdays. The drawer in her room still holds the un-applied second peach. I have been in the drawer. She knows I have been in the drawer. We do not talk about it.

The ants are still on their hill.

The song is still in the suit's audio when I want it to be, and I want it to be more often than I used to.

One day I will step out again.

For now, this is where I am.

That is the end.

-> END
