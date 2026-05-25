// Ambient music engine for "The Air Outside".
// Procedural — no audio files.
//
// Architecture
//   Each MOOD has:
//     - bpm                tempo
//     - brightness         filter cutoff multiplier (0..1)
//     - gains              per-layer base gains
//     - melodyBeatProb     8 half-beat probabilities for melody triggers
//     - progression        8-chord loop (A section 0-3, B variation 4-7)
//     - arp                optional arpeggio layer
//     - color              optional bell / counter / shimmer layer
//   Each CHORD has:
//     - bass[]             low octave + root MIDI numbers
//     - pad[]              sustained voicing MIDI numbers
//     - chordTones[]       harmonic skeleton (used to weight melody picks)
//     - melodyScale[]      pitches the melody picker can choose from
//     - beats              chord duration in beats
//
//   Each SCENE may also apply a SCENE_OVERRIDES entry to colour a shared
//   mood differently (e.g. scene 7 "Crushed" gets slower, sparser wistful;
//   scene 13 "Outside" gets the broadest awe).
//
// Layers per chord
//   bass    — short attack, exponential decay
//   pad     — sustained chord; release overlaps next chord by 1.5s
//   melody  — sparse single notes, weighted by chord tone + stepwise motion
//   arp     — optional broken-chord pulse, faster rhythm
//   color   — optional bell / counter-melody, one note per chord
(function () {
    'use strict';

    // ──────────────────────────────────────────────────────────────────
    // Mood library
    // ──────────────────────────────────────────────────────────────────

    function S(notes) { return notes; } // tiny alias for readability

    const MOODS = {

        // I  vi  IV  V  →  I  iii  ii  V — Cmaj9 / Am9 / Fmaj9 / G7sus4 / Cmaj9 / Em7 / Dm9 / G7sus4
        morning: {
            bpm: 60,
            brightness: 0.55,
            gains: { pad: 0.038, bass: 0.072, melody: 0.058, arp: 0.022, color: 0.024 },
            melodyBeatProb: [0.55, 0.08, 0.30, 0.10, 0.45, 0.08, 0.25, 0.10],
            arp:   { rate: 2, octaveOffset: 12, applyTo: 'AB', filter: 2200 },
            progression: [
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 81, 84]), beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], melodyScale: S([69, 72, 76, 79, 81]),     beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 77], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 67, 71], chordTones: [55, 62, 67, 71], melodyScale: S([74, 79, 81, 84, 86]),     beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 81, 84]), beats: 4 },
                { bass: [40, 52], pad: [59, 62, 67, 71, 74], chordTones: [59, 62, 67, 71], melodyScale: S([71, 74, 76, 79, 83]),     beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 67, 71], chordTones: [55, 62, 67, 71], melodyScale: S([74, 79, 81, 84, 86]),     beats: 4 }
            ]
        },

        // i  bVI  bIII  V7  →  i  iv  bVI  V7 — Dm9 / Bbmaj7 / Fmaj7 / A7 / Dm9 / Gm7 / Bbmaj7 / A7
        tension: {
            bpm: 54,
            brightness: 0.30,
            gains: { pad: 0.032, bass: 0.060, melody: 0.046, arp: 0.018, color: 0.020 },
            melodyBeatProb: [0.35, 0.05, 0.15, 0.05, 0.30, 0.05, 0.15, 0.05],
            color: { motif: 'drone', octave: 5 }, // sustained off-key whisper
            progression: [
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([74, 77, 79, 81, 84]), beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], melodyScale: S([70, 74, 77, 81]),     beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 76], melodyScale: S([72, 77, 81, 84]),     beats: 4 },
                { bass: [33, 45], pad: [57, 62, 64, 67, 71], chordTones: [57, 62, 64, 67], melodyScale: S([69, 74, 76, 81]),     beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([74, 77, 79, 81, 84]), beats: 4 },
                { bass: [31, 43], pad: [58, 62, 65, 67, 70], chordTones: [55, 58, 62, 65], melodyScale: S([72, 77, 79, 82]),     beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], melodyScale: S([70, 74, 77, 81]),     beats: 4 },
                { bass: [33, 45], pad: [57, 61, 64, 67, 71], chordTones: [57, 61, 64, 67], melodyScale: S([69, 73, 76, 79]),     beats: 4 }
            ]
        },

        // i  bVI  bIII  bVII  →  i  iv  bIII  V7sus — Am9 / Fmaj7 / Cmaj7 / G6 / Am9 / Dm7 / Cmaj7 / E7sus
        wistful: {
            bpm: 56,
            brightness: 0.38,
            gains: { pad: 0.036, bass: 0.066, melody: 0.052, arp: 0.018, color: 0.026 },
            melodyBeatProb: [0.50, 0.10, 0.25, 0.10, 0.42, 0.08, 0.20, 0.10],
            color: { motif: 'counter', octave: 5, descending: true },
            progression: [
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], melodyScale: S([69, 72, 76, 79, 81, 83]), beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 76], melodyScale: S([72, 76, 77, 81, 84]),     beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 72, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 83]),     beats: 4 },
                { bass: [35, 47], pad: [55, 59, 62, 67, 71], chordTones: [55, 59, 62, 67], melodyScale: S([71, 74, 76, 79, 83]),     beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], melodyScale: S([69, 72, 76, 79, 81, 83]), beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([74, 77, 81, 84]),         beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 72, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 83]),     beats: 4 },
                { bass: [40, 52], pad: [59, 64, 67, 69, 74], chordTones: [59, 64, 67, 69], melodyScale: S([71, 76, 79, 81, 83]),     beats: 4 }
            ]
        },

        // All sus — open and in-between, modulates up a step in B
        contemplative: {
            bpm: 52,
            brightness: 0.46,
            gains: { pad: 0.034, bass: 0.054, melody: 0.044, arp: 0.014, color: 0.020 },
            melodyBeatProb: [0.30, 0.04, 0.10, 0.04, 0.25, 0.04, 0.08, 0.04],
            color: { motif: 'bell', octave: 6 },
            progression: [
                { bass: [36, 48], pad: [60, 62, 67, 72, 74], chordTones: [60, 62, 67, 74], melodyScale: S([72, 74, 76, 79, 81]),     beats: 4 },
                { bass: [29, 41], pad: [60, 65, 67, 72, 77], chordTones: [65, 67, 72, 77], melodyScale: S([72, 74, 77, 79, 81]),     beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 64, 67], chordTones: [55, 62, 64, 67], melodyScale: S([72, 74, 76, 79, 81]),     beats: 4 },
                { bass: [36, 48], pad: [60, 62, 67, 72, 74], chordTones: [60, 62, 67, 74], melodyScale: S([72, 74, 76, 79, 81]),     beats: 4 },
                { bass: [38, 50], pad: [62, 64, 69, 74, 76], chordTones: [62, 64, 69, 76], melodyScale: S([74, 76, 79, 81, 83]),     beats: 4 },
                { bass: [31, 43], pad: [55, 62, 64, 69, 74], chordTones: [55, 62, 64, 69], melodyScale: S([74, 76, 79, 81, 83]),     beats: 4 },
                { bass: [33, 45], pad: [57, 62, 64, 67, 69], chordTones: [57, 62, 64, 69], melodyScale: S([74, 76, 79, 81, 83]),     beats: 4 },
                { bass: [38, 50], pad: [62, 64, 69, 74, 76], chordTones: [62, 64, 69, 76], melodyScale: S([74, 76, 79, 81, 83]),     beats: 4 }
            ]
        },

        // ii-V loop — close, warm jazz feel. Fmaj9 / Am11 / Dm9 / Bbmaj7 → Fmaj9 / Em7 / A7sus4 / Dm7
        intimate: {
            bpm: 64,
            brightness: 0.52,
            gains: { pad: 0.040, bass: 0.070, melody: 0.056, arp: 0.024, color: 0.022 },
            melodyBeatProb: [0.55, 0.18, 0.38, 0.15, 0.50, 0.12, 0.32, 0.15],
            arp: { rate: 3, octaveOffset: 12, applyTo: 'AB', filter: 1800 },
            progression: [
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], melodyScale: S([72, 74, 77, 79, 81, 84]), beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71, 74], chordTones: [57, 60, 64, 67, 71], melodyScale: S([72, 76, 79, 81, 83]), beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], melodyScale: S([70, 74, 77, 81, 84]),     beats: 4 },
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], melodyScale: S([72, 74, 77, 79, 81, 84]), beats: 4 },
                { bass: [40, 52], pad: [59, 64, 67, 71, 74], chordTones: [59, 64, 67, 71], melodyScale: S([71, 74, 76, 79, 83]),     beats: 4 },
                { bass: [33, 45], pad: [57, 61, 64, 67, 71], chordTones: [57, 61, 64, 67], melodyScale: S([69, 73, 76, 79, 81]),     beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 }
            ]
        },

        // Slow climb, wide voicings. C/G / G/B / Am / F → Em / F / G / Cadd9
        awe: {
            bpm: 50,
            brightness: 0.65,
            gains: { pad: 0.040, bass: 0.060, melody: 0.048, arp: 0.016, color: 0.030 },
            melodyBeatProb: [0.30, 0.0, 0.12, 0.0, 0.24, 0.0, 0.08, 0.0],
            color: { motif: 'bell', octave: 7 },
            progression: [
                { bass: [24, 36, 48], pad: [55, 60, 64, 67, 72], chordTones: [60, 64, 67, 72], melodyScale: S([79, 84, 88, 91, 96]), beats: 4 },
                { bass: [23, 35, 47], pad: [55, 59, 62, 67, 74], chordTones: [55, 59, 62, 67], melodyScale: S([79, 83, 86, 91, 95]), beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 69, 72],       chordTones: [57, 60, 64, 69], melodyScale: S([76, 81, 84, 88, 93]), beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 77],       chordTones: [65, 69, 72, 77], melodyScale: S([77, 81, 84, 89, 96]), beats: 4 },
                { bass: [28, 40], pad: [59, 64, 67, 71, 76],       chordTones: [59, 64, 67, 71], melodyScale: S([79, 83, 86, 91, 95]), beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 77],       chordTones: [65, 69, 72, 77], melodyScale: S([77, 81, 84, 89, 96]), beats: 4 },
                { bass: [31, 43], pad: [55, 62, 64, 67, 71],       chordTones: [55, 62, 67, 71], melodyScale: S([74, 79, 83, 86, 91]), beats: 4 },
                { bass: [24, 36, 48], pad: [55, 60, 64, 67, 74],   chordTones: [60, 64, 67, 74], melodyScale: S([79, 84, 86, 91, 96]), beats: 4 }
            ]
        },

        // IV-I resolution feel. Fmaj9 / Cmaj7 / Dm9 / Bbmaj7 → Fmaj9 / Am7 / G7sus4 / Cmaj7
        tender: {
            bpm: 60,
            brightness: 0.58,
            gains: { pad: 0.040, bass: 0.066, melody: 0.054, arp: 0.022, color: 0.024 },
            melodyBeatProb: [0.42, 0.12, 0.22, 0.10, 0.38, 0.10, 0.20, 0.10],
            color: { motif: 'counter', octave: 5, descending: false },
            progression: [
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 84]),     beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], melodyScale: S([74, 77, 81, 84, 86]),     beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], melodyScale: S([70, 74, 77, 81, 84]),     beats: 4 },
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], melodyScale: S([72, 74, 77, 81, 84]),     beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], melodyScale: S([72, 76, 79, 81]),         beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 67, 71], chordTones: [55, 62, 67, 71], melodyScale: S([74, 76, 79, 81, 84]),     beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], melodyScale: S([72, 74, 76, 79, 84]),     beats: 4 }
            ]
        }
    };

    // Scene-level flavour overrides. Multiple scenes can share a mood but
    // sound subtly different — different density, different layer mix.
    // Properties override mood defaults: tempo, gains.{layer}, density,
    // disable {arp|color|melody|bass}, brightness.
    const SCENE_OVERRIDES = {
        0: { density: 0.85, disableArp: true },                                 // prologue: gentler
        1: { density: 1.0 },                                                    // ants — full
        2: { density: 1.15 },                                                   // homeroom — busier
        3: { density: 0.9, brightnessBoost: -0.08 },                            // PE drill — cooler
        4: { density: 1.1 },                                                    // cafeteria — denser, more talk
        5: { density: 0.85 },                                                   // window in rain — sparse
        6: { density: 0.75, tempoScale: 0.95 },                                 // charging — slower, quiet
        7: { density: 0.65, tempoScale: 0.88, brightnessBoost: -0.08 },         // crushed — slowest, dimmest
        8: { density: 0.9 },                                                    // Ozaki reads — natural
        9: { density: 0.5, disableArp: true, tempoScale: 0.92 },                // Air — sparse awe
        10: { density: 1.1 },                                                   // drawer — closer
        11: { density: 0.7 },                                                   // humming — quiet
        12: { density: 0.6, tempoScale: 0.9 },                                  // door — suspended
        13: { density: 1.0, tempoScale: 0.88, brightnessBoost: 0.05 },          // climax — broadest
        14: { density: 0.9 },                                                   // bare morning
        15: { density: 1.0 }                                                    // coda
    };

    const SCENE_MOODS = {
        0: 'morning',  1: 'morning', 2: 'morning',
        3: 'tension',  4: 'tension',
        5: 'wistful',  6: 'wistful', 7: 'wistful',
        8: 'contemplative', 11: 'contemplative',
        9: 'awe',     12: 'awe',    13: 'awe',
        10: 'intimate',
        14: 'tender', 15: 'tender'
    };

    // ──────────────────────────────────────────────────────────────────
    // Engine state
    // ──────────────────────────────────────────────────────────────────

    const SCHED_INTERVAL_MS = 25;
    const LOOKAHEAD_SEC = 0.20;
    const MOOD_FADE_SEC = 3.5;

    let ctx = null;
    let masterGain = null;
    let musicGain = null;
    let masterVol = 0.8;
    let musicVol = 0.7;

    let mood = null;
    let moodKey = null;
    let override = null;       // current scene's flavour override
    let progIdx = 0;
    let nextChordTime = 0;
    let activeVoices = [];
    let schedTimer = null;
    let lastMelodyMidi = null;

    const midiToHz = (m) => 440 * Math.pow(2, (m - 69) / 12);
    const rand = (a, b) => a + Math.random() * (b - a);

    function effectiveBpm()        { return mood.bpm * (override?.tempoScale ?? 1); }
    function effectiveBrightness() { return Math.max(0, Math.min(1, mood.brightness + (override?.brightnessBoost ?? 0))); }
    function effectiveDensity()    { return override?.density ?? 1; }

    // ──────────────────────────────────────────────────────────────────
    // Context setup
    // ──────────────────────────────────────────────────────────────────

    function ensureCtx() {
        if (ctx) return;
        const Ctor = window.AudioContext || window.webkitAudioContext;
        if (!Ctor) return;
        ctx = new Ctor();
        musicGain = ctx.createGain();
        musicGain.gain.value = musicVol;
        masterGain = ctx.createGain();
        masterGain.gain.value = masterVol;
        musicGain.connect(masterGain);
        masterGain.connect(ctx.destination);
    }

    function resumeCtx() {
        if (ctx && ctx.state === 'suspended') ctx.resume().catch(() => {});
    }

    // ──────────────────────────────────────────────────────────────────
    // Voice factories
    // ──────────────────────────────────────────────────────────────────

    function makePadVoice(midi, when, chordDuration, m) {
        const attack  = 1.4;
        const tail    = 1.5;
        const total   = chordDuration + tail;
        const holdEnd = Math.max(attack + 0.3, total * 0.4);
        const freq    = midiToHz(midi);
        const bright  = effectiveBrightness();

        const osc1 = ctx.createOscillator();
        const osc2 = ctx.createOscillator();
        osc1.type = 'sine';
        osc2.type = 'triangle';
        osc1.frequency.value = freq;
        osc2.frequency.value = freq;
        osc1.detune.value = -rand(4, 8);
        osc2.detune.value =  rand(4, 8);

        const lfo = ctx.createOscillator();
        const lfoAmt = ctx.createGain();
        lfo.frequency.value = rand(0.04, 0.10);
        lfoAmt.gain.value = rand(2.5, 5);
        lfo.connect(lfoAmt);
        lfoAmt.connect(osc1.detune);

        const env = ctx.createGain();
        env.gain.setValueAtTime(0.0001, when);
        env.gain.linearRampToValueAtTime(m.gains.pad, when + attack);
        env.gain.setValueAtTime(m.gains.pad, when + holdEnd);
        env.gain.linearRampToValueAtTime(0.0001, when + total);

        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        const noteBrightness = Math.min(1, Math.max(0, (midi - 48) / 36));
        filter.frequency.value = 380 + bright * (900 + noteBrightness * 1500);
        filter.Q.value = 0.5;

        const panner = ctx.createStereoPanner();
        panner.pan.value = rand(-0.35, 0.35);

        osc1.connect(env);
        osc2.connect(env);
        env.connect(filter);
        filter.connect(panner);
        panner.connect(musicGain);

        const stopAt = when + total + 0.08;
        osc1.start(when);
        osc2.start(when);
        lfo.start(when);
        osc1.stop(stopAt);
        osc2.stop(stopAt);
        lfo.stop(stopAt);

        return { oscs: [osc1, osc2, lfo], env, endTime: stopAt };
    }

    function makeBassVoice(midi, when, duration, m) {
        const freq = midiToHz(midi);
        const bright = effectiveBrightness();

        const osc = ctx.createOscillator();
        osc.type = 'triangle';
        osc.frequency.value = freq;
        const sub = ctx.createOscillator();
        sub.type = 'sine';
        sub.frequency.value = freq;
        sub.detune.value = -2;

        const env = ctx.createGain();
        const peak = m.gains.bass;
        env.gain.setValueAtTime(0.0001, when);
        env.gain.linearRampToValueAtTime(peak, when + 0.08);
        env.gain.exponentialRampToValueAtTime(peak * 0.25, when + 1.6);
        env.gain.exponentialRampToValueAtTime(0.001, when + duration);
        env.gain.linearRampToValueAtTime(0.0001, when + duration + 0.05);

        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        filter.frequency.value = 220 + bright * 180;
        filter.Q.value = 0.6;

        osc.connect(env);
        sub.connect(env);
        env.connect(filter);
        filter.connect(musicGain);

        const stopAt = when + duration + 0.08;
        osc.start(when);
        sub.start(when);
        osc.stop(stopAt);
        sub.stop(stopAt);

        return { oscs: [osc, sub], env, endTime: stopAt };
    }

    function makeMelodyNote(midi, when, duration, m) {
        const freq = midiToHz(midi);
        const bright = effectiveBrightness();

        const osc1 = ctx.createOscillator();
        osc1.type = 'triangle';
        osc1.frequency.value = freq;

        const osc2 = ctx.createOscillator();
        osc2.type = 'sine';
        osc2.frequency.value = freq;
        osc2.detune.value = rand(3, 7);

        const env = ctx.createGain();
        const peak = m.gains.melody;
        env.gain.setValueAtTime(0.0001, when);
        env.gain.linearRampToValueAtTime(peak, when + 0.06);
        env.gain.exponentialRampToValueAtTime(peak * 0.35, when + 0.7);
        env.gain.exponentialRampToValueAtTime(0.001, when + duration);
        env.gain.linearRampToValueAtTime(0.0001, when + duration + 0.05);

        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        filter.frequency.value = 1100 + bright * 2400;
        filter.Q.value = 0.6;

        const panner = ctx.createStereoPanner();
        panner.pan.value = rand(-0.25, 0.25);

        osc1.connect(env);
        osc2.connect(env);
        env.connect(filter);
        filter.connect(panner);
        panner.connect(musicGain);

        const stopAt = when + duration + 0.08;
        osc1.start(when);
        osc2.start(when);
        osc1.stop(stopAt);
        osc2.stop(stopAt);

        return { oscs: [osc1, osc2], env, endTime: stopAt };
    }

    // Plucky arp note — single triangle osc, fast attack, fast decay
    function makeArpNote(midi, when, duration, m, peakOverride) {
        const freq = midiToHz(midi);
        const bright = effectiveBrightness();

        const osc = ctx.createOscillator();
        osc.type = 'triangle';
        osc.frequency.value = freq;

        const env = ctx.createGain();
        const peak = peakOverride ?? m.gains.arp;
        env.gain.setValueAtTime(0.0001, when);
        env.gain.linearRampToValueAtTime(peak, when + 0.018);
        env.gain.exponentialRampToValueAtTime(0.001, when + duration);
        env.gain.linearRampToValueAtTime(0.0001, when + duration + 0.04);

        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        filter.frequency.value = (m.arp?.filter ?? 2000) + bright * 600;
        filter.Q.value = 0.5;

        const panner = ctx.createStereoPanner();
        panner.pan.value = rand(-0.4, 0.4);

        osc.connect(env);
        env.connect(filter);
        filter.connect(panner);
        panner.connect(musicGain);

        const stopAt = when + duration + 0.08;
        osc.start(when);
        osc.stop(stopAt);

        return { oscs: [osc], env, endTime: stopAt };
    }

    // Bell — sine with slow attack and long decay; used for the "color" layer
    // in awe and contemplative
    function makeBell(midi, when, duration, m) {
        const freq = midiToHz(midi);

        const osc = ctx.createOscillator();
        osc.type = 'sine';
        osc.frequency.value = freq;

        const overtone = ctx.createOscillator();
        overtone.type = 'sine';
        overtone.frequency.value = freq * 2.01;  // slightly inharmonic
        const overGain = ctx.createGain();
        overGain.gain.value = 0.18;
        overtone.connect(overGain);

        const env = ctx.createGain();
        const peak = m.gains.color;
        env.gain.setValueAtTime(0.0001, when);
        env.gain.linearRampToValueAtTime(peak, when + 0.04);
        env.gain.exponentialRampToValueAtTime(0.001, when + duration);
        env.gain.linearRampToValueAtTime(0.0001, when + duration + 0.05);

        const panner = ctx.createStereoPanner();
        panner.pan.value = rand(-0.5, 0.5);

        osc.connect(env);
        overGain.connect(env);
        env.connect(panner);
        panner.connect(musicGain);

        const stopAt = when + duration + 0.10;
        osc.start(when);
        overtone.start(when);
        osc.stop(stopAt);
        overtone.stop(stopAt);

        return { oscs: [osc, overtone], env, endTime: stopAt };
    }

    // ──────────────────────────────────────────────────────────────────
    // Pickers
    // ──────────────────────────────────────────────────────────────────

    function pickMelodyMidi(chord, m) {
        const scale = chord.melodyScale || m.melodyScale;
        const chordSet = new Set(chord.chordTones.map(t => ((t % 12) + 12) % 12));

        const weights = scale.map(midi => {
            const pc = ((midi % 12) + 12) % 12;
            let w = chordSet.has(pc) ? 3 : 1;
            if (lastMelodyMidi !== null) {
                const dist = Math.abs(midi - lastMelodyMidi);
                if (dist === 0)      w *= 0.3;
                else if (dist <= 2)  w *= 2.0;
                else if (dist <= 4)  w *= 1.4;
                else if (dist <= 7)  w *= 0.9;
                else                  w *= 0.5;
            }
            return w;
        });

        const total = weights.reduce((a, b) => a + b, 0);
        let r = Math.random() * total;
        for (let i = 0; i < scale.length; i++) {
            r -= weights[i];
            if (r <= 0) {
                lastMelodyMidi = scale[i];
                return scale[i];
            }
        }
        return scale[scale.length - 1];
    }

    function pickCounterMidi(chord, m, ascending) {
        // For "counter" color motif: pick chord-tone in chosen direction
        const tones = chord.chordTones.slice().sort((a, b) => ascending ? a - b : b - a);
        const idx = Math.floor(Math.random() * Math.min(3, tones.length));
        return tones[idx] + 12; // octave up
    }

    // ──────────────────────────────────────────────────────────────────
    // Scheduling per chord
    // ──────────────────────────────────────────────────────────────────

    function scheduleChord(idx, when) {
        const chord = mood.progression[idx];
        const bpm = effectiveBpm();
        const beatSec = 60 / bpm;
        const chordDur = chord.beats * beatSec;
        const density = effectiveDensity();
        const inB = idx >= mood.progression.length / 2;

        // Bass — always plays
        if (!override?.disableBass) {
            chord.bass.forEach(midi => {
                activeVoices.push(makeBassVoice(midi, when, chordDur, mood));
            });
        }

        // Pad — always plays
        chord.pad.forEach(midi => {
            activeVoices.push(makePadVoice(midi, when, chordDur, mood));
        });

        // Melody — sparse, weighted, stepwise-biased
        if (!override?.disableMelody) {
            const probs = mood.melodyBeatProb;
            const halfBeats = chord.beats * 2;
            for (let hb = 0; hb < halfBeats; hb++) {
                const p = probs[hb % probs.length] * density;
                if (Math.random() < p) {
                    const midi = pickMelodyMidi(chord, mood);
                    const noteT = when + hb * (beatSec / 2);
                    const noteDur = beatSec * rand(1.3, 2.4);
                    activeVoices.push(makeMelodyNote(midi, noteT, noteDur, mood));
                }
            }
        }

        // Arp layer — broken chord pulses
        if (mood.arp && !override?.disableArp) {
            const appliesB = mood.arp.applyTo !== 'A';
            const appliesA = mood.arp.applyTo !== 'B';
            const apply = inB ? appliesB : appliesA;
            if (apply) {
                const rate = mood.arp.rate; // notes per beat
                const arpDur = (beatSec / rate) * 1.4;
                const total = chord.beats * rate;
                const tones = chord.chordTones.slice();
                for (let i = 0; i < total; i++) {
                    // Skip first eighth to let the chord land, light syncopation
                    if (i === 0 && Math.random() < 0.5) continue;
                    if (Math.random() > 0.85 * density) continue;
                    const midi = tones[i % tones.length] + mood.arp.octaveOffset;
                    const noteT = when + i * (beatSec / rate);
                    activeVoices.push(makeArpNote(midi, noteT, arpDur, mood));
                }
            }
        }

        // Color layer — bell / counter
        if (mood.color && !override?.disableColor) {
            const motif = mood.color.motif;
            if (motif === 'bell') {
                // High bell on chord change, 30% chance of a second halfway
                const bellMidi = chord.chordTones[Math.floor(Math.random() * chord.chordTones.length)] + (mood.color.octave - 4) * 12;
                activeVoices.push(makeBell(bellMidi, when + 0.05, chordDur * 0.9, mood));
                if (Math.random() < 0.35 * density) {
                    const m2 = chord.chordTones[Math.floor(Math.random() * chord.chordTones.length)] + (mood.color.octave - 4) * 12 + 5;
                    activeVoices.push(makeBell(m2, when + chordDur * 0.55, chordDur * 0.45, mood));
                }
            } else if (motif === 'counter') {
                // Slow counter-melody — one note per chord, ascending or descending across loop
                const cm = pickCounterMidi(chord, mood, !mood.color.descending);
                const dur = beatSec * 3;
                activeVoices.push(makeMelodyNote(cm + ((mood.color.octave - 5) * 12), when + beatSec * 1.5, dur, mood));
            } else if (motif === 'drone') {
                // Sustained soft drone on the 5th of the root
                const droneMidi = chord.bass[0] + 7 + ((mood.color.octave - 4) * 12);
                activeVoices.push(makePadVoice(droneMidi, when, chordDur, {
                    ...mood,
                    gains: { ...mood.gains, pad: mood.gains.color }
                }));
            }
        }
    }

    function scheduler() {
        if (!ctx || !mood) return;
        const now = ctx.currentTime;
        const horizon = now + LOOKAHEAD_SEC;

        while (nextChordTime < horizon) {
            scheduleChord(progIdx, nextChordTime);
            const chord = mood.progression[progIdx];
            const beatSec = 60 / effectiveBpm();
            nextChordTime += chord.beats * beatSec;
            progIdx = (progIdx + 1) % mood.progression.length;
        }

        activeVoices = activeVoices.filter(v => v.endTime > now);
    }

    function startScheduler() {
        if (schedTimer !== null) return;
        scheduler();
        schedTimer = setInterval(scheduler, SCHED_INTERVAL_MS);
    }

    function stopScheduler() {
        if (schedTimer !== null) {
            clearInterval(schedTimer);
            schedTimer = null;
        }
    }

    function fadeOutVoices(voices, fadeSec) {
        if (!ctx) return;
        const t = ctx.currentTime;
        voices.forEach(v => {
            try {
                v.env.gain.cancelScheduledValues(t);
                const cur = v.env.gain.value;
                v.env.gain.setValueAtTime(cur, t);
                v.env.gain.linearRampToValueAtTime(0.0001, t + fadeSec);
                v.oscs.forEach(o => {
                    try { o.stop(t + fadeSec + 0.05); } catch (e) {}
                });
            } catch (e) {}
        });
    }

    // ──────────────────────────────────────────────────────────────────
    // Public API
    // ──────────────────────────────────────────────────────────────────

    function applyMoodAndOverride(newMoodKey, scene) {
        const newOverride = (scene != null) ? (SCENE_OVERRIDES[scene] ?? null) : null;

        // If only the override is different but mood is unchanged, swap override
        // in place (no fadeout) — keeps the music continuous within a mood.
        if (newMoodKey === moodKey && mood) {
            override = newOverride;
            return;
        }

        stopScheduler();
        fadeOutVoices(activeVoices, MOOD_FADE_SEC);
        activeVoices = [];
        lastMelodyMidi = null;

        mood = MOODS[newMoodKey];
        moodKey = newMoodKey;
        override = newOverride;
        progIdx = 0;
        nextChordTime = ctx.currentTime + 0.05;
        startScheduler();
    }

    function setMood(newKey) {
        ensureCtx();
        if (!ctx) return;
        resumeCtx();
        if (!MOODS[newKey]) return;
        applyMoodAndOverride(newKey, null);
    }

    function setSceneMood(scene) {
        ensureCtx();
        if (!ctx) return;
        resumeCtx();
        const key = SCENE_MOODS[scene];
        if (key && MOODS[key]) applyMoodAndOverride(key, scene);
    }

    function clampVol(v) {
        v = Number(v);
        if (!isFinite(v)) return 0;
        return Math.max(0, Math.min(1, v));
    }

    function setMasterVolume(v) {
        masterVol = clampVol(v);
        if (!masterGain) return;
        const t = ctx.currentTime;
        masterGain.gain.cancelScheduledValues(t);
        masterGain.gain.setValueAtTime(masterGain.gain.value, t);
        masterGain.gain.linearRampToValueAtTime(masterVol, t + 0.15);
    }

    function setMusicVolume(v) {
        musicVol = clampVol(v);
        if (!musicGain) return;
        const t = ctx.currentTime;
        musicGain.gain.cancelScheduledValues(t);
        musicGain.gain.setValueAtTime(musicGain.gain.value, t);
        musicGain.gain.linearRampToValueAtTime(musicVol, t + 0.15);
    }

    function start() {
        ensureCtx();
        resumeCtx();
    }

    function stop() {
        stopScheduler();
        fadeOutVoices(activeVoices, MOOD_FADE_SEC);
        activeVoices = [];
        mood = null;
        moodKey = null;
        override = null;
        lastMelodyMidi = null;
    }

    window.ambient = {
        start,
        stop,
        setMood,
        setSceneMood,
        setMasterVolume,
        setMusicVolume
    };
})();
