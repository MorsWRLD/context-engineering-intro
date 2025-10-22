# Memento Re Time Tracker — UI Reference

Purpose
- Capture the visual system from your Memento Re UI and make it actionable for implementation and future reskins.
- Centralize links to the source video/images and distilled design tokens, states, and motion specs.

Source assets
- Primary reference video (local): C:\Users\kiril\Downloads\Memento RE (1) (2).mp4
  - Note: If your actual filename contains backticks, that was likely PowerShell escaping. The real file is probably named without backticks as shown above.
- Optional: Export key PNG frames from Canva and place them here: assets/reference/
  - Suggested naming: frame_0001.png, frame_0002.png, ...

Extracting frames (optional, for visual review)
- Using ffmpeg (if installed). Run in PowerShell:
  $video = "C:\Users\kiril\Downloads\Memento RE (1) (2).mp4"
  $outDir = "C:\Users\kiril\context-engineering-intro\assets\reference\video_frames"
  New-Item -ItemType Directory -Force -Path $outDir | Out-Null
  ffmpeg -i $video -vf fps=1 "$outDir\frame_%04d.png"
- If ffmpeg isn’t installed, export PNGs directly from Canva and copy them into assets/reference/.

Design tokens (derived from INITIAL.md and PRP.md; refine from images/video)
- Colors
  - background: #0A0A0A
  - neonPink: #FF006E
  - neonBlue: #00D9FF
  - successGreen: #00FF88
  - warningOrange: #FF9500
  - errorRed: #FF0040
- Typography
  - heading: Inter/Roboto (bold)
  - numerals (timer): Monospace (high legibility)
- Effects
  - glow.pink: color=#FF006E, blur=24–48px, intensity=0.6–1.0
  - glow.blue: color=#00D9FF, blur=24–48px, intensity=0.6–1.0
  - ring.shadow: y=0, blur=16–24px, color=rgba(0,0,0,0.6)
- Rings (example — confirm with frames)
  - outer.radius=180, stroke=16, glow=blue
  - inner.radius=140, stroke=12, glow=pink
  - tickMarks: every 5 degrees, subtle
- Layout
  - timer.centered, margin 24–32
  - controls below timer, spacing 16–24
  - stats panel beneath controls (daily total, streak)

UI states
- Idle
  - Timer at 00:00:00, subtle ambient glow
  - Start button prominent
- Running
  - Progress sweep around circular ring
  - Glow pulses gently (1.0–1.5s loop)
  - Mode color accent (Chill=pink, Grind=blue)
- Paused
  - Progress freeze, glow reduces intensity
  - Resume/Stop buttons visible
- Completed
  - Reward popup: XP, Credits, streak bonus
  - Brief particle burst on ring

Mode system (visual)
- Chill
  - Accent: neonPink
  - Glow bias: pink
- Grind
  - Accent: neonBlue
  - Glow bias: blue

Motion specs (tune from video/PNGs)
- Start transition: 250–350ms easeOut, ring glow ramps in
- Pause/resume: 180–240ms easeInOut, lower glow intensity on pause
- Reward popup: scale 0.9 → 1.0 over 160ms with slight overshoot, particles fade in 300–500ms

Implementation mapping
- Tokenization: see docs/THEME_PACKS.md
- The timer painter consumes:
  - rings[*].radius, rings[*].strokeWidth
  - color.active, color.inactive, color.glow
  - motion.pulse.duration, motion.pulse.intensity
- Mode switch toggles theme accent keys at runtime (no rebuild of business logic).

What to do next
- Drop exported PNGs into assets/reference/ and I’ll update this file with measured values (radii, stroke widths, glow blur, etc.).
- If you want, I can also extract frames via ffmpeg for you (if it’s installed).