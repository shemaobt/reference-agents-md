# Frontend Agent Guidelines

This file defines **frontend-specific** conventions for LLM agents working in this directory. It extends the repository-wide agent file (e.g. root `AGENTS.md` or `GENERAL-WEB-APP.md`): follow those first, then apply what is below.

**Reference:** [AGENTS.md](https://agents.md/)

---

## 1. Stack and Build

- **Framework**: React (or your project’s framework)
- **Language**: TypeScript
- **Build / dev**: Vite (or project equivalent)
- **Styling**: Use the project’s styling approach only (e.g. **Tailwind CSS** only; no extra CSS-in-JS or SASS unless already present)
- **State**: Use the project’s state solution (e.g. Zustand, React Context, Redux) as already used in the codebase
- **HTTP**: Single API client (e.g. Axios in `services/api.ts`); do not create ad-hoc fetch calls scattered across components
- **UI primitives**: Use existing component library or design system (e.g. shadcn-style components in `components/ui/`)

Use only the stack choices already in the project. Do not introduce a second state library or styling system.

---

## 2. Project Structure

- **components/**  
  - **ui/**: Primitives (Button, Card, Input, Dialog, etc.)
  - **common/**: Shared UI (modals, confirmations)
  - **layout/**: Header, Sidebar, layout wrappers
  - **pages/**: Full-page views
  - (Optional) **stages/** or feature folders for larger features

- **contexts/**: Auth, theme, or other app-wide UI state (if the project uses Context)
- **stores/**: Global state stores (e.g. Zustand) — one store per domain when applicable
- **services/**: API client and namespaced API functions
- **hooks/**: Custom hooks
- **types/**: Shared TypeScript types
- **utils/**: Helpers (e.g. `cn()` for class names)
- **styles/**: Global CSS entry and design tokens / style constants (if the project uses them)

Use **functional components** only. Prefer small, reusable components; avoid huge single-file pages.

---

## 3. Component Size and Modularization

- Keep component files **under ~300 lines** where possible. If a component exceeds ~400 lines, consider splitting by responsibility.
- **Modularize**: Extract reusable patterns into `components/common/` or `components/ui/`. Co-locate sub-components that are only used by one parent (e.g. in the same folder).
- **Single responsibility**: Each component should have one clear purpose. Lift state only when necessary for sharing between siblings.

---

## 4. Styling

- Use the project’s styling system only (e.g. **Tailwind only**). Avoid inline styles for things Tailwind can do.
- Use **design tokens** from the project’s config (e.g. `tailwind.config.js`) instead of arbitrary hex values.
- **Class merging**: Use the project’s utility (e.g. `cn()` from `utils/cn.ts`) when combining or conditioning class names.
- If the project has a **centralized style constants** folder (e.g. `styles/cards.ts`, `styles/badges.ts`), import from there instead of repeating long class strings.

---

## 5. State Management

- **Global state**: Use the existing store(s) or context (e.g. Zustand for domain data, Context for auth/UI). Do not add a new global state library.
- **Local state**: Use `useState` / `useReducer` for component-local UI state (forms, modals). Do not lift state to a global store unless it is shared across routes or many components.
- **Server state**: Use the project’s pattern (e.g. React Query, SWR, or direct API calls from the central API service).

---

## 6. API and Data

- Call the backend only through the **central API client** (e.g. `services/api.ts`). Do not scatter `fetch` or Axios instances across components.
- Handle loading and error states in the UI (e.g. loading spinners, error messages) using the patterns already used in the project.

---

## 7. Summary Checklist

- Use only the project’s stack (React, TS, Tailwind, state library, API client).
- Structure: components (ui, common, layout, pages), contexts/stores, services, hooks, types, utils.
- Keep components small and focused; extract reusable pieces; use design tokens and centralized styles when present.
- Single API client; no ad-hoc fetch; handle loading/error in UI.
