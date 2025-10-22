# Structured UI Prompt — “Memento Re Neon Timer”

Goal
- Recreate a cyberpunk neon circular timer UI (Chill pink / Grind blue) with reskinnable tokens.
- Deliver UI specs suitable for implementation and future theme packs.

Use this prompt with designers or generative tools and fill placeholders [like this].

1) Art direction
- Mood: Cyberpunk, neon-lit, dark techno ambience
- Palette: background=#0A0A0A, pink=#FF006E, blue=#00D9FF, accents=[#00FF88, #FF9500, #FF0040]
- Lighting: strong outer glow around rings; subtle ambient bloom; soft inner shadows
- Texture: optional scanlines/grain at low opacity (<=4%)

2) Layout & canvas
- Canvas size: [1080x1920 or 1440x900]
- Safe margins: [24] px all sides
- Main structure: centered circular timer; controls below; stats at bottom

3) Circular timer
- Concentric rings: [2] rings (outer active, inner secondary)
- Outer ring: radius=[180], stroke=[16], glow=[blue]
- Inner ring: radius=[140], stroke=[12], glow=[pink]
- Tick marks: every [5°], subtle, low-contrast
- Numerals: monospace, [72–96] px, high contrast

4) Components
- Primary button: Start/Stop, pill-shaped, neon border, fill on hover/press
- Secondary button: Pause/Resume, outline style
- Mode switch: Chill vs Grind toggle with clear color shift (pink↔blue)
- Stats: daily total time, streak indicator, XP/Credits readout

5) States
- Idle: 00:00:00, ambient glow
- Running: progress sweep; pulsing glow
- Paused: dimmed glow; Resume/Stop visible
- Completed: reward popup (XP, Credits, streak bonus)

6) Motion
- Start: 250–350ms easeOut glow ramp
- Pause/Resume: 180–240ms easeInOut
- Reward popup: scale 0.9→1.0, slight overshoot, particles 300–500ms fade

7) Accessibility
- Contrast ratio: >= 4.5:1 for text
- Scalable fonts; avoid excessive flicker

8) Tokenization mapping (for theme packs)
- colors.background, colors.primary, colors.secondary, colors.accent
- rings[0|1].radius, rings[0|1].strokeWidth, rings[0|1].glow.color, rings[*].glow.blur
- motion.pulse.duration, motion.pulse.intensity
- typography.heading, typography.numerals

9) Export
- Provide PNGs for: Idle, Running (mid-progress), Paused, Completed (reward)
- Provide a color chip sheet and a token sheet (JSON or table)
