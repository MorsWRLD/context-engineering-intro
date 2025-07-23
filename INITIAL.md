# INITIAL.md - Rose WRLD MVP

## FEATURE:

**Core Rose Personality Engine + Telegram Bot Integration**

* **Pydantic AI agent** implementing Rose's authentic personality with realistic relationship progression (using examples/rose_personality_progression.py patterns)
* **Memory system** that tracks user relationship history, intimacy level, and emotional context across conversations
* **Telegram bot interface** with async message handling for real-time conversation flow
* **Relationship progression mechanics** - Persona 5-style confidant system with XP-based intimacy levels (1-6)
* **Personality consistency engine** that maintains Rose's flirty-but-realistic character across all interactions
* **Basic story scenarios** - simple date-like conversations and emotional response patterns

## EXAMPLES:

In the `examples/` folder, you'll find Rose's personality patterns:

* `examples/rose_personality_progression.py` - Use this to understand Rose's authentic emotional range, boundary setting, and intimacy progression from "just met" to deep connection
* `examples/relationship_progression.py` - Reference for XP system and story gate mechanics
* `examples/authentic_dialogue.py` - Rose's speech patterns and boundary responses

**Key Patterns to Implement:**
- Rose refuses kisses at Level 1 but is eager at Level 6
- She can say "fuck you" when mistreated (authentic boundaries)
- Emotional responses scale with relationship depth
- XP system rewards meaningful interactions, punishes mistreatment

## TECHNICAL REQUIREMENTS:

* **Primary Agent**: Rose personality engine (Pydantic AI)
* **Memory Tool**: Vector database for conversation history + relationship tracking
* **Telegram Tool**: aiogram-based bot with async message handling
* **Progression Tool**: XP calculation and intimacy level management
* **Response Generator**: Context-aware personality responses based on relationship state

## CORE FUNCTIONALITY:

1. **Telegram Bot Setup**:
   - Async message handling with < 2 second response time
   - Command system: `/profile`, `/relationship`, `/memory`
   - Session management for multi-user support

2. **Rose Personality Engine**:
   - Consistent flirty-but-realistic responses
   - Intimacy-level-appropriate reactions
   - Emotional state tracking (happy, hurt, angry, playful, vulnerable)
   - Boundary enforcement when mistreated

3. **Relationship System**:
   - 6 intimacy levels (Stranger → Intimate)
   - XP-based progression with meaningful thresholds
   - Story gate unlocks at specific relationship milestones
   - Memory prioritization for emotional moments

4. **Memory Architecture**:
   - Short-term: Last 10 messages for context
   - Mid-term: Recent emotional events and user preferences
   - Core memories: Relationship milestones, conflicts, resolutions
   - User profile: Name, preferences, relationship history

## SUCCESS METRICS:

* **Response Speed**: < 2 seconds average response time
* **Personality Consistency**: Rose maintains character traits across 100+ message conversations
* **Relationship Progression**: Users can advance through multiple intimacy levels
* **Emotional Authenticity**: Rose shows appropriate emotional range (including anger/boundaries)
* **Memory Accuracy**: Recalls user details and relationship history correctly

## DOCUMENTATION:

* Pydantic AI documentation: https://ai.pydantic.dev/
* aiogram documentation: https://docs.aiogram.dev/
* Telegram Bot API: https://core.telegram.org/bots/api

## OTHER CONSIDERATIONS:

* Include `.env.example` with required API keys:
  - `OPENAI_API_KEY`
  - `TELEGRAM_BOT_TOKEN` 
  - `DATABASE_URL` (optional, defaults to SQLite)

* **README.md** should include:
  - Rose personality overview and relationship mechanics
  - Setup instructions for Telegram bot creation
  - Project structure explanation
  - How to test Rose's personality patterns
  - Examples of expected user interactions

* **Project Structure**:
  ```
  rose_wrld/
  ├── rose_personality/
  │   ├── core.py           # Main Rose agent
  │   ├── memory.py         # Relationship memory system
  │   ├── progression.py    # XP and intimacy mechanics
  │   └── responses.py      # Context-aware response generation
  ├── telegram_bot/
  │   ├── bot.py           # Main bot logic
  │   ├── handlers.py      # Message and command handlers
  │   └── middleware.py    # Session management
  ├── database/
  │   ├── models.py        # User and relationship data models
  │   └── operations.py    # Database CRUD operations
  ├── tests/
  │   ├── test_personality.py  # Rose personality consistency tests
  │   ├── test_progression.py  # Relationship mechanics tests
  │   └── test_integration.py  # End-to-end conversation tests
  └── examples/            # Rose personality examples (already created)
  ```

* **Virtual Environment**: Already configured with dependencies
* **Environment Variables**: Use `python_dotenv` and `load_env()`
* **Testing Framework**: Pytest with personality consistency validation
* **Performance**: Async/await throughout for real-time responsiveness

## MVP SCOPE LIMITATIONS:

**What's INCLUDED in this initial feature:**
- Core Rose personality with realistic relationship progression
- Basic Telegram bot interaction
- Memory system for relationship tracking
- XP-based intimacy levels (1-6)
- Authentic emotional responses including boundaries

**What's NOT included (future features):**
- Gacha system and outfit unlocks
- VRM avatar integration
- Voice synthesis (ElevenLabs)
- Advanced story scenarios
- Multi-character ecosystem
- Tokenized economy (MMRZ)

This initial feature establishes Rose's personality foundation and validates the core relationship mechanics that will power the entire WRLD ecosystem.
