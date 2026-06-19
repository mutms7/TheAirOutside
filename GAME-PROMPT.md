# Prompt: build a 3D game inspired by *The Air Outside*

Paste everything below the line into a fresh session.

---

You are building a **brand-new 3D video game** that takes *loose* inspiration from the worldbuilding of an existing visual-novel project called **The Air Outside** (working title), located on this machine at `C:\Users\William Chenyin\Documents\GitHub\visualnovel`. That project is a separate, finished narrative game. **You are NOT extending it, porting it, or retelling its story.** You are making your own game in the same *universe-flavor*. Treat the VN as mood-and-setting reference only.

## Step 0 — absorb the source flavor (read, don't copy)

Before designing anything, read these files in the VN repo for tone and worldbuilding (NOT for plot to reproduce):
- `story-bible.md` — the thesis, themes, the four recurring motifs (ants, a decoration sticker, rain, a hummed song), and the per-character color palette.
- `characters.md` — the cast and the "suit-as-mask" psychology.
- `CLAUDE.md` — the soul constraints.

The one idea you MUST carry over: **everyone moves through the world inside personalized exo-suits, decorated like phones — the suit is a mask people hide behind, and the dominant social currency is how it's decorated. Going "bare" (stepping outside the suit) is rare, exposing, and quietly powerful.** The thesis of the universe is *presence*: to truly notice an ordinary thing is to grant it dignity.

Carry over the **feeling** (gentle, wistful, a touch of quiet melancholy; Ghibli / Mushishi / A Short Hike / Kentucky Route Zero as register references). Do **not** carry over: the specific 15-scene plot, the named characters, the "look up if you'd like" climax line, or the visual-novel format. This is an action/exploration game, not a story-delivery machine.

## What to build

A **3D game with real-time movement and good graphics**, playable in the browser (and ideally also packageable as a desktop build). It must NOT be a story-on-rails experience. It should be a *game* — with mechanics that are fun to engage with on their own terms, that a player would replay.

Hard requirements:
1. **3D, real-time, with proper movement** — walk/run/jump or glide/climb, a controllable camera, a navigable space with verticality and interesting geometry. Not a 2D top-down thing, not a point-and-click.
2. **Good graphics** — commit to a strong, cohesive art direction. Stylized is encouraged over realistic (it ships better and reads better in-browser). Lighting, post-processing, particles, a readable color language. Per-character / per-zone color palettes are part of this universe's DNA — use color as a mechanic and a mood tool.
3. **A signature core mechanic built from the suit/mask idea.** This is the heart of the game — make it genuinely fun and mechanically deep, not just thematic decoration. A strong seed (improve on it or replace it with something better):
   - The player can **toggle between SUITED and BARE** states at will, each a real trade-off.
   - **Suited:** fast, protected, can dash/withstand hazards, fits in with crowds — but the world is perceptually *muted* (desaturated, filtered audio, hidden things stay hidden, certain paths and truths are invisible to you).
   - **Bare:** slower and vulnerable, but the world floods with color and detail — you can see hidden routes, the true state of NPCs/objects, collectible "moments," and solve things you literally cannot perceive while suited. Maybe physical reach/interaction differs too.
   - Build puzzles, traversal, and risk/reward encounters around *when* to be suited vs. bare. Make mastery feel great.
4. **Level selection / multiple distinct levels.** A hub or level-select screen, several hand-crafted zones/levels each with its own palette, layout, and mechanical twist on the core idea, plus a sense of progression (unlocks, collectibles, optional challenges). Include difficulty or a challenge layer so it has legs.
5. **Fun secondary mechanics** — pick a few and make them sing. Ideas to draw from (use, remix, or ignore): a **decoration/customization system** for the suit that has real gameplay effects (not just cosmetic); **traversal abilities** that key off the bare/suited duality; a **"noticing" mechanic** where slowing down and observing ordinary details (the ants, the rain, a hummed tune) rewards the player mechanically; **photo/scan mode**; time-of-day or weather (rain especially — it's a core motif) that changes play; light stealth/social-blending in crowd zones; a momentum/flow movement system worth mastering.
6. **Weave the four motifs in as game elements**, not cutscenes: ants (small life worth noticing, maybe collectibles or a guidance system), a sticker/decoration (customization + a meaning that shifts), rain (weather mechanic + mood), a hummed melody (audio motif, maybe a collectible-song or rhythm element). Let them mean something through play, never via a character explaining them.

Keep the universe's soul: **hope is intimate, not societal; the tone is gentle, never cruel; nobody is a cartoon villain; the world doesn't transform, the player's attention does.** But this is a real game first — lead with fun.

## Tech — your call, use whatever you need

You have full permission to install and use whatever stack is best for a good-looking 3D browser game. You don't need to match the VN's C#/Blazor stack — in fact you probably shouldn't. Strong defaults to consider:
- **Three.js / React-Three-Fiber + Vite + TypeScript**, or **Babylon.js**, or **PlayCanvas**, for browser-native 3D.
- A physics lib (Rapier / cannon-es) if movement/puzzles need it.
- Post-processing (bloom, color grading, DOF) for the "good graphics" bar.
- For desktop packaging later: Tauri or Electron.
- Use a real **game engine like Godot (web export)** if you judge it a better fit — your choice.

Pick the stack, justify it in one line, and go. Install dependencies as needed.

## Where to put it

Create the game as its **own new project**, separate from the VN. Suggested: a sibling folder or a new subdirectory like `C:\Users\William Chenyin\Documents\GitHub\` (ask me, or just make a clearly-named new folder such as `theairoutside-game/`). **Do not modify the existing `visualnovel` repo's source.** Initialize a fresh git repo for the game.

## How to work

1. First, **propose a concrete game design**: the pitch in 2-3 sentences, the core loop, the bare/suited mechanic spelled out, 4-6 planned levels with their distinct hooks, the secondary mechanics, the art direction (palette, lighting, shapes), and the tech stack. Show me this before building heavily — a short design doc.
2. Then scaffold the project and get a **playable vertical slice** fast: one zone, working third-person (or first-person) movement, the suit/bare toggle changing the world, and the level-select shell. Prioritize something I can actually run and feel.
3. Iterate outward to more levels and polish. Keep it runnable at every step and tell me the exact command to run it.
4. Make it look good. Don't ship gray boxes as the final state — commit to the art direction early so it reads as *this universe*.

Name the game something of your own choosing that fits the world (don't reuse "The Air Outside" verbatim). Be creative and have fun with it — I'm intentionally leaving the design open. Surprise me, but keep the soul: a game about the quiet power of stepping out of your shell and actually *seeing* the world.
