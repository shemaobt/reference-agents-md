# Reference Agent Files for Web Apps

This repository provides **reference agent files** you can copy into your project so that AI coding agents (e.g. in IDEs like **Cursor**, **Windsurf**, **Antigravity**) read the right folder and follow consistent conventions.

These files were built using the [AGENTS.md](https://agents.md/) format as reference: a simple, open format for guiding coding agents, used by many open-source projects. The content and structure are copied from [mm_poc_v2](https://github.com/shemaobt/mm_poc_v2) and linked here for reuse.

## Why use agent files?

- **README.md** is for humans: quick starts, project description, contribution guidelines.
- **Agent files** (e.g. `AGENTS.md`, `BACKEND.md`, `FRONTEND.md`) give agents and LLMs the extra context they need: build steps, structure, code style, and conventions—without cluttering the README.

Putting the right file in the right directory helps IDE-based agents (Cursor, Antigravity, Windsurf, etc.) apply the correct guidelines when working in that part of the repo.

## Reference files in this repo

| File | Purpose | Where to put it in your repo |
|------|---------|------------------------------|
| **[GENERAL-WEB-APP.md](https://github.com/shemaobt/reference-agents-md/blob/main/GENERAL-WEB-APP.md)** | Project-wide guidelines: code style, architecture, build (Docker), secrets, commits, pointers to backend/frontend. Same structure as [mm_poc_v2/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/AGENTS.md). | **Repository root** (e.g. as `AGENTS.md` or `GENERAL-WEB-APP.md`). |
| **[BACKEND.md](https://github.com/shemaobt/reference-agents-md/blob/main/BACKEND.md)** | Backend-specific: FastAPI, Prisma, Pydantic, api/services/core/models, DB, typing, docstrings. Same structure as [mm_poc_v2/backend/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/backend/AGENTS.md). | **`backend/`** (as `AGENTS.md` or `BACKEND.md`). |
| **[FRONTEND.md](https://github.com/shemaobt/reference-agents-md/blob/main/FRONTEND.md)** | Frontend-specific: React, TypeScript, Tailwind, Zustand, component structure, styling, state. Same structure as [mm_poc_v2/frontend/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/frontend/AGENTS.md). | **`frontend/`** (as `AGENTS.md` or `FRONTEND.md`). |
| **[MOBILE.md](https://github.com/shemaobt/reference-agents-md/blob/main/MOBILE.md)** | **Mobile (Flutter):** Single file for Flutter repos — code style, architecture, stack (Riverpod, go_router, etc.), feature structure (data/domain/presentation), state, navigation, theme, data layer, widgets, secrets, build, commits. | **Repository root** for Flutter apps (as `AGENTS.md` or `MOBILE.md`). |

Each file in this repo **references the others by link** (e.g. GENERAL-WEB-APP.md links to BACKEND.md and FRONTEND.md; BACKEND.md and FRONTEND.md link back to GENERAL-WEB-APP.md). When you copy them into your project, update those links to your repo paths or keep relative paths (e.g. `../AGENTS.md`, `backend/AGENTS.md`).

## How to use

1. **Copy** the reference files you need from this repo (or from the links above).
2. **Rename** if your project uses different names (e.g. `BACKEND.md` → `AGENTS.md` in `backend/`).
3. **Place** them in the correct directories:
   - **Root** → `GENERAL-WEB-APP.md` or `AGENTS.md` so agents see global rules when working anywhere (web apps); for **Flutter apps** use a single **`MOBILE.md`** (or `AGENTS.md`) at root.
   - **backend/** → `BACKEND.md` or `AGENTS.md` so agents see backend rules when editing backend code.
   - **frontend/** → `FRONTEND.md` or `AGENTS.md` so agents see frontend rules when editing frontend code.
   - **Mobile-only repo** → One file at root: `MOBILE.md` or `AGENTS.md` (copy content from MOBILE.md).
4. **Edit** the content to match your stack and conventions. Update cross-references (links to the root or backend/frontend files) so they work in your repo (relative paths or your repo URLs).

Most agents and IDEs (Cursor, Windsurf, Antigravity, etc.) automatically discover and use the **nearest** agent file in the directory tree, so the file in `backend/` applies when working under `backend/`, the one in `frontend/` under `frontend/`, and the one at root applies when context is repo-wide. For **mobile-only** repos, a single **MOBILE.md** (or AGENTS.md) at root gives full coverage; no separate BACKEND or FRONTEND file is needed (backend is typically another repository).

## Source and format

- **Content/structure source:** [mm_poc_v2](https://github.com/shemaobt/mm_poc_v2) — [AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/AGENTS.md), [backend/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/backend/AGENTS.md), [frontend/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/frontend/AGENTS.md).
- **Format reference:** [https://agents.md/](https://agents.md/).

## License

Use and adapt these files freely in your projects.
