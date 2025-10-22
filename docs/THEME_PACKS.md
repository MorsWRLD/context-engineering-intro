# Theme Packs & Skinning — Spec

Purpose
- Enable reskinnable UI via JSON-defined tokens + optional asset packs.
- Allow selling/awarding new skins (monetization/progression) without changing core logic.

Concept
- A theme pack is a JSON file plus optional asset folder that defines colors, typography, ring geometry, glow, and artwork.
- Packs live in assets/themes/<theme_id>/.

File layout
- assets/
  - themes/
    - mementore_neon/
      - theme.json
      - assets/
        - ring_overlay.png (optional)
        - particles.png (optional)
    - synthwave_sunset/
      - theme.json
      - assets/ ...

JSON schema (v1 — minimal)
{
  "schemaVersion": 1,
  "id": "mementore_neon",
  "name": "Memento Re Neon",
  "version": "1.0.0",
  "author": "",
  "colors": {
    "background": "#0A0A0A",
    "primary": "#FF006E",   // chill
    "secondary": "#00D9FF", // grind
    "accent": "#00FF88",
    "textPrimary": "#FFFFFF",
    "textSecondary": "#A0A0A0"
  },
  "typography": {
    "heading": "Inter",
    "numerals": "Roboto Mono",
    "scale": 1.0
  },
  "rings": [
    { "radius": 180, "strokeWidth": 16, "glowColorKey": "secondary", "glowBlur": 36 },
    { "radius": 140, "strokeWidth": 12, "glowColorKey": "primary",   "glowBlur": 28 }
  ],
  "motion": {
    "pulse": { "durationMs": 1200, "intensity": 0.6 },
    "start": { "durationMs": 300 },
    "pause": { "durationMs": 200 },
    "reward": { "durationMs": 160 }
  },
  "assets": {
    "ringOverlay": "assets/ring_overlay.png",
    "particles": "assets/particles.png"
  }
}

Loading & application (framework-agnostic)
- Load JSON → validate against schemaVersion.
- Map keys to UI:
  - Colors → theme colors; text color; mode accents.
  - Typography → fonts for headings and numerals.
  - Rings → CustomPainter parameters (radius, strokeWidth, glow).
  - Motion → animation durations, pulse intensity.
  - Assets → optional overlays/particles.
- Allow runtime switch between installed themes; persist user choice.

Monetization hooks
- Treat premium themes as locked packs (metadata: { "entitlement": "theme.synthwave_sunset" }).
- Gate loading unless entitlement is present (local flag for now; store later).

Validation
- If any key missing, fallback to defaults.
- Keep strict ranges for radii, stroke widths, blur values.

Next steps
- See examples/theme_pack.example.json for a concrete pack.
- Once PNGs from Canva are available, we can produce an accurate starter pack from the Memento Re look.