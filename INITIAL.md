FEATURE:

Build the core Time Tracker with the following requirements:

Neon Circular Timer UI

Cyberpunk theme (neon pink + light blue on dark background).

Circular glowing rings represent active timers.

Timer can start, pause, stop.

Session Tracking

Users can start/stop sessions.

Store duration in local storage (DB later).

Daily summary: total hours tracked.

Mode Switch: Chill vs. Grind

User selects mode before starting timer.

Chill Mode: normal XP/Credit gain.

Grind Mode: double XP but consumes more “energy” (placeholder mechanic).

Mode visibly changes UI glow (e.g., Chill = pink glow, Grind = blue glow).

Reward System

Each finished session gives:

XP (experience points).

Credits (in-game currency).

Rewards scale with time spent.

Daily streak bonus multiplier.

Basic Achievements (just a few to start)

Example:

First Hour Logged → 100 XP bonus.

Daily Streak 3 Days → 200 Credits.

EXAMPLES:

examples/ui_cyberpunk_timer.dart → pattern for neon circular UI.

examples/rewards_system.py → reward calculation logic.

examples/state_switch.js → mode switching pattern.

examples/achievements.json → how achievements are structured.

(these don’t need to be runnable apps — just code snippets showing structure & logic patterns)

DOCUMENTATION:

Flutter Docs: CustomPainter (for circular timer UI)

State Management in Flutter (Provider)

Basic reward system design patterns from game dev blogs (placeholder).

OTHER CONSIDERATIONS:

Keep all logic modular (timer logic separate from rewards).

Use clear naming (TimerManager, RewardEngine, AchievementTracker).

Write unit tests for:

Session start/stop/save.

Reward calculation.

Mode switch multiplier.
