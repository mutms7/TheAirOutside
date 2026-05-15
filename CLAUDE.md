# CLAUDE.md

This is a personal-art-project visual novel. Working title **The Air Outside**.

## What it is

A ~1-hour web visual novel about mindfulness, presence, and appreciation for ordinary life. Set in a middle/high school in a society where everyone moves around inside personalized exo-suits — decorated like phones, the dominant social currency. The suits are an allegory for the masks people put up to hide behind (deliberately not modelled on any specific thing). The protagonist (Wren) is an earnest conformist who eventually steps outside their suit. Hope is intimate, not societal — one or two others may follow at their own pace; the world does not transform.

## Required reading (in order)

Before contributing to this project, read:

1. [story-bible.md](story-bible.md) — thesis, themes, tone, the 4 recurring motifs (ants, sticker, rain, hummed song) and their meaning-shift arcs; the per-character color palette; the list of things the story refuses to do
2. [characters.md](characters.md) — 6 characters with surface/interior split and suit-as-mask analysis
3. [outline.md](outline.md) — 15 scenes, 4 gates, mermaid branch map, 9 climax-coda combinations
4. [mechanics.md](mechanics.md) — the climax pause-mechanic design (Outside Window) and the everyday slow-default pacing that earns it
5. [art-plan.md](art-plan.md) — placeholder-first development order, hand-illustrated flat-graphic style recommended, AI art rejected as final asset

These are the source of truth for the creative side. Do not redesign them without the user's go-ahead.

## Working conventions

- **Phased work, with explicit phase gates.** Phase 1 (creative planning) is complete as of 2026-05-15. Phase 2 begins with architecture/engine decisions before any code. The user will signal when a phase is complete.
- **No code is in this repo yet.** Phase 1 deliberately produced only `.md` files. Phase 2 will introduce code; the engine and project layout are open decisions.
- **No git yet.** The directory is not a git repository. If the user wants version control, `git init` is a first move worth offering.

## Soul constraints (do not drift on these)

The user has already answered the soul-defining questions about this story. These are locked unless they say otherwise:

- **Tone**: gentle and wistful baseline, with capacity for quiet darkness — *existential, not violent*. No spectacle of cruelty.
- **Mindfulness definition (theirs)**: "appreciating the world around me and noticing one's own feelings." Secular, attention-based, emotion-aware. Not framed as practice from a tradition.
- **Romance**: side-plot at most. Wren's arc is self-discovery, not finding love.
- **Ending scope**: intimate. One or two changed people. *Never* a sweeping societal transformation arc.
- **Allegory**: the suit-as-mask is deliberately abstract. Don't pin it to phones, gender, capitalism, or any single specific thing.
- **The Winston/prole-woman moment** (from 1984) is the user's gold standard for what they want this story to do. When making creative calls, ask whether the choice grants dignity to an ordinary unnoticed person.
- **Cast size locked at 6**. Don't add characters. If a beat needs another body, use the janitor's camera-edge framing principle.
- **Motif craft is load-bearing**. The story tells itself through 4 motifs (ants, sticker, rain, hummed song) and per-character palettes — borrowed from BCS (Hummel-figurine principle), BB (pink-bear single-thread, color theory). Motifs accrue meaning across scenes; characters *never* narrate their meaning aloud. See story-bible.md for citations.
- **Climax pause mechanic**: the "Look up if you'd like" line is the *only* direct address to the player in the entire game. Used once at the climax. Never reuse this voice. No tutorial line, no save prompt, no other scene may break the fourth wall.
- **AI art is not an acceptable final asset.** A story about masks cannot wear one. AI for ideation/reference only, disclosed if used at all.

## Open decisions deferred to Phase 2

- **Engine / architecture**. User's initial brief named C# + ASP.NET Core + Blazor for web target, with permission to recommend an alternative with justification. Worth seriously comparing: Blazor-native, Ink (Inkle's narrative scripting) compiled to JSON with a thin Blazor renderer, Twine (probably only as prototype), or a bespoke component model. The story is dialogue-heavy with branching state — script language matters more than rendering.
- **Working title** *The Air Outside* is a placeholder.
- **Protagonist name** *Wren Hata* is a working draft.
- **Character names generally** are working drafts.
- **The exact 1984-cadence passage Mr. Ozaki reads in scene 8** is unwritten — needs to be drafted or adapted in Phase 3 (script writing).

## Phase plan (rough)

- **Phase 1** ✅ Creative planning (the 5 `.md` files above)
- **Phase 2** Architecture: engine choice, project skeleton, data model for scenes/choices/state, the climax pause-mechanic prototype
- **Phase 3** Script writing: write every scene's dialogue against the outline; lock branching state model
- **Phase 4** Implementation: build the full game with placeholder art (see art-plan.md)
- **Phase 5** Playtest in placeholder form with trusted readers; revise writing
- **Phase 6** Art + audio decisions (hand-drawn, commission, or ship in placeholder style — all legitimate). **Sound matters more than art in a quiet game.**
- **Phase 7** Polish + release

## Memory

This user's persistent memory on this machine contains two project-relevant entries:
- `project-visualnovel` — current project state and phase
- `user-creative-sensibilities` — the user's creative philosophy and what moves them in fiction

If you're a fresh agent picking this up, you should already see those in your context if memory is loading. If not, the contents of this CLAUDE.md and the 5 Phase 1 docs are sufficient.

## A note for whoever picks this up next

This is the user's personal art project. They are not asking for help writing a generic visual novel — they have specific taste, a specific philosophy, and a specific story. The job is to help them build *that* story, not a more efficient or more marketable version of it. When in doubt, prefer the choice that respects an ordinary unnoticed person and resists scaling up.
