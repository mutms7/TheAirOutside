// scenes/09-malfunction.ink — Scene 9: "Air" (~4 min)
//
// Pacing: normal (the breach itself wants to feel sudden, not held).
// No branch. The story owns this beat: the body remembers before the mind
// is ready, and the mind closes immediately. No reflection in dialogue.
//
// Renderer note: the suit-bare voice toggle would happen here if Wren spoke
// — but Wren does not speak during the breach. The two seconds of contact
// are narration only.

=== malfunction ===
# scene: 9
# pacing: normal
# voice: modulated

-> empty_corridor


= empty_corridor
# bg: hallway-day
# char: wren neutral

The corridor between fifth and sixth period. The other students are already in my classrooms.

I am walking alone.

# speaker: hud
SIXTH PERIOD in 3 minutes.

The hallway is empty. The fluorescent overheads hum, very faintly, where the suit's audio filter does not fully suppress them.

I walk.

-> the_alert


= the_alert
# sfx: seal-alert

# speaker: hud
SEAL WARN. CHEST 1.

A small chime. I have gotten warnings before. Humidity, pressure, transient noise. I keep walking.

# speaker: hud
SEAL WARN. CHEST 1.

The chime is louder. I slow.

# speaker: hud
SEAL WARN. CHEST 1.

# sfx: seal-fail

-> the_breach


= the_breach
# audio: ambient-hallway-direct
# art: chest-seal-crack

# speaker: hud
SEAL FAILURE. CHEST 1. RESEALING.

For two seconds, the chest plate is cracked open along its central seam.

Air.

Cool air. On the collarbone. On the bare skin of the upper sternum that the suit normally covers and no one touches.

The hallway air has a smell. Floor wax, faintly. The hallway air has a sound. The small whisper of the building's ventilation, not muffled by the helmet shell. A small rush.

My lungs catch on a breath the suit's intake regulator did not soften.

My heart rate jumps. Recorded, flagged, archived.

I do not move.

-> the_close
# sfx: seal-close


= the_close
# audio: ambient-hallway-muffled

The chest plate closes again.

Two seconds. The whole event.

The seal-glow runs once around the chest plate, diagnostic. Settles into standby.

# speaker: hud
SEAL re-engaged. Replacement recommended. NURSE OFFICE. 30 meters.

I am standing in the empty corridor with my suit fully sealed.

I am shaking inside the suit.

I stop shaking.

I have decided not to think about it.

The HUD's bio-monitor scrolls a small graph of the heart rate spike, levels it, archives it. The graph goes away.

The whole event is now a four-line entry in the suit log.

-> the_nurse


= the_nurse
# bg: nurse-office

The nurse's office is at the end of the corridor. The door is open. The nurse. A middle-aged woman in a clean white over-coat over a beige service-class suit. Does not look surprised.

# speaker: hud
NURSE-OFFICE INTERCOM: Sit down. Lift the chest plate. I'll swap the gasket.

I sit on the small examination bench. The chest plate hinges back, slow and controlled this time. The way it is supposed to.

The nurse runs a hand-tool along the seam, pulls a degraded gasket out, slots a fresh one in. It takes maybe ninety seconds.

# speaker: hud
NURSE-OFFICE INTERCOM: Humidity gets them this time of year. Especially the older models. Don't worry about it.

I do not say what I need to say. I do not know what I need to say. I nod.

The chest plate closes.

The seal-glow runs around its rim and settles.

# speaker: hud
NURSE-OFFICE INTERCOM: You can go.

I stand up. I say "Thank you" in the suit-warmed voice that comes out a half-pitch too friendly.

# speaker: wren
Thank you.

I walk out.

-> after_nurse


= after_nurse
# bg: hallway-day

The hallway is filling up again. Sixth period has just started somewhere; some hallway noise has come back.

I walk past the window at the far end of the corridor. The rain has started again, very lightly. The window shows the rain. The suit-cam does not auto-zoom this time.

# speaker: hud
SIXTH PERIOD already in progress. You may report as late or proceed quietly.

I proceed quietly.

The four-line entry in the suit log is not currently visible. I do not look it up. I will not look it up.

I am fine.

# speaker: hud
SIXTH PERIOD: in session.

-> taes_drawer
