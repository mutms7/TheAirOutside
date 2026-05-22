// Ambient music engine for "The Air Outside".
// Procedural — no audio files, no external libraries.
// Each scene maps to a "mood": a chord voicing + character settings.
// Voices are sine/triangle oscillators with slow LFO detune and per-voice stereo pan.
// Mood transitions crossfade over ~4 seconds. The whole thing is intentionally quiet.
(function () {
    'use strict';

    const MOODS = {
        // Warm, hopeful — morning light, ordinary day.
        morning: {
            chord: [36, 48, 55, 60, 64, 67],
            brightness: 0.55,
            detune: 6,
            lfoHz: 0.06,
            gain: 0.045
        },
        // Cool, sparse — drills, conformity pressure.
        tension: {
            chord: [38, 50, 53, 57, 65],
            brightness: 0.30,
            detune: 9,
            lfoHz: 0.11,
            gain: 0.035
        },
        // Gentle minor — wistful, the window, the rain.
        wistful: {
            chord: [33, 45, 52, 57, 64, 67],
            brightness: 0.38,
            detune: 5,
            lfoHz: 0.05,
            gain: 0.045
        },
        // Open suspended — contemplative, in-between.
        contemplative: {
            chord: [36, 48, 50, 55, 62, 67],
            brightness: 0.48,
            detune: 4,
            lfoHz: 0.04,
            gain: 0.042
        },
        // Close, warm — Tae's room, intimate.
        intimate: {
            chord: [29, 41, 48, 53, 60, 65],
            brightness: 0.50,
            detune: 7,
            lfoHz: 0.07,
            gain: 0.045
        },
        // Wide and shimmering — climax, awe.
        awe: {
            chord: [24, 36, 48, 55, 60, 67, 72, 79],
            brightness: 0.68,
            detune: 4,
            lfoHz: 0.035,
            gain: 0.040
        },
        // Soft major resolution — after.
        tender: {
            chord: [29, 41, 48, 57, 60, 64, 67],
            brightness: 0.58,
            detune: 5,
            lfoHz: 0.055,
            gain: 0.045
        }
    };

    // Scene number → mood key. Scene 0 is the prologue.
    const SCENE_MOODS = {
        0: 'morning',
        1: 'morning',
        2: 'morning',
        3: 'tension',
        4: 'tension',
        5: 'wistful',
        6: 'wistful',
        7: 'wistful',
        8: 'contemplative',
        9: 'awe',
        10: 'intimate',
        11: 'contemplative',
        12: 'awe',
        13: 'awe',
        14: 'tender',
        15: 'tender'
    };

    const FADE_SEC = 4.0;

    let ctx = null;
    let masterGain = null;
    let musicGain = null;
    let voices = [];
    let currentMood = null;
    let masterVol = 0.8;
    let musicVol = 0.7;

    const midiToFreq = (m) => 440 * Math.pow(2, (m - 69) / 12);

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

    function createVoice(midi, mood) {
        const t = ctx.currentTime;
        const freq = midiToFreq(midi);

        const osc1 = ctx.createOscillator();
        const osc2 = ctx.createOscillator();
        osc1.type = 'sine';
        osc2.type = 'triangle';
        osc1.frequency.value = freq;
        osc2.frequency.value = freq;
        osc1.detune.value = -mood.detune;
        osc2.detune.value =  mood.detune;

        // Slow LFO for breathing detune — keeps the chord alive.
        const lfo = ctx.createOscillator();
        const lfoAmt = ctx.createGain();
        lfo.frequency.value = mood.lfoHz * (0.7 + Math.random() * 0.6);
        lfo.type = 'sine';
        lfoAmt.gain.value = 4 + Math.random() * 4;
        lfo.connect(lfoAmt);
        lfoAmt.connect(osc1.detune);

        // Triangle oscillator gets a tiny softer LFO too.
        const lfo2Amt = ctx.createGain();
        lfo2Amt.gain.value = 2 + Math.random() * 3;
        lfo.connect(lfo2Amt);
        lfo2Amt.connect(osc2.detune);

        // Volume envelope — long attack so transitions are gentle.
        const env = ctx.createGain();
        env.gain.value = 0;
        env.gain.linearRampToValueAtTime(mood.gain, t + FADE_SEC);

        // Lowpass — keeps it warm. Higher-midi notes get slightly more brightness.
        const filter = ctx.createBiquadFilter();
        filter.type = 'lowpass';
        const noteBrightness = Math.min(1, midi / 84);
        filter.frequency.value = 280 + mood.brightness * (1100 + noteBrightness * 1400);
        filter.Q.value = 0.6;

        // Wide stereo so chord feels spacious.
        const panner = ctx.createStereoPanner();
        panner.pan.value = (Math.random() - 0.5) * 0.7;

        osc1.connect(env);
        osc2.connect(env);
        env.connect(filter);
        filter.connect(panner);
        panner.connect(musicGain);

        osc1.start(t);
        osc2.start(t);
        lfo.start(t);

        return { osc1, osc2, lfo, env, filter, panner };
    }

    function stopVoice(v, when) {
        try {
            v.env.gain.cancelScheduledValues(when);
            v.env.gain.setValueAtTime(v.env.gain.value, when);
            v.env.gain.linearRampToValueAtTime(0, when + FADE_SEC);
            const stopAt = when + FADE_SEC + 0.05;
            v.osc1.stop(stopAt);
            v.osc2.stop(stopAt);
            v.lfo.stop(stopAt);
        } catch (e) { /* already stopped */ }
    }

    function setMood(moodName) {
        ensureCtx();
        if (!ctx) return;
        resumeCtx();
        if (!MOODS[moodName] || moodName === currentMood) return;

        const t = ctx.currentTime;
        // Fade out and stop old voices.
        voices.forEach(v => stopVoice(v, t));
        voices = [];

        // Start the new chord.
        const mood = MOODS[moodName];
        voices = mood.chord.map(m => createVoice(m, mood));
        currentMood = moodName;
    }

    function setSceneMood(scene) {
        const mood = SCENE_MOODS[scene];
        if (mood) setMood(mood);
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
        if (!ctx) return;
        const t = ctx.currentTime;
        voices.forEach(v => stopVoice(v, t));
        voices = [];
        currentMood = null;
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
