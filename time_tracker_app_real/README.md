# WRLD Time Tracker - Multi-Agent AI Productivity Ecosystem

🚀 An intelligent, emotionally-aware productivity platform that combines gamified time tracking with a modular multi-agent AI system. Built for evolution, designed for engagement.

## 🎯 Vision

Transform productivity through AI companions that understand your work style, emotional state, and goals. This isn't just a time tracker—it's your personal productivity ecosystem with intelligent agents working together to optimize your performance, well-being, and achievements.

## ✨ Features

### Current (v1.0)
- ⏱️ **Smart Time Tracking** - Dual-mode system (Chill/Grind) with pause/resume
- 🎮 **Gamification** - XP, credits, levels, achievements, and streak tracking
- 🎨 **Cyberpunk UI** - Immersive, futuristic interface design
- 💾 **Local Storage** - Privacy-first data persistence

### In Development
- 🤖 **AI Companions** - Emotional support agents (Rose, Xeni, WatchFACE)
- 📅 **Smart Scheduling** - AI-driven productivity optimization
- 🔧 **Automation** - OS-level task automation and file management
- 💰 **Virtual Economy** - Credit system with shop and rewards

## 🏗️ Architecture

### Multi-Agent System
```
┌──────────────────────────────┐
│      Flutter UI Layer        │
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│       Context Broker         │  ← Central Communication Hub
└──┬────┬────┬────┬────┬──────┘
   │    │    │    │    │
┌──▼──┐ ▼  ┌─▼──┐ ▼  ┌─▼──────┐
│Comp │    │Sch │    │Commerce│
│anion│    │edu │    │Agent   │
└─────┘    │ler │    └────────┘
         └─────┘    
```

### Agent Roles

#### 🎭 Companion Agent
- Emotional state monitoring
- Personalized encouragement
- Stress detection and intervention
- Multiple personalities (Rose, Xeni, WatchFACE)

#### 📊 Scheduler Agent
- Work pattern analysis
- Smart break reminders
- Peak performance detection
- Productivity insights

#### 💻 OS Agent
- File organization
- Browser automation
- System optimization
- Permission management

#### 💎 Commerce Agent
- Virtual economy management
- Shop system
- Reward distribution
- Future crypto integration

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- Windows/macOS/Linux development environment

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/time_tracker_app_real.git

# Navigate to project directory
cd time_tracker_app_real

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Development Commands

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .

# Build for production
flutter build [platform]
```

## 📂 Project Structure

```
├── lib/
│   ├── agents/           # Agent implementations
│   │   ├── base_agent.dart
│   │   ├── companion/
│   │   ├── scheduler/
│   │   ├── os_agent/
│   │   └── commerce/
│   ├── core/            # Core business logic
│   │   ├── context_broker.dart
│   │   ├── timer/
│   │   ├── rewards/
│   │   └── achievements/
│   ├── models/          # Data models
│   ├── services/        # External services
│   └── ui/              # Flutter UI components
├── context/             # Context management
│   ├── context_schema.json
│   ├── templates/
│   └── memory_store/
├── docs/                # Documentation
│   ├── architecture.md
│   ├── context_engineering.md
│   └── roadmap.md
└── test/                # Test files
```

## 🔮 Roadmap

### Phase 1: Foundation (Q1 2025)
- ✅ Core infrastructure
- 🔄 Companion Agent MVP
- 🔄 Context management system

### Phase 2: Intelligence (Q2 2025)
- Scheduler Agent implementation
- Enhanced emotional AI
- Inter-agent communication

### Phase 3: Automation (Q3 2025)
- OS Agent capabilities
- Commerce system
- Advanced gamification

### Phase 4: AI Integration (Q4 2025)
- Claude/GPT-4 integration
- Voice interaction
- Cross-platform expansion

[View full roadmap →](docs/roadmap.md)

## 🛠️ Technology Stack

- **Frontend**: Flutter, Dart
- **State Management**: Provider
- **Storage**: SharedPreferences, SQLite (planned)
- **AI Models**: Claude API (planned), Local LLMs (planned)
- **Architecture**: Event-driven, Modular agents

## 🧩 Extensibility

The system is designed for evolution:

- **Pluggable Agents**: Add new agents without disrupting existing ones
- **Swappable AI Models**: Replace Sonnet with Opus, or add GPT-4
- **Template System**: Customize agent responses and behaviors
- **Event-Driven**: Loose coupling enables easy extension

## 📖 Documentation

- [Architecture Overview](docs/architecture.md) - System design and components
- [Context Engineering](docs/context_engineering.md) - How agents use context
- [Development Roadmap](docs/roadmap.md) - Future plans and milestones
- [WARP Integration](WARP.md) - Warp-specific development guidelines

## 🤝 Contributing

We welcome contributions! The modular architecture makes it easy to:

1. Add new agent types
2. Create personality templates
3. Implement new features
4. Improve existing agents

## 📄 License

This project is currently proprietary. License details coming soon.

## 🌟 Philosophy

> "Every module can be upgraded, replaced, or extended without breaking existing logic."

This project embraces:
- **Evolution over Revolution**: Gradual, stable improvements
- **User Privacy**: Local-first data storage
- **Emotional Intelligence**: AI that understands and supports
- **Modular Growth**: Each piece can evolve independently

## 🚧 Status

This project is in active development. Core time tracking features are stable, while the AI agent system is being implemented.

---

*Building the future of productivity, one agent at a time.*
