// Ambient music engine for "The Air Outside".
// Procedural — no audio files. Each scene maps to a "mood": a tempo, a
// 4-chord progression, a melody scale, and gain/brightness settings.
//
// Layers per chord:
//   bass     — short attack, long decay; root + low octave
//   pad      — sustained chord voicing, slow attack
//   melody   — sparse notes drawn from the mood's scale (chord tones
//              weighted higher), played at probabilistic half-beat positions
//
// Mood transitions crossfade over ~4 seconds while the new progression
// starts fresh from its first chord.
//
// Scheduling uses the standard "two clocks" pattern: a setInterval that
// looks ~180ms ahead and queues notes with absolute AudioContext times.
(function () {
    'use strict';

    // ──────────────────────────────────────────────────────────────────
    // Mood definitions. All MIDI numbers; 60 = middle C.
    // ──────────────────────────────────────────────────────────────────

    const MOODS = {
        // I  vi  IV  V — warm, hopeful. Cmaj9 → Am9 → Fmaj9 → G7sus4
        morning: {
            bpm: 60,
            brightness: 0.55,
            gains: { pad: 0.040, bass: 0.075, melody: 0.062 },
            melodyBeatProb: [0.55, 0.08, 0.30, 0.10, 0.45, 0.08, 0.25, 0.10],
            melodyScale: [72, 74, 76, 79, 81, 84],         // C5 D5 E5 G5 A5 C6 (Cmaj pentatonic)
            progression: [
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 77], beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 67, 71], chordTones: [55, 62, 67, 71], beats: 4 }
            ]
        },

        // i  bVI  bIII  V7 — uneasy, unresolved. Dm9 → Bbmaj7 → Fmaj7 → A7sus4
        tension: {
            bpm: 54,
            brightness: 0.30,
            gains: { pad: 0.034, bass: 0.062, melody: 0.048 },
            melodyBeatProb: [0.35, 0.05, 0.15, 0.05, 0.30, 0.05, 0.15, 0.05],
            melodyScale: [74, 77, 79, 81, 84, 89],         // D5 F5 G5 A5 C6 F6 (modal Dm)
            progression: [
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 76], beats: 4 },
                { bass: [33, 45], pad: [57, 62, 64, 67, 71], chordTones: [57, 62, 64, 67], beats: 4 }
            ]
        },

        // i  bVI  bIII  bVII — gentle longing. Am9 → Fmaj7 → Cmaj7 → G6
        wistful: {
            bpm: 56,
            brightness: 0.38,
            gains: { pad: 0.038, bass: 0.068, melody: 0.055 },
            melodyBeatProb: [0.45, 0.10, 0.25, 0.10, 0.40, 0.08, 0.20, 0.10],
            melodyScale: [69, 72, 76, 79, 81, 84],         // A4 C5 E5 G5 A5 C6 (Am add B)
            progression: [
                { bass: [33, 45], pad: [57, 60, 64, 67, 71], chordTones: [57, 60, 64, 67], beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 76], chordTones: [65, 69, 72, 76], beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 72, 74], chordTones: [60, 64, 67, 71], beats: 4 },
                { bass: [35, 47], pad: [55, 59, 62, 67, 71], chordTones: [55, 59, 62, 67], beats: 4 }
            ]
        },

        // All suspensions — open, in-between. Csus2 → Fsus2 → G6sus4 → Csus2
        contemplative: {
            bpm: 52,
            brightness: 0.46,
            gains: { pad: 0.036, bass: 0.058, melody: 0.045 },
            melodyBeatProb: [0.35, 0.04, 0.12, 0.04, 0.28, 0.04, 0.10, 0.04],
            melodyScale: [72, 74, 76, 79, 81, 84],         // C5 D5 E5 G5 A5 C6
            progression: [
                { bass: [36, 48], pad: [60, 62, 67, 72, 74], chordTones: [60, 62, 67, 74], beats: 4 },
                { bass: [29, 41], pad: [60, 65, 67, 72, 77], chordTones: [65, 67, 72, 77], beats: 4 },
                { bass: [31, 43], pad: [55, 60, 62, 64, 67], chordTones: [55, 62, 64, 67], beats: 4 },
                { bass: [36, 48], pad: [60, 62, 67, 72, 74], chordTones: [60, 62, 67, 74], beats: 4 }
            ]
        },

        // ii-V loop on F — close and warm. Fmaj9 → Am11 → Dm9 → Bbmaj7
        intimate: {
            bpm: 64,
            brightness: 0.52,
            gains: { pad: 0.042, bass: 0.072, melody: 0.060 },
            melodyBeatProb: [0.55, 0.15, 0.35, 0.15, 0.50, 0.10, 0.30, 0.15],
            melodyScale: [72, 74, 77, 79, 81, 84, 86],     // C5 D5 F5 G5 A5 C6 D6
            progression: [
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 67, 71, 74], chordTones: [57, 60, 64, 67, 71], beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], beats: 4 }
            ]
        },

        // I  V  vi  IV — slow, wide. C → G/B → Am → F (octave-doubled root)
        awe: {
            bpm: 50,
            brightness: 0.65,
            gains: { pad: 0.040, bass: 0.062, melody: 0.052 },
            melodyBeatProb: [0.30, 0.0, 0.10, 0.0, 0.22, 0.0, 0.06, 0.0],
            melodyScale: [79, 84, 88, 91, 96],              // G5 C6 E6 G6 C7 (bell-like high)
            progression: [
                { bass: [24, 36, 48], pad: [55, 60, 64, 67, 72], chordTones: [60, 64, 67, 72], beats: 4 },
                { bass: [23, 35, 47], pad: [55, 59, 62, 67, 74], chordTones: [55, 59, 62, 67], beats: 4 },
                { bass: [33, 45], pad: [57, 60, 64, 69, 72], chordTones: [57, 60, 64, 69], beats: 4 },
                { bass: [29, 41], pad: [60, 65, 69, 72, 77], chordTones: [65, 69, 72, 77], beats: 4 }
            ]
        },

        // IV  I  ii  bVII — soft resolution. Fmaj9 → Cmaj7 → Dm9 → Bbmaj7
        tender: {
            bpm: 60,
            brightness: 0.58,
            gains: { pad: 0.042, bass: 0.068, melody: 0.058 },
            melodyBeatProb: [0.45, 0.10, 0.25, 0.10, 0.40, 0.08, 0.20, 0.10],
            melodyScale: [72, 74, 77, 81, 84, 86],         // C5 D5 F5 A5 C6 D6
            progression: [
                { bass: [29, 41], pad: [57, 60, 65, 69, 72], chordTones: [57, 60, 65, 69], beats: 4 },
                { bass: [36, 48], pad: [60, 64, 67, 71, 74], chordTones: [60, 64, 67, 71], beats: 4 },
                { bass: [38, 50], pad: [62, 65, 69, 72, 76], chordTones: [62, 65, 69, 72], beats: 4 },
                { bass: [34, 46], pad: [58, 62, 65, 69, 72], chordTones: [58, 62, 65, 69], beats: 4 }
            ]
        }
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
    const LOOKAHEAD_SEC = 0.18;
    const MOOD_FADE_SEC = 3.5;

    let ctx = null;
    let masterGain = null;
    let musicGain = null;
    let masterVol = 0.8;
    let musicVol = 0.7;

    let mood = null;
    let moodKey = null;
    let progIdx = 0;
    let nextChordTime = 0;
    let activeVoices = [];   // currently playing voices, pruned by scheduler
    let schedTimer = null;

    const midiToHz = (m) => 440 * Math.pow(2, (m - 69) / 12);
    const rand = (a, b) => a + Math.random() * (b - a);

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
        if (ctx && ctx.state === 'suspended') {
            ctx.resume().catch(() => {});
        }
    }

    // ──────────────────────────────────────────────────────────────────
    // Voice factories
    // ──────────────────────────────────────────────────────────────────

    function makePadVoice(midi, when, chordDuration, m) {
        // Pad voice lives past the chord boundary so the next chord's pad
        // attack overlaps with this chord's release. No silence valleys.
        const attack = 1.4;
        const tail   = 1.5;
        const total  = chordDuration + tail;
        const holdEnd = Math.max(attack + 0.3, total * 0.4);

        const freq = midiToHz(midi);

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
        filter.frequency.value = 380 + m.brightness * (900 + noteBrightness * 1500);
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
        // Slow decay — bass pulses on the chord change and sinks under the pad
        env.gain.exponentialRampToValueAtTime(peak * 0.25, when + 1.6);
        env.gain.exponentialRampToValueAtTime(0.001, when + duration);
        env.gain.linearRampToValueAtTime(0.0001, when + duration + 0.05);

        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        filter.frequency.value = 220 + m.brightness * 180;
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
        filter.frequency.value = 1100 + m.brightness * 2400;
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

    // ──────────────────────────────────────────────────────────────────
    // Melody picker — weight chord tones higher than scale-only notes
    // ──────────────────────────────────────────────────────────────────

    function pickMelodyMidi(chord, m) {
        const scale = m.melodyScale;
        const chordSet = new Set();
        chord.chordTones.forEach(t => {
            // Match by pitch class so any octave of a chord tone counts as "in chord"
            chordSet.add(((t % 12) + 12) % 12);
        });
        // Weighted: chord tones ×3, other scale notes ×1
        const weighted = [];
        scale.forEach(midi => {
            const pc = ((midi % 12) + 12) % 12;
            const weight = chordSet.has(pc) ? 3 : 1;
            for (let i = 0; i < weight; i++) weighted.push(midi);
        });
        return weighted[Math.floor(Math.random() * weighted.length)];
    }

    // ──────────────────────────────────────────────────────────────────
    // Scheduler
    // ──────────────────────────────────────────────────────────────────

    function scheduleChord(idx, when) {
        const chord = mood.progression[idx];
        const beatSec = 60 / mood.bpm;
        const chordDur = chord.beats * beatSec;

        // Bass
        chord.bass.forEach(midi => {
            activeVoices.push(makeBassVoice(midi, when, chordDur, mood));
        });

        // Pad
        chord.pad.forEach(midi => {
            activeVoices.push(makePadVoice(midi, when, chordDur, mood));
        });

        // Melody — sparse, probabilistic per half-beat
        const probs = mood.melodyBeatProb;
        const halfBeats = chord.beats * 2;
        for (let hb = 0; hb < halfBeats; hb++) {
            const p = probs[hb % probs.length];
            if (Math.random() < p) {
                const midi = pickMelodyMidi(chord, mood);
                const noteT = when + hb * (beatSec / 2);
                const noteDur = beatSec * rand(1.3, 2.4);
                activeVoices.push(makeMelodyNote(midi, noteT, noteDur, mood));
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
            const beatSec = 60 / mood.bpm;
            nextChordTime += chord.beats * beatSec;
            progIdx = (progIdx + 1) % mood.progression.length;
        }

        // Prune voices that have finished playing
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

    // ──────────────────────────────────────────────────────────────────
    // Mood crossfade
    // ──────────────────────────────────────────────────────────────────

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

    function setMood(newKey) {
        ensureCtx();
        if (!ctx) return;
        resumeCtx();
        if (!MOODS[newKey] || newKey === moodKey) return;

        // Fade out everything currently playing.
        stopScheduler();
        fadeOutVoices(activeVoices, MOOD_FADE_SEC);
        activeVoices = [];

        // Start the new progression. We let it overlap the fadeout — both
        // mood layers play during the 3.5s crossfade.
        mood = MOODS[newKey];
        moodKey = newKey;
        progIdx = 0;
        nextChordTime = ctx.currentTime + 0.05;
        startScheduler();
    }

    function setSceneMood(scene) {
        const key = SCENE_MOODS[scene];
        if (key) setMood(key);
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
