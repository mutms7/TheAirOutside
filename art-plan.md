# Art Plan

An honest asset strategy for a personal-art-project visual novel where AI-generated art is **not** an acceptable final solution.

---

## The honest constraint

You named it directly: AI art looks AI-generated. For *this* story — about masks, performance, and the slow drift from one's authentic self — visuals the audience experiences as fake are a thematic poison. A game about the difference between performed and real cannot afford to look like the performed kind on the surface level.

So: no AI-generated final assets. AI for ideation/reference only, and even then with care.

---

## Recommended visual style

**Flat, limited-palette, hand-illustrated.** In the lineage of:

- *Kentucky Route Zero* (silhouette + bold color + theatrical staging)
- *Mutazione* (warm, hand-drawn, soft outlines)
- *Florence* (intimacy at a small scale, minimal palette)
- *A Short Hike* (gentleness as a serious aesthetic choice)
- *Norco* (negative space, mood-saturated)

Why this style fits *this* story:

1. **It looks intentionally drawn.** No AI artifacts. The mark of a person is visible.
2. **It reduces art volume.** No rendering, no detail painting, no hair strands. A character is a silhouette plus a color signature plus three or four expression variants.
3. **It lets motifs do narrative work.** Negative space, palette shifts, and silhouette framing are the language. The ant hill drawn in flat shapes is more memorable than a detailed painting of one.
4. **It encodes the theme through palette.** Suits get saturated, decorated color blocks. Bare characters get soft, low-saturation linework. The aesthetic *itself* says what the story says, before any dialogue.
5. **It is achievable solo.** If commissioning is out of budget, this style is the most reachable for a developer learning to draw, or a friend with a sketchbook habit. No realism required.

### Borrowed palette principle

From *Breaking Bad* costume design (Vince Gilligan + Kathleen Detoro), as documented in [MovieWeb's color theory piece](https://movieweb.com/breaking-bad-vince-gilligan-color-theory/): each character gets a planned palette before any scene is written, and the palette evolves with the arc.

Translated to this project (cross-reference [characters.md](characters.md)):

| Character | Hex(es) | Why |
|---|---|---|
| Wren | `#F5B68C` peach + `#A8E6CF` mint accent | This season's trend, applied earnestly |
| Tae | `#FF6B9D` saturated pink/coral | Brightness as armor |
| Iris | `#B8B0A8` dusty taupe | Absent palette as her statement |
| Mr. Ozaki | `#6B6855` olive-gray | Old-fashioned restraint |
| Cael | `#FFD24A` bright gold | Performance as social currency |
| Janitor | `#888` neutral gray (→ saturates at coda) | Service-class invisible until seen |

Wren's palette **desaturates over the run** — Gate 4 determines the final state. This is the single piece of "color theory as arc" the game uses, and it does it for one character so the technique stays load-bearing.

---

## Asset inventory (rough first pass)

### Backgrounds (~10-12 unique)

1. School exterior (curb with ant hill — three states)
2. Classroom (homeroom)
3. PE / dexterity hall
4. Cafeteria
5. School hallway (day, rain at window)
6. School hallway (night, empty)
7. Ozaki's literature classroom
8. Wren's bedroom (day)
9. Wren's bedroom (night)
10. Tae's room
11. The climax location with Iris (variant 13a — outdoor / a roof / a quiet field)
12. Coda framing (ant hill from low angle, third state)

Several of these can re-use compositions with palette shifts (day vs. night). True unique compositions: ~8-9.

### Character art (~30 base assets)

6 characters × 3-4 expressions per character (neutral, soft, troubled, smiling) = ~24
Plus: Wren no-suit variant (×3 expressions), Iris no-suit variant (×3), Ozaki no-suit single asset for scene 3 = ~7 extra
Total: ~30 character-asset images

### Motif art (~8 spot illustrations)

- Ant hill: state 1 (building), state 2 (crushed), state 3 (eye-level)
- Single ant carrying something
- Rain on window
- Rain on bare collarbone (climax 13a)
- Sticker close-up (3 states: applied, peeling, in palm)
- Musical-notation flourish (used as scene break for Motif 4 — the hummed song)

### UI

Dialogue box, choice menu, name plates, the climax pause frame, save/load icons. Minimal. ~6 UI elements.

---

## Source strategy (ranked by recommendation)

### 1. Solo flat-graphics, you draw it *(recommended for a personal art project)*

Honest disclosure: a personal art project is best served by visible authorship. If you draw — even modestly — this style works for amateur hands. Flat shapes, limited palette, no anatomy realism required.

- **Cost**: time (your own).
- **Risk**: art quality variance, scope creep, burnout.
- **Mitigation**: build the entire game with placeholders *first*; replace placeholders with hand art only after the writing is locked. This is the order that respects your time.

### 2. Commission a single illustrator *(strong alternative)*

If you don't draw or don't want to, hire one person. Consistency matters more than volume — one artist's hand across the whole game produces a unified aesthetic that AI never will.

Rough 2026 cost ranges (highly variable by artist):
- Backgrounds: $80-200 each × ~10 = $800-2,000
- Character bases + expression variants: $150-300 per character set × 6 = $900-1,800
- Motif/spot art: $50-100 each × 8 = $400-800
- **Total**: $2,100-4,600

For a personal art project, this is a real number. Consider it as a one-time investment in a piece you'll be proud of for years, weighed against the alternative of unmaintained AI assets.

Where to find an illustrator who can do this style: Are.na, Instagram (search by hashtag for flat-graphic illustrators), Cara, Twitter still has a working illustrator scene. Ask for a small paid sample piece before committing.

### 3. Hybrid: hero scenes commissioned, placeholders elsewhere

If full commissioning is too much, commission **only the ~6 scenes that carry the most emotional weight**:

1. Cold open (Scene 1) — sets the visual language
2. Iris at the rain window (Scene 5) — first major motif convergence
3. Tae's drawer (Scene 10) — quiet pivot
4. Night hallway humming (Scene 11) — three characters in silence
5. Climax (Scene 13, all three variants) — the emotional peak
6. Coda (Scene 15, all three variants) — the final image

That is ~10-12 unique commissions. Cost range: ~$1,000-2,000.

Ship the rest with placeholder art presented as deliberate. (See *Placeholder system* below.)

### 4. AI-generated assets *(NOT recommended)*

For final assets: no.

For ideation only: with caveats. Acceptable uses:
- Mood boards for color and composition direction (then discard the images)
- Reference for the human artist (e.g., "I want a window with this kind of light")
- Never as a final asset that ships
- Never for a motif image (the ant hill, the sticker, the rain on skin)
- Never for any character image

If AI is used in any capacity, disclose it in the credits. A story about masks should not be wearing one.

### 5. CC0 / asset packs

Unlikely to fit. The aesthetic is too specific for off-the-shelf packs. CC0 backgrounds will not match a stylized character art aesthetic and will feel like asset-flipping. Skip this route.

---

## Placeholder system (so development proceeds without art)

You should be able to play the whole game, with all branches, before any real art exists. Placeholders enable that.

### Character placeholders

Each character renders as a **flat-color silhouette** with their signature hex (table above). One silhouette pose per character, same across all expressions. Above the silhouette: their name. Across the bottom of their silhouette area: their current expression as a text label (e.g., "[troubled]", "[soft smile]").

This is enough to test scene timing, dialogue pacing, and emotional rhythm. The story works through *words* and *staging*; full character art is the polish layer, not the load-bearing layer.

### Background placeholders

Each background is a **named solid-color frame** with a one-line scene description as visible text. Example:

```
+-----------------------------+
|                             |
|   #F0E6D2                   |
|                             |
|   [SCENE 3 — PE HALL,       |
|    AFTERNOON, RAIN OUTSIDE] |
|                             |
+-----------------------------+
```

Each background's hex is its mood palette. Day scenes are warm; night scenes are cool; tense scenes desaturate. The text label is part of the placeholder. You write the scene; the player (you, during testing) reads the label and imagines the room. This is enough to validate that the writing carries the scene.

### Motif placeholders

Simple SVG icons, reusable, same instance across appearances. The ant icon used in Scene 1 is the same ant icon used in Scene 15. This builds motif recognition during playtest before any real motif art exists — the player learns to feel the recurrence by recognizing the icon.

Motifs to placeholder:
- Ant (single, monochrome SVG)
- Raindrop (single, monochrome SVG)
- Sticker (a small enamel-shape SVG, possibly using each character's color)
- Music note flourish (a small set of grace notes for Motif 4)

### Why this is a real shipping option

If real art never gets made, the game shipped in this placeholder style is **still coherent** and **still tonally honest**. See: *A Mortician's Tale*, *Pyre*'s early builds, the long history of text-with-flat-frames VNs. It is not a fallback. It is a legitimate aesthetic.

In fact: a very strong version of this game could ship in pure placeholder style on purpose — silhouettes, color blocks, hex codes. The thesis is about *seeing past the surface*. A game whose surface is deliberately bare is making the same point as the climax.

This is worth considering seriously.

---

## Development order (the only one that respects your time)

1. **Phase 2** (next): build the engine and the entire game with placeholders. Validate the writing, branching, pacing, the climax pause, the per-scene rhythm.
2. **Phase 3**: playtest with 5-10 trusted people in placeholder form. Identify which scenes are landing and which aren't. Fix the writing first.
3. **Phase 4**: decide art direction based on what's left in budget and time:
   - Option A: ship in placeholder style (legitimate)
   - Option B: commission ~6-12 hero scenes
   - Option C: full hand-illustration (you or commission)
4. **Phase 5**: integrate audio — likely commission a single composer for ambient score plus do a careful sound design pass. **Sound matters more than art** in a quiet game. Budget more for sound than the asset count suggests.

The temptation will be to start commissioning art before the writing is locked. Resist it. Art for scenes that get rewritten is wasted money. Placeholders survive a rewrite for free.

---

## One closing note

A story this personal will be most itself when it doesn't try to look like other visual novels. The decision to ship hand-drawn, or to ship in flat placeholders that are themselves a statement, are both honest. The decision to commission a polished but indistinct anime-VN style would be a kind of suit you put on the game. Worth keeping in mind as the decisions accumulate.
