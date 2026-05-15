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

- **Phased work, with explicit phase gates.** Phase 1 (creative planning) completed 2026-05-15. Phase 2 (architecture) locked 2026-05-15 — see below. Phase 3 (script writing in Ink) is the next gate.
- **Code lives under `src/`; Ink scripts live under `ink/`.** The split is load-bearing: writers can live in `ink/` without touching C#, and the renderer is replaceable.
- **Git initialized.** Branch `master`. First commit (Phase 1 docs) made 2026-05-15.

## Phase 2 architecture (locked 2026-05-15)

| Layer | Choice | Rationale |
|---|---|---|
| Script language | **Ink** (Inkle's narrative DSL) | Purpose-built for branching-state narrative. Gates, motif callbacks, and texture cascades map onto Ink's variables/knots ~1:1. Authored as plain `.ink` files. |
| Ink runtime | **Ink-Runtime (C#)** | Inkle's canonical port; runs cleanly in Blazor WASM. |
| Renderer | **Blazor WebAssembly + .NET 10** | TS-fluent → C#-fluent reversal in user's preference. Static-shipping web target. |
| Audio | **Howler.js via JS interop** | Blazor has no native audio. Howler handles ambient crossfades and the pre-climax silence. |
| Save/load | **Blazored.LocalStorage** | Thin community wrapper around browser `localStorage`. Ink state serializes to JSON cheaply. |
| Build | `dotnet publish` | Static folder out. Drop on itch.io, Vercel, Cloudflare Pages, personal domain. |
| Authoring tool (Phase 3) | **Inky** (Inkle's free editor) | Visual playthrough + live state inspector during scene writing. |

**Shippability:** scaffolded as a multi-project solution so a MAUI Blazor Hybrid project can be added later for native desktop binaries (Steam, itch.io desktop) without restructuring. Web ships today; desktop is a `dotnet workload install maui` away.

**The `ink/` vs `src/` split:**
- `ink/` — narrative scripts. Where writing happens. Compiled to `story.json`.
- `src/VisualNovel.Shared/` — Razor Class Library: components, services, the compiled `story.json` as a static asset. Consumed by Web *and* future Desktop projects.
- `src/VisualNovel.Web/` — Blazor WASM entry point. Thin shell over Shared.
- `src/VisualNovel.InkBuild/` — small console app that compiles `ink/story.ink` → `src/VisualNovel.Shared/wwwroot/story.json` using `Ink.Compiler`.

To rebuild the story after editing `.ink` files: `dotnet run --project src/VisualNovel.InkBuild`.
To run the game: `dotnet run --project src/VisualNovel.Web`.

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

## Open decisions still deferred

- **Working title** *The Air Outside* is a placeholder.
- **Protagonist name** *Wren Hata* is a working draft.
- **Character names generally** are working drafts.
- **The exact 1984-cadence passage Mr. Ozaki reads in scene 8** is unwritten — needs to be drafted or adapted in Phase 3 (script writing).
- **MAUI Blazor Hybrid project** is intentionally not scaffolded yet; add it when desktop shipping becomes a near-term goal.

## Phase plan (rough)

- **Phase 1** ✅ Creative planning (the 5 `.md` files above)
- **Phase 2** ✅ Architecture: Ink + Blazor WASM locked; project skeleton with Scene 1 playable in placeholder form
- **Phase 3** Script writing: write every scene's dialogue against the outline in Ink; lock branching state model
- **Phase 4** Implementation: build the remaining scenes and the climax pause mechanic against placeholders (see art-plan.md)
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
