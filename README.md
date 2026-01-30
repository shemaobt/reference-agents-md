# Reference Agent Files for Web Apps

This repository provides **reference agent files** you can copy into your project so that AI coding agents (e.g. in IDEs like **Cursor**, **Windsurf**, **Antigravity**) read the right folder and follow consistent conventions.

These files were built using the [AGENTS.md](https://agents.md/) format as reference: a simple, open format for guiding coding agents, used by many open-source projects.

## Why use agent files?

- **README.md** is for humans: quick starts, project description, contribution guidelines.
- **Agent files** (e.g. `AGENTS.md`, `BACKEND.md`, `FRONTEND.md`) give agents and LLMs the extra context they need: build steps, structure, code style, and conventions—without cluttering the README.

Putting the right file in the right directory helps IDE-based agents (Cursor, Antigravity, Windsurf, etc.) apply the correct guidelines when working in that part of the repo.

## What’s in this repo

| File | Purpose | Where to put it in your repo |
|------|---------|------------------------------|
| **GENERAL-WEB-APP.md** | Project-wide guidelines: code style, architecture, secrets, commits, pointers to backend/frontend. | **Repository root** (e.g. next to your main README). |
| **BACKEND.md** | Backend-specific: API layer, services, DB, typing, docstrings, stack. | **`backend/`** (or your backend package root). |
| **FRONTEND.md** | Frontend-specific: React/TS, components, styling, state, structure. | **`frontend/`** (or your client app root). |

## How to use

1. **Copy** the reference files you need into your project.
2. **Rename** if your project uses different names (e.g. `BACKEND.md` → `AGENTS.md` in `backend/`, or keep `BACKEND.md`).
3. **Place** them in the correct directories:
   - **Root** → `GENERAL-WEB-APP.md` (or `AGENTS.md`) so agents see global rules when working anywhere.
   - **backend/** → `BACKEND.md` (or `AGENTS.md`) so agents see backend rules when editing backend code.
   - **frontend/** → `FRONTEND.md` (or `AGENTS.md`) so agents see frontend rules when editing frontend code.
4. **Edit** the content to match your stack, structure, and conventions (replace placeholders, add project-specific commands and paths).

Most agents and IDEs (Cursor, Windsurf, Antigravity, etc.) automatically discover and use the **nearest** agent file in the directory tree, so the file in `backend/` applies when working under `backend/`, and the one at root applies when context is repo-wide.

## Reference

- **AGENTS.md format:** [https://agents.md/](https://agents.md/)
- **Nested files:** For large monorepos, put an agent file in each package or app; the closest file in the tree takes precedence.

## License

Use and adapt these files freely in your projects.
