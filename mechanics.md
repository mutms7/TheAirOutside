# Mechanics

This document covers two design problems:
1. The **step-outside pause** — the climax invitation into a real-world moment of stillness. Skippable. Emotionally weighted. Never coercive.
2. The **everyday-pacing mechanic** — small invitations to presence throughout the rest of the game, accumulating quietly so the climax pause is *earned* and not imposed.

Other mechanics (choice menu, save/load, accessibility) are out of scope for Phase 1 — designed in Phase 2 with the architecture.

---

## Design constraints (from the brief)

1. **Real-world pause.** The player should leave the screen, even briefly, even just with their attention.
2. **Not coercive.** Skipping is genuine. The next scene plays unchanged.
3. **Emotionally weighted.** The skip is real, but the *gravity* of the moment is also real. A player who skips loses nothing mechanically and may lose something experientially.
4. **Invitation, not instruction.** The story has earned, by hour-mark 50, the right to make one quiet ask. We use it once.

---

## Three candidates I considered

### Candidate A — The Held Frame

After Wren removes the suit, the screen does not transition. Wren's silhouette remains still in a softly-lit composition. Ambient diegetic audio only (rain, room hum, distant city). No prompt, no UI. After ~15-30 seconds, a single small word appears in a corner: *continue.* No timer, no escalation.

- **Pros**: Honest. Doesn't break frame. Lets the player set their own depth.
- **Cons**: Players conditioned to skip will press anywhere instantly. The moment can be missed entirely by anyone who hasn't been emotionally caught — which is precisely the players we most want to invite.

### Candidate B — The Breath

A soft circle appears center-screen, slowly expanding and contracting at a calm breath rhythm (~4s in, ~6s out). No instruction. Below it, "continue when ready" fades in after one full cycle. The breath circle is not gamified — no compliance meter, no reward for sustained attention.

- **Pros**: Has visual presence. Invites a body response without instructing one.
- **Cons**: The breath-circle has been claimed by meditation apps; it risks reading as that genre. The story would suddenly look like Headspace, which is its own kind of mask.

### Candidate C — The Outside Window *(RECOMMENDED)*

The game's UI fully dissolves. The screen shows a still composition of an ordinary thing — a curtain stirring, light moving on a wall, or the ant hill once more. There is no character, no dialogue, no progress prompt. Only ambient sound.

After ~10 seconds, a faint single line of text fades in, in the same gentle voice the story has built across the hour:

> Look up if you'd like. Take in one ordinary thing where you are. Come back when you're ready.

No button. The player must click anywhere — anywhere on the screen — to continue. The scene then resumes as if nothing happened. No acknowledgment, no penalty for a fast click, no reward for a slow one.

- **Pros**: Pushes the experience outside the screen *one* time, at the moment the story has earned. Honest to the thesis. Specific.
- **Cons**: A fourth-wall break risks tonal violation. Mitigated by it being **the only** direct address to the player in the entire game. Its scarcity is what makes it land.

---

## Recommendation

**Candidate C, with two restraints borrowed from Candidate A.**

1. The window image is not narrated. No voiceover, no character thought, no metaphor in dialogue. It is just *there*.
2. The "look up if you'd like" line is the only direct address to the player in the entire game. Used once. The first scene is *not* allowed to do this. No tutorial line is allowed to do this. No save-prompt language is allowed to do this. The voice is preserved unspoiled until the climax.

### Why this works

- The invitation comes in a voice the player has trusted for an hour — not a guru, not a meditation app, not a parental *you should*. The story has earned one quiet ask.
- It is the climax. The earned moment is *offered*, not demanded.
- Skipping is real, not a fake choice. The next scene plays unchanged. No "did you really pause?" follow-up. No checking.
- The "ordinary thing" framing matches the thesis perfectly. The game does not *teach* mindfulness. It invites the player to do it once, in their own room, on their own terms, with the gentle structure of the moment held by the story.

### Why this doesn't coerce

- No timer. No minimum dwell. A 0.2-second click and a 5-minute pause produce the *same* next scene.
- No language of obligation ("please", "should", "must"). Just *if you'd like*.
- The player can have already skipped every text-pause in the game and *this scene will not warn them or change*. We trust the player.
- The invitation is given once and never repeated. If the player misses it, the story does not lecture.

---

## Implementation notes (Phase 1 — design only, no code yet)

These will become Phase 2 acceptance criteria.

1. **Pre-pause silence (~3 seconds)** before the window image appears. Music stops. UI animations stop. The transition is *felt* as silence first, then image.
2. **Ambient audio only** during the pause. No score, no string swell, no instrumental nudge. Diegetic sound is the only sound — wind, rain (the appropriate motif sound for this playthrough), room hum.
3. **No skip-counter, no auto-skip**. If the player has been mass-skipping dialogue, the pause does **not** auto-advance. This is the one beat in the game where rapid-skipping behavior is deliberately broken — the player must *click* to continue.
4. **Single click anywhere** advances. No specific button. No "press SPACE to continue" overlay. The whole screen is the advance affordance.
5. **No achievement, no flag, no ending-tracker variation tied to dwell time.** The pause is private between the player and themselves.
6. **Visible text**: gentle font, half-opacity, slow ~1.5s fade-in. The line is small, not centered like a title card — placed slightly off-axis, like a sentence in a margin.
7. **Accessibility**: a player using a screen reader gets the same line via aria-live, with the same slow timing. A player who prefers reduced motion gets the same image, no animation.

---

## The everyday-pacing mechanic

The climax pause works only if the rest of the game has prepared the player to *let scenes breathe*. We can't shock a player who's been auto-advancing dialogue for 55 minutes into a 30-second contemplative still.

So: a quiet, accumulating pacing language across the run.

### Slow-default scenes

In specific scenes — when a character is alone with a motif (the ant hill, rain on a window, the song hummed) — the dialogue auto-advance timer becomes slower than default, *and* the player's manual advance still works instantly. The slow default isn't enforced. It's just the rhythm the scene proposes if the player lets it.

Scenes with slow defaults:
- Scene 1 (Cold Open) — the ant hill beat
- Scene 3 (PE) — Ozaki stepping out of his suit
- Scene 5 (Hallway) — Iris at the window
- Scene 7 (Crushed) — the recontextualized hill
- Scene 11 (Night Hallway) — humming
- Scene 13 (Climax) — the entire scene
- Scene 15 (Coda) — the final ant frame

In all other scenes, default is normal-paced. The slow default appears only when a motif is present.

### Why this matters

By scene 11, the player who has been letting things breathe has been *practicing the climax pause* without being told. By scene 13, the pause is not a sudden imposition — it is the natural conclusion of a rhythm the game has been quietly proposing.

The player who has been auto-advancing through everything is not punished, but the pause will land less. That is fair — they have made an authoring choice about how they wanted to receive the story.

---

## What this design refuses

For clarity, in case future scope creep arrives:

- **No required minimum dwell.** Ever.
- **No meditation-app patterns.** No breath circles. No mood selectors. No "how do you feel?" prompts.
- **No achievements** tied to taking the pause.
- **No analytics** measuring pause duration. (Even if telemetry is added later for other reasons, the pause duration is not measured.)
- **No second use** of the direct-address voice. The line *Look up if you'd like* appears once in the entire game.
- **No score** in the pause itself. Silence is the score.
