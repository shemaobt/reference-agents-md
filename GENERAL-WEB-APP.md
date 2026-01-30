# General Agent Guidelines (Web App)

This document defines **project-wide** conventions for LLM agents working in this repository. Follow these guidelines first; then apply the context-specific file when working in `backend/` or `frontend/` (see end of this file).

**Reference:** These guidelines follow the [AGENTS.md](https://agents.md/) format.

---

## 1. Code Style and Paradigm

### Prefer a functional approach

- Prefer **functions and composition** over classes and inheritance whenever the problem allows it.
- Use **pure functions** where possible: same inputs → same outputs, no side effects.
- Encapsulate state and side effects in small, explicit layers (e.g. services, stores) rather than spreading them across class hierarchies.
- Choose classes only when you need clear identity, lifecycle, or multiple related operations that truly benefit from shared instance state.

### Self-documenting code (minimal comments)

- Prefer **clear names** for functions, variables, and modules so that intent is obvious.
- Structure code (small functions, single responsibility) so that flow is easy to follow without comments.
- Use comments only for **why** something non-obvious is done (workarounds, business rules), not for *what* the code does.

---

## 2. Architecture and Design

### Clean architecture

- Keep **domain logic** independent of frameworks, UI, and infrastructure.
- Separate **use cases / application logic** from **delivery mechanisms** (HTTP, UI) and **data access**.
- Depend **inward**: inner layers must not depend on outer layers. Outer layers depend on inner layers.

### Reuse existing code; avoid overengineering

- Prefer **current methods or abstractions** instead of creating new ones.
- Create new abstractions **only when necessary**. Avoid speculative generality or extra layers "for the future."

---

## 3. Build and Runtime Commands

- Run **build, dev server, tests, migrations** in the correct environment (e.g. inside Docker containers if the project uses Docker).
- Use the **backend** container/service for backend commands (Python, DB migrations, etc.) and the **frontend** container/service for frontend commands (npm, vite, etc.).
- Do not suggest or run application commands on the host unless the project is set up for host-based development.

---

## 4. Secrets and Environment Variables

- **Never hardcode secrets, API keys, or credentials** in source code or committed files.
- Use **`.env` files** for local development (gitignored). Use **CI/CD secrets** for production.
- Provide **`.env.example`** with required variable names (no real values).
- **Fail fast** if required secrets are missing at startup.

---

## 5. Version Control and Commits

### Do not commit unless asked

- Never commit, push, or amend unless the user **explicitly requests** it.

### When the user requests a commit

- Run `git status` and group changes by **scope** (e.g. backend auth, frontend UI).
- Create **small, focused commits**, each covering one logical change.
- Use **Conventional Commits**: `type(scope): short description` (e.g. `feat(auth): add login`, `fix(api): handle missing id`).

---

## 6. Context-Specific Guidelines

When working in a specific part of the repo, follow the corresponding file in addition to this document:

- **Backend** (`backend/`): See **BACKEND.md** (or `backend/AGENTS.md`) for stack, structure (API / services / core / models), DB, and backend conventions.
- **Frontend** (`frontend/`): See **FRONTEND.md** (or `frontend/AGENTS.md`) for stack (React, TypeScript, styling, state), component structure, and frontend conventions.

Place those files in the correct directories so IDE-based agents (Cursor, Windsurf, Antigravity, etc.) automatically use the nearest file when editing that part of the codebase.
