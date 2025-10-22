# Time Tracker Gamification

This project is a Flutter application that gamifies time tracking with a cyberpunk aesthetic. It is designed to enhance productivity by utilizing game mechanics, visual rewards, and a progression system for motivation.

## Features
- **Timer Operations:** Start, pause, stop, and resume timing sessions with a visual timer display.
- **Mode System:** Switch between "Chill" and "Grind" modes, with corresponding XP multipliers.
- **Reward System:** Earn XP and Credits based on session duration, mode, and streak bonuses.
- **Achievement System:** Unlock achievements with criteria like time of day and daily streaks.
- **Local Storage:** Persistence of user statistics, sessions, and achievements.

## Technology Stack
- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** Provider pattern
- **Local Storage:** SharedPreferences

## Setup Instructions
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd time_tracker_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## File Structure
- `lib/core/`: Contains business logic for timer, rewards, and achievements.
- `lib/ui/`: Holds Flutter widgets and theme settings.
- `lib/models/`: Data model classes.
- `lib/services/`: Storage service for local data persistence.

## Testing
- **Unit Tests:** Located in the `test/` directory.

## Contributions
Feel free to submit issues or pull requests if you find bugs or have feature suggestions.

## License
This project is licensed under the MIT License.