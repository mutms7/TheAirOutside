// characters.ink — per-character state variables
// Per-character color palettes live in the renderer's CSS tokens.

// Protagonist name. Set in the prologue via name input. Default Wren.
VAR protagonist_name = "Wren"

// Wren (the protagonist) — Suit-in vs. bare drives UI chrome.
// wren_saturation slowly drifts from 1.0 toward 0.3 across the story
// (final state determined at Gate 4 in Scene 14).
VAR wren_in_suit = true
VAR wren_saturation = 1.0

// Presence flags for staging.
VAR tae_present = false
VAR iris_present = false
VAR ozaki_present = false
VAR cael_present = false
VAR janitor_present = false
