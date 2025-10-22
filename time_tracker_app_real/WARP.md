# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

Flutter time tracking application with gamification features including XP/credits rewards, achievements system, and session management. Uses Provider for state management and SharedPreferences for local data persistence.

## Common Commands

### Development
```bash
# Run the app
flutter run

# Run on specific platform
flutter run -d windows
flutter run -d chrome

# Hot reload is available during development
# Press 'r' to hot reload, 'R' to hot restart
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code for issues
flutter analyze

# Format code
dart format .
```

### Build
```bash
# Build for Windows
flutter build windows

# Build for web
flutter build web

# Build APK for Android
flutter build apk
```

## Architecture

### Core State Management
The app uses Provider pattern with three main managers:
- **TimerManager** (`lib/core/timer/`) - Handles timer states (idle/running/paused/stopped), session tracking with pause events
- **RewardEngine** (`lib/core/rewards/`) - Calculates XP/credits based on session duration, mode, and streak multipliers
- **AchievementTracker** (`lib/core/achievements/`) - Tracks and unlocks achievements based on various criteria (duration, streaks, time of day, modes)

### Data Models
- **Session** - Contains timing data, mode (chill/grind), pause events, and earned rewards
- **UserStats** - Tracks total XP, credits, level, streaks, and aggregate statistics
- **Achievement** - Defines achievement criteria and unlock status

### Key Features
- **Timer Modes**: "Chill" and "Grind" modes with different reward multipliers
- **Pause System**: Tracks pause events within sessions for accurate active time calculation
- **Streak System**: Daily streak tracking affects reward multipliers
- **Achievement Types**: Duration-based, streak-based, time-of-day, and mode-specific achievements

### UI Structure
- **Screens**: Timer (main), Statistics, Achievements
- **Theme**: Cyberpunk-themed UI with custom colors and styling
- **Widgets**: Circular timer display, mode selector

### Data Persistence
Uses `StorageService` with SharedPreferences to persist:
- User statistics and progress
- Session history
- Achievement unlock states

## Key Development Notes

- Timer updates every 100ms for smooth UI updates
- Session active duration excludes pause time
- AchievementTracker should listen to TimerManager state updates and display unlock popups in real-time
- All providers are set up in main.dart with MultiProvider
- Style goal: Highly polished UI with cyberpunk aesthetics, smooth animations, and subtle sound design feedback.
- Entry point: lib/main.dart
- Providers initialized via MultiProvider.



