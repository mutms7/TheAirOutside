# Prompt 2: platformer feel, intro/controls, character detail, suit toggle animation

Paste everything below the line into the game session.

---

A round of mechanics and polish work. Treat this as a **puzzle platformer** first and foremost. Keep the framing light and game-focused, not heavy or metaphorical. Priorities: tight, predictable controls and a character that feels good to move. Here's what I want:

## 1. Fix wall collisions so vertical momentum is preserved

Right now, if I jump and bump a wall sideways while rising, all my movement stops and I just drop. That feels bad. Fix the character controller so that **horizontal and vertical movement are resolved independently**:
- If I'm moving up and hit a wall to the *side*, I should **keep rising** — only my horizontal motion against that wall is canceled, not my upward velocity. I slide up along the wall.
- Same idea on the way down: hitting a side wall shouldn't kill my fall, just the sideways push into it.
- Only an actual *ceiling* (a surface above me) should stop upward motion; only the *ground* (a surface below) should stop downward motion.
- Implement this as per-axis collision resolution (resolve X and Y/Z separately, e.g. sweep/move-and-slide per axis or separate-axis depenetration), not a single combined collision that zeroes the whole velocity vector.
- Make sure this stays stable: no jitter against walls, no sticking, no getting launched. Test by jumping into walls from different angles.

## 2. Add an intro + controls screen

When the game starts (and reachable from a pause menu), show a short, clean intro:
- A brief **"what this game is"** blurb: a 3D puzzle platformer about precise movement, where you switch between two states to solve traversal puzzles. Keep it short and punchy, focused on *what you do*, not lore. One short paragraph max.
- A clearly laid-out **controls list**. Cover everything: move, look/camera, jump, the suit toggle (see below), pause, restart, anything else bound. Show keyboard (and gamepad if supported).
- Make it readable and styled to match the game, dismissible with a key/click.

## 3. Make the main character more detailed, with real animations

Give the player character actual movement life. I want distinct, good-looking animation states:
- **Idle**, **walk/run** (movement animation), **jump** (takeoff + airborne/falling), and **landing**.
- A **win / victory animation** that plays on level complete.
- Two visually **distinct looks**: a **suited** appearance and a **bare (no-suit)** appearance — clearly different silhouettes/materials/colors so I can tell my state at a glance. The character model itself should read differently in each mode, not just a tint.
- If you're using simple/primitive geometry, that's fine, but make the animation and the two-look distinction genuinely readable and polished. Procedural/skeletal/tweened, your call — just make it feel intentional and smooth.

## 4. Suit toggle: a reversible transformation animation on Q

The state switch (suited <-> bare) should be an **animated transition bound to Q**, and crucially it must be **interruptible and reversible mid-way**:
- Press **Q** to start "suiting up" (bare -> suited) or "suiting down" (suited -> bare), with a visible transition animation (the model morphing/assembling/dissolving between the two looks).
- If I **tap Q again quickly while it's mid-transition**, it should **halt and reverse from the current point** — smoothly playing back toward the state I came from, starting from wherever the animation currently is. No snapping, no waiting for it to finish, no double-trigger weirdness.
- Treat the transition as a normalized progress value (0 = bare, 1 = suited) that I'm driving up or down; Q flips the direction at the current progress. The committed state only changes when progress actually reaches an end (0 or 1).
- Decide and document how the *gameplay* state behaves mid-transition (e.g. you don't gain the target state's abilities until the animation completes) so it isn't exploitable, and make it feel fair.

## How to work

Do these in order, keep the game runnable after each, and tell me the exact run command. After each item, briefly tell me what to press to test it. Prioritize control feel — if something feels floaty, sticky, or unpredictable, tune it until it's crisp. This pass is about *quality of movement*, so polish the feel, don't just make it functional.
