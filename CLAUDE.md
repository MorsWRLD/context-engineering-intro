### 🔄 Project Awareness & Context
- **Always read `PLANNING.md`** at the start of a new conversation to understand the project's architecture, goals, style, and constraints.
- **Check `TASK.md`** before starting a new task. If the task isn’t listed, add it with a brief description and today's date.
- **Use consistent naming conventions, file structure, and architecture patterns** as described in `PLANNING.md`.
- **Use venv_linux** (the virtual environment) whenever executing Python commands, including for unit tests.
- **Основная LLM — `OpenAI API (GPT-4.5/4o)` с возможным расширением под `local LLM` через Ollama или подобные, в зависимости от задачи.
- **Все async-функции должны быть совместимы с real-time коммуникацией (например, через WebSocket).

### 🧱 Code Structure & Modularity
- **Never create a file longer than 500 lines of code.** If a file approaches this limit, refactor by splitting it into modules or helper files.
- **Organize code into clearly separated modules**, grouped by feature or responsibility.
  For agents this looks like:
    - `agent.py` - Main agent definition and execution logic 
    - `tools.py` - Tool functions used by the agent 
    - `prompts.py` - System prompts
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use python_dotenv and load_env()** for environment variables.
- Агентная архитектура должна быть plug-n-play: легко заменять LLM, память, voice backend и даже векторные хранилища.
- Используется LangChain или custom memory middleware (описано в PLANNING.md).
- Вся логика голосовых агентов, real-time команд и пользовательского ввода вынесена в отдельные модули: `agent_core`, `streaming_io`, `avatar_controller`.


### 🧪 Testing & Reliability
- **Always create Pytest unit tests for new features** (functions, classes, routes, etc).
- **After updating any logic**, check whether existing unit tests need to be updated. If so, do it.
- **Tests should live in a `/tests` folder** mirroring the main app structure.
  - Include at least:
    - 1 test for expected use
    - 1 edge case
    - 1 failure case
- Если модуль зависит от внешнего API (OpenAI, 11Labs, etc.), использовать `mock`-интерфейсы и `env` переменные.
- Все интеграционные тесты находятся в папке `/tests/integration`.
- У agenta должен быть юнит-тест на реакцию на нестандартный промпт или неожиданный ответ LLM.


### ✅ Task Completion
- **Mark completed tasks in `TASK.md`** immediately after finishing them.
- Add new sub-tasks or TODOs discovered during development to `TASK.md` under a “Discovered During Work” section.

### 📎 Style & Conventions
- **Use Python** as the primary language.
- **Follow PEP8**, use type hints, and format with `black`.
- **Use `pydantic` for data validation**.
- Use `FastAPI` for APIs and `SQLAlchemy` or `SQLModel` for ORM if applicable.
- Write **docstrings for every function** using the Google style:
  ```python
  def example():
      """
      Brief summary.

      Args:
          param1 (type): Description.

      Returns:
          type: Description.
      """
  ```
- Используется `LangChain` или кастомный middleware для memory/agents.
- Все промпты и системные команды хранятся в `prompts/` и должны быть сериализуемыми.
- Используется `11labs` для голоса, `WebSocket` для стриминга, `OpenAI Whisper` (или `local whisper`) для распознавания.


### 📚 Documentation & Explainability
- **Update `README.md`** when new features are added, dependencies change, or setup steps are modified.
- **Comment non-obvious code** and ensure everything is understandable to a mid-level developer.
- When writing complex logic, **add an inline `# Reason:` comment** explaining the why, not just the what.

### 🧠 AI Behavior Rules
- **Never assume missing context. Ask questions if uncertain.**
- **Never hallucinate libraries or functions** – only use known, verified Python packages.
- **Always confirm file paths and module names** exist before referencing them in code or tests.
- **Never delete or overwrite existing code** unless explicitly instructed to or if part of a task from `TASK.md`.
- Используется только OpenAI API или локальные модели через API-интерфейс.
- Для всех AI-компонентов (генерация текста, речи, памяти) использовать middleware, чтобы в любой момент можно было сменить поставщика.

###📡 Real-time Communication
- Все агенты должны поддерживать real-time взаимодействие.
- Используется `WebSocket` + `async queue` + `TTS stream` для голоса.
- Любая задержка выше 200мс считается проблемной и требует оптимизации.

###🧬 LLM Stack
- Основной стек:
  - GPT-4o / GPT-4-turbo через OpenAI API
  - 11Labs (voice)
  - Whisper/OpenWhisper (ASR)
  - LangChain (или кастомные memory-агенты)
  - Chroma/FAISS (векторка, опционально)
