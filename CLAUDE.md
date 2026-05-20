# CLAUDE.md

This is a personal-art-project visual novel. Working title **The Air Outside**.

## What it is

A ~1-hour web visual novel about mindfulness, presence, and appreciation for ordinary life. Set in a middle/high school in a society where everyone moves around inside personalized exo-suits, decorated like phones, the dominant social currency. The suits are an allegory for the masks people put up to hide behind (deliberately not modelled on any specific thing). The protagonist (default name **Wren**, player-customizable) is an earnest conformist who eventually steps outside their suit. Hope is intimate, not societal: one or two others may follow at their own pace; the world does not transform.

## Required reading (in order)

Before contributing to this project, read:

1. [story-bible.md](story-bible.md) — thesis, themes, tone, the 4 recurring motifs (ants, sticker, rain, hummed song) and their meaning-shift arcs; the per-character color palette; the list of things the story refuses to do
2. [characters.md](characters.md) — 6 characters with surface/interior split and suit-as-mask analysis
3. [outline.md](outline.md) — 15 scenes, 4 gates, mermaid branch map, 9 climax-coda combinations
4. [mechanics.md](mechanics.md) — the climax pause-mechanic design (Outside Window) and the everyday slow-default pacing that earns it
5. [art-plan.md](art-plan.md) — placeholder-first development order, hand-illustrated flat-graphic style recommended, AI art rejected as final asset

These are the source of truth for the creative side. Do not redesign them without the user's go-ahead.

## Current state (as of Phase 7)

Phases 1-7 are complete. The game runs end-to-end with all 15 scenes, 4 gates, and 9 distinct endings. Branch: `main`. Latest commit: `639ed5f`.

**Run the game:**
```powershell
dotnet run --project src/VisualNovel.Web
# then open http://localhost:5156
```

**Rebuild the Ink story after editing scene files:**
```powershell
dotnet run --project src/VisualNovel.InkBuild
```

**Production publish:**
```powershell
dotnet publish src/VisualNovel.Web -c Release -o publish
# wwwroot/ is the static shipping folder
```

**If you hit a 404 on `/_framework/dotnet.<hash>.js` after a rebuild:**
This is a Blazor WASM fingerprint cache mismatch — the browser has cached an `index.html` referencing old hashed asset names. Fix:
1. F12 → Network tab → check "Disable cache"
2. Hard refresh (Ctrl+Shift+R)
Or nuke and restart:
```powershell
Remove-Item -Recurse -Force src/VisualNovel.Web/bin, src/VisualNovel.Web/obj, src/VisualNovel.Shared/bin, src/VisualNovel.Shared/obj
dotnet run --project src/VisualNovel.Web
```

## Working conventions

- **Phased work, with explicit phase gates.** See "Phase plan" below.
- **Code lives under `src/`; Ink scripts live under `ink/`.** The split is load-bearing: writers can live in `ink/` without touching C#, and the renderer is replaceable.
- **Git: branch `main`.** First Phase-1 commit was on `master` and the branch was later renamed/pushed as `main`. Commits 1-10 documented below.

## Architecture (locked Phase 2)

| Layer | Choice | Rationale |
|---|---|---|
| Script language | **Ink** (Inkle's narrative DSL) | Purpose-built for branching-state narrative. Gates, motif callbacks, and texture cascades map onto Ink's variables/knots ~1:1. Authored as plain `.ink` files. |
| Ink runtime | **Qyl27.Ink.Engine** / **Qyl27.Ink.Compiler** | Modern community ports of Inkle's C# implementation. Inkle's own NuGet was abandoned. |
| Renderer | **Blazor WebAssembly + .NET 10** | C# end-to-end. Static-shipping web target. |
| Audio | **(not wired)** Howler.js via JS interop planned | All `# audio:` and `# sfx:` tags are parsed into state but not yet played. ~50 lines of JS interop to wire up. |
| Save/load | **IJSRuntime localStorage** | Two keys: `the-air-outside.settings` and `the-air-outside.progress`. SaveService.cs persists visited scenes, last scene, prologue-done flag, and protagonist name. |
| Build | `dotnet publish` | Static folder out. Drop on itch.io, Vercel, Cloudflare Pages, personal domain. |
| Authoring tool | **Inky** (Inkle's free editor) | Visual playthrough + live state inspector during scene writing. Optional. |

**Project layout:**
- `ink/` — narrative scripts (16 files: story.ink + characters.ink + motifs.ink + gates.ink + scenes/01-16). Compiled to `story.json`.
- `src/VisualNovel.Shared/` — Razor Class Library: components, services, the compiled `story.json` + CSS as static assets.
- `src/VisualNovel.Web/` — Blazor WASM entry point. Thin shell over Shared.
- `src/VisualNovel.InkBuild/` — small console app that compiles `ink/story.ink` → `src/VisualNovel.Shared/wwwroot/story.json` via `Ink.Compiler`.
- `scripts/first-person.pl` — Perl tool that converts third-person Wren narration to first-person and removes em-dashes. Used once in Phase 6; kept for future scene additions.

## Soul constraints (do not drift on these)

The user has already answered the soul-defining questions about this story. These are locked unless they say otherwise:

- **Tone**: gentle and wistful baseline, with capacity for quiet darkness — *existential, not violent*. No spectacle of cruelty.
- **Mindfulness definition (theirs)**: "appreciating the world around me and noticing one's own feelings." Secular, attention-based, emotion-aware. Not framed as practice from a tradition.
- **Romance**: side-plot at most. The protagonist's arc is self-discovery, not finding love.
- **Ending scope**: intimate. One or two changed people. *Never* a sweeping societal transformation arc.
- **Allegory**: the suit-as-mask is deliberately abstract. Don't pin it to phones, gender, capitalism, or any single specific thing.
- **The Winston/prole-woman moment** (from 1984) is the user's gold standard for what they want this story to do. When making creative calls, ask whether the choice grants dignity to an ordinary unnoticed person.
- **Cast size locked at 6.** Don't add characters. If a beat needs another body, use the janitor's camera-edge framing principle.
- **Motif craft is load-bearing.** The story tells itself through 4 motifs (ants, sticker, rain, hummed song) and per-character palettes. Motifs accrue meaning across scenes; characters *never* narrate their meaning aloud.
- **Climax pause mechanic**: the "Look up if you'd like" line is the *only* direct address to the player in the entire game. Used once at the climax. Never reuse this voice. No tutorial line, no save prompt, no other scene may break the fourth wall.
- **AI art is not an acceptable final asset.** A story about masks cannot wear one. AI for ideation/reference only, disclosed if used at all. All current art in `Background.razor` / `Character.razor` / `Motif.razor` / `SpotArt.razor` is hand-coded SVG.
- **First-person narration.** Phase 6 converted the entire script from third-person Wren to first-person I. Other characters address the protagonist as `{protagonist_name}` (default Wren, set in the prologue, dynamically interpolated by Ink).
- **No em-dashes in the prose.** Phase 6 stripped them all. The "auto-pause-comma" pattern for interrupted speech uses ellipses (`...`).

## Story branching: gates and endings

Four gate variables drive the branches:

| Gate | Scene | Options |
|---|---|---|
| `gate1` | 4 (The Lesser Suits) | `silent` / `speak` / `deflect` — texture cascade to Scene 8 |
| `gate2` | 5 (The Window) | `approach` / `avoid` — drives Scene 6 variant |
| `gate3` | 12 (The Door) | `iris` / `stay` / `tae` — drives Scene 13 climax variant |
| `gate4` | 14 (Bare) | `stay_out` / `suit_no_deco` / `re_enter` — drives Scene 15 coda variant |

**9 distinct endings** (gate3 × gate4), each with its own title, closing prose, and SVG art (see `ink/scenes/16-epilogue.ink`):

| | stay_out | suit_no_deco | re_enter |
|---|---|---|---|
| **iris** | Together, Outside | Together, Half-Bare | Together, Looking |
| **stay** | Alone, Outside | A Quiet Step | Looking Again |
| **tae** | Out, With a Friend | Half-Step Out | Returning, Changed |

## Renderer features built

- **Prologue + name input** (NameInput.razor) — 5 lines over a barren-landscape SVG; name defaults to Wren; persisted across sessions.
- **TopBar** with 4 icons: Settings, Scenes, Story map, History.
- **Settings panel**: auto-advance toggle + delay slider, text fade slider, text size slider (6 stops: 0.75–2x), light/dark theme, reduce motion, master/music/sfx volumes (UI only — audio not wired), reset to defaults.
- **ScenePicker**: all 15 scenes clickable. Forward-jump warning modal.
- **StoryMap** (Components/StoryMap.razor) — full-screen 2D top-down node graph with scenes, gates, and 9 ending stars. Picked path traces in Wren-peach.
- **Backlog**: scrollable history of every line read in the current session.
- **Dialogue**: speaker-colored, narration italicized, HUD lines in monospace with a left bar.
- **Custom hover tooltips** via `data-tooltip` attribute.
- **Climax pause mechanic** (mechanics.md Candidate C): `# pause: climax-window` tag dissolves UI, fades the *Look up if you'd like* line in over 8s at half opacity. Click anywhere advances.
- **Per-character SVG art** with name letters on the chest (Wren's name reads from the `protagonist_name` Ink variable live).
- **Responsive layout** breakpoints at 900px and 600px.
- **Dark-bg-aware UI**: when current scene background is dark (bedroom-night, hallway-night, taes-room, field-night, field-clearing) OR theme is dark, UI elements switch to light ink.

## Open decisions still deferred

- **Working title** *The Air Outside* is a placeholder.
- **Protagonist name** *Wren* is a default; the player chooses in the prologue.
- **Audio**: not wired. All `# audio:` and `# sfx:` tags parse into state but nothing plays. Howler.js + JS interop is the planned path.
- **MAUI Blazor Hybrid project** is intentionally not scaffolded yet; add it when desktop shipping becomes a near-term goal. `dotnet workload install maui` first.
- **TimelineMap.razor** (Phase 4) is dead code, replaced by StoryMap.razor (Phase 7). Can be deleted in a cleanup pass.
- **Some endings share epilogue art** (`epilogue-together-outside` for both iris+stay_out and iris+no_deco). The user requested distinct art per ending; an art polish pass could add 1-2 more unique SVGs.

## Phase plan (history + next)

- **Phase 1** ✅ Creative planning (the 5 `.md` files above) — `3edee36`
- **Phase 2** ✅ Architecture: Ink + Blazor WASM locked; Scene 1 playable in placeholder form — `9fe5325`
- **Phase 3** ✅ Full 15-scene script in Ink with all gates and motif state — `1e749be`
- **Phase 4** ✅ UX shell: manual advance, fade transitions, settings, scene map — `17b03bf` + `b8560cd`
- **Phase 5** ✅ 100+ SVG illustrations across the 15 scenes — `b38911b`
- **Phase 6** ✅ Bug fixes, UI polish, first-person script, name input, prologue — `ed55ccd`
- **Phase 7** ✅ Slider stops, tooltips, ant hill grounded, full-screen story map, 9 distinct endings — `44bc770` + `639ed5f`
- **Phase 8** (next): audio (Howler.js interop), additional ending art polish, optional MAUI desktop, playtesting

## A note for whoever picks this up next

This is the user's personal art project. They are not asking for help writing a generic visual novel. They have specific taste, a specific philosophy, and a specific story. The job is to help them build *that* story, not a more efficient or more marketable version of it. When in doubt, prefer the choice that respects an ordinary unnoticed person and resists scaling up.

When the user reports a bug, default to verifying their state before assuming the code is broken: clear localStorage, hard-refresh, check the F12 console. The most common "it keeps loading" failure is a Blazor WASM fingerprint mismatch where the browser cached an old `index.html`.
