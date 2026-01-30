# Backend Agent Guidelines

This file defines **backend-specific** conventions for LLM agents working in this directory. It extends the repository-wide agent file (e.g. root `AGENTS.md` or `GENERAL-WEB-APP.md`): follow those first, then apply what is below.

**Reference:** [AGENTS.md](https://agents.md/)

---

## 1. Stack and Runtime

- **Framework**: FastAPI (or your project’s framework)
- **Server**: Uvicorn (dev) / Gunicorn (production) — or project equivalent
- **Package manager**: Use the project’s tool (e.g. **uv**, **pip**, **poetry**) for dependencies; do not mix package managers
- **Database**: Use the project’s ORM/client (e.g. Prisma, SQLAlchemy) from a single shared instance
- **Validation**: Pydantic (or project equivalent) for request/response bodies
- **Auth**: Use existing auth middleware and helpers; do not introduce a second auth mechanism

Use only the stack choices already in the project. Do not introduce a different ORM, web framework, or auth library.

---

## 2. Project Structure

- **api/** (or **routes/**): **Access layer only**. Parse request, validate (e.g. Pydantic), call **one service function**, return response or map exceptions to HTTP. No business logic, no direct DB calls here.
- **services/** (or **use_cases/**): Business logic and data access. Can be functional or class-based as the project already uses.
- **core/** (or **config/**, **infrastructure/**): Config, DB connection, auth helpers. Keep as functions or small modules.
- **models/** (or **schemas/**): Request/response and internal DTOs (e.g. Pydantic). Name by purpose: `*Create`, `*Response`, etc.

Do not add new top-level layers unless the repo already uses them; keep the existing layering.

---

## 3. API Conventions

- **Routers**: One router per domain. Register in the main app with a consistent prefix (e.g. `/api/...`).
- **Auth**: Use `Depends(get_current_user)` (or project equivalent) for protected routes.
- **Errors**: Raise HTTP exceptions in the API layer; do not return error payloads from services. Let the API layer translate service exceptions to HTTP status codes.
- **IDs**: Use the same ID types and naming as the rest of the API (e.g. string UUIDs).

---

## 4. Database and Client

- Use the **single shared** DB client from core (e.g. `get_db()`). Do not create additional client instances in routes or services.
- Use **async** APIs in request-handling code when the project is async; do not block the event loop with sync I/O in async handlers.
- **Migrations**: Every schema/table change must be persisted with a migration. Do not hand-edit the database schema outside the ORM/migration tool.

---

## 5. Code Style (Backend-Specific)

- **Strong typing**: Use type hints on all public functions (parameters and return type). Use Pydantic or TypedDict for known shapes; avoid bare `dict` for request/response when a type exists.
- **Docstrings**: Every public function in the service layer should have a short docstring (purpose, Args, Returns, Raises if relevant).
- **Configuration**: Use a central config (e.g. `core/config.py` and `get_settings()`). Do not use `os.getenv()` scattered across services; read from config.
- **Async**: Prefer async I/O in handlers and services when the stack is async. Use async DB and HTTP clients so the server does not block under load.

---

## 6. Summary Checklist

- API layer: thin — parse, validate, call service, return (or map exception).
- Services: contain business logic and data access; no HTTP or framework imports in domain logic.
- Single DB client; async where the project is async; migrations for every schema change.
- Strong typing and service docstrings; config from a central module.
