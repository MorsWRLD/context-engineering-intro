🌹 Project Awareness & Context

Always read PLANNING.md at the start of a new conversation to understand Rose's personality architecture, relationship mechanics, and technical constraints.
Check TASK.md before starting a new task. If the task isn't listed, add it with a brief description and today's date.
Use consistent Rose personality patterns - flirty, dramatic, artistic, emotionally intelligent as described in PLANNING.md.
Use venv_linux (the virtual environment) whenever executing Python commands, including for unit tests.
**Primary LLM — OpenAI API (GPT-4o) with context optimization for Rose's personality consistency and fast response times.
All async functions must support real-time communication for Telegram bot responsiveness and future VRM avatar integration.

🧱 Code Structure & Modularity - Rose Architecture

Never create a file longer than 300 lines of code (stricter for Rose due to response speed requirements).
Organize Rose's components into clearly separated modules:

rose_personality/

core.py - Rose's base personality traits and response patterns
memory.py - Relationship memory and progression tracking
emotions.py - Emotional state management and triggers
relationships.py - Persona 5-style confidant system


telegram_bot/

bot.py - Main Telegram bot logic
handlers.py - Command and message handlers
middleware.py - Session management and rate limiting


gacha_system/

mechanics.py - Pull system, pity mechanics, C1-C6 progression
rewards.py - Outfit unlocks, relationship bonuses


story_engine/

scenarios.py - Date scenarios, conflict arcs, major story beats
branching.py - Choice consequences and relationship impact


avatar_system/ (future)

vrm_controller.py - VRM avatar management
expressions.py - Emotion-based avatar responses




Use clear, consistent imports (prefer relative imports within packages).
Use python_dotenv and load_env() for API keys (OpenAI, ElevenLabs, Telegram).
Architecture must be plug-n-play: easy to swap LLM providers, memory backends, voice systems, and avatar engines.
All Rose personality logic, real-time responses, and user interaction separated into: rose_core, streaming_io, personality_engine.

🧪 Testing & Reliability - Rose Specific

Always create Pytest unit tests for Rose's personality consistency:

Personality trait stability across conversations
Relationship progression accuracy
Memory recall functionality
Gacha mechanics fairness


After updating Rose's personality logic, verify existing personality tests still pass.
Tests should live in /tests folder mirroring Rose's structure:

Include at least:

1 test for expected Rose personality response
1 edge case (user being rude/inappropriate)
1 failure case (API timeout handling)




Mock external APIs (OpenAI, ElevenLabs, Telegram) using environment variables.
Integration tests in /tests/integration for:

End-to-end conversation flows
Relationship progression scenarios
Gacha pull sequences


Rose must have unit tests for handling unexpected user inputs and maintaining personality consistency.

✅ Task Completion - Rose Development

Mark completed Rose features in TASK.md immediately after finishing them.
Track Rose's personality development - log major personality improvements or relationship mechanic additions.
Add new Rose scenarios or conversation patterns discovered during development to TASK.md under "Rose Story Content".

📎 Style & Conventions - Rose Codebase

Use Python as the primary language for Rose's backend.
Follow PEP8, use type hints, and format with black.
Use pydantic for Rose's personality data validation (emotional states, relationship levels, user preferences).
Use aiogram for Telegram bot and SQLAlchemy/SQLModel for user relationship data.
Write docstrings for every Rose function using Google style:
pythondef generate_rose_response(user_message: str, relationship_level: int) -> str:
    """
    Generate Rose's personality-consistent response.

    Args:
        user_message (str): User's input message
        relationship_level (int): Current confidant level (1-10)

    Returns:
        str: Rose's contextual response matching her personality
    """

Use LangChain or custom middleware for Rose's memory and personality consistency.
All Rose prompts and personality traits stored in prompts/rose/ and must be serializable.
Use ElevenLabs for Rose's voice, WebSocket for real-time streaming, OpenAI Whisper for speech recognition (future).

📚 Documentation & Explainability - Rose Context

Update README.md when Rose gains new personality features, relationship mechanics, or gacha elements.
Comment Rose's personality logic thoroughly - other developers need to understand her emotional patterns.
For Rose's complex relationship mechanics, add # Rose Behavior: comments explaining why certain personality choices were made.
Document Rose's conversation patterns and relationship progression in /docs/rose_personality.md.

🧠 AI Behavior Rules - Rose Development

Never break Rose's personality consistency - she must remain flirty, dramatic, artistic across all interactions.
Never assume Rose's emotional state - always check current relationship level and user history.
Never hallucinate Rose personality traits - only use established characteristics from PLANNING.md.
Always confirm Rose's response patterns align with current relationship stage before implementing.
Never delete Rose's core personality code unless explicitly refactoring personality system.
Use only OpenAI API or local models through standardized interface for Rose's responses.
All Rose AI components (personality, memory, voice) use middleware for easy provider switching.

📡 Real-time Communication - Rose Responsiveness

Rose must support real-time interaction for natural conversation flow.
Use WebSocket + async queue + TTS stream for Rose's voice responses (future).
Any Rose response delay above 2 seconds is problematic and requires optimization.
Rose's personality should stream responses to maintain conversation immersion.
Implement response caching for common Rose personality patterns.

🧬 LLM Stack - Rose Technical

Core Rose Stack:

GPT-4o through OpenAI API (optimized prompts for Rose personality)
ElevenLabs (Rose's emotional voice)
Whisper/OpenWhisper (future speech input)
Custom personality middleware (not LangChain initially for speed)
ChromaDB (Rose's relationship memory)
SQLite (user progression data)
aiogram (Telegram bot framework)



🎮 Rose-Specific Development Rules

Rose's personality must be consistent across all conversation contexts
Relationship progression follows Persona 5 confidant model - meaningful story gates
Gacha mechanics must feel fair - 60 pull average, 69 hard pity for C6 unlocks
All Rose responses consider:

Current relationship level
Recent conversation history
User's emotional state
Time since last interaction


Rose's memory system prioritizes:

Emotional moments
Relationship milestones
User preferences and personality
Conflict resolution history



🚀 MVP Success Metrics

Response time: < 2 seconds for Rose's replies
Personality consistency: Rose maintains character across 100+ message conversations
User retention: Daily active users return rate > 60%
Monetization: Gacha system generates sustainable revenue for WRLD expansion
Relationship depth: Users progress through multiple confidant levels
Technical stability: 99% uptime for Rose's Telegram bot

📋 Current MVP Priorities

Rose Personality Engine - Core flirty, dramatic, artistic responses
Telegram Bot Integration - Seamless conversation flow
Basic Memory System - Remember user preferences and history
Relationship Progression - Simple confidant level advancement
Gacha Prototype - Basic pull mechanics and outfit unlocks
Performance Optimization - Sub-2-second response times


Remember: You're building the foundation for the entire WRLD ecosystem. Rose's success validates the emotional AI companion model and funds the multi-character expansion. Focus on creating genuine emotional connection through consistent personality and meaningful progression mechanics.
