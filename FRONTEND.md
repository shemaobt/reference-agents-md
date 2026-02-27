# Frontend Agent Guidelines (mm_poc_v2)

## Design System Authority

All UI, styling, layout, spacing, colors, typography, and visual decisions
MUST strictly follow the Design System defined in:

- **[./design-system/AGENTS.md](./design-system/AGENTS.md)** - Brand authority and core principles
- **[./design-system/DESIGN.md](./design-system/DESIGN.md)** - Design system overview and complete index
- **[./design-system/tokens/](./design-system/tokens/)** - Authoritative design tokens (colors, typography, spacing, etc.)
- **[./design-system/*.md](./design-system/)** - Complete implementation guides

This AGENT must not override, reinterpret, or invent visual rules.
If a visual decision is missing, consult the design system documentation or request clarification.
Failure to follow the Design System must be treated as a defect, not a stylistic preference.

This file defines **frontend-specific** conventions for LLM agents working in `frontend/`. It extends the repository-wide [GENERAL-WEB-APP.md](https://github.com/shemaobt/reference-agents-md/blob/main/GENERAL-WEB-APP.md): follow those global guidelines first, then apply what is below.

---

## 1. Stack and Build

- **Framework**: React 18
- **Language**: TypeScript
- **Build / dev**: Vite
- **Styling**: **Tailwind CSS** only (no CSS-in-JS, no styled-components, no SASS unless already present)
- **UI primitives**: Radix UI (via shadcn-style components in `src/components/ui/`)
- **State**: **Zustand** for application/passage state; **React Context** for auth and UI state (e.g. sidebar)
- **HTTP**: Axios (single client in `src/services/api.ts`)
- **Icons**: lucide-react
- **Toasts**: sonner
- **Utilities**: class-variance-authority (cva), clsx, tailwind-merge; use `cn()` from `src/utils/cn.ts` for merging class names

Use only these stack choices. Do not introduce Redux, MobX, or other state libraries; do not add a second styling system.

---

## 2. Project Structure

```
frontend/src/
├── App.tsx
├── main.tsx
├── components/
│   ├── common/       # shared UI (modals, etc.)
│   ├── layout/       # Header, Sidebar, ProgressBar
│   ├── pages/        # full-page views (Login, SavedMaps, Admin, etc.)
│   ├── stages/       # stage components (Stage1Syntax … Stage5Discourse)
│   └── ui/           # primitives (Button, Card, Input, Dialog, etc.)
├── contexts/         # AuthContext, SidebarContext
├── stores/           # Zustand stores (passageStore)
├── services/         # api.ts (axios client + namespaced APIs)
├── hooks/            # custom hooks (useOptions, etc.)
├── types/            # shared TypeScript types
├── constants/        # app constants (tripod, etc.)
├── utils/             # cn, etc.
└── styles/            # main.css (Tailwind entry) + centralized style constants (cards.ts, badges.ts, etc.)
```

- **components/**  
  Use **functional components** only. No class components. Prefer small, reusable components; avoid huge single-file pages.

### Component size and modularization

- **Target size**: Individual component files should generally be **under 300 lines**. If a component exceeds 400 lines, it almost certainly needs to be broken down.
- **Modularize by responsibility**: Split large components into smaller, focused sub-components. Each component should have a single responsibility.
- **Extract reusable patterns**: If a UI pattern appears more than once, extract it into a reusable component in `components/common/` or `components/ui/`.
- **Co-locate related components**: Sub-components that are only used by one parent can live in the same folder (e.g., `stages/Stage1Syntax/` with `index.tsx`, `PericopeSelector.tsx`, `ClauseCard.tsx`).
- **Avoid unnecessary breaking**: Don't split a component just to hit a line count. Split when there is a clear separation of concerns, reusability potential, or when the component becomes hard to read/maintain.
- **Keep state close**: Sub-components should receive data via props. Lift state only when necessary for sharing between siblings.

**Signs a component needs splitting:**

- More than 400 lines
- Multiple large JSX blocks that could be named components
- Many useState hooks managing unrelated state
- Helper functions that are only used for one section of the UI
- Hard to understand the component's main purpose at a glance

**Examples:**

- ✅ **Good:** `Stage1Syntax/index.tsx` (main logic ~200 lines) + `PericopeSelector.tsx` + `ClauseCard.tsx` + `PreviewCard.tsx` + `DiscardSessionDialog.tsx`
- ❌ **Bad:** Single 1000+ line file with all logic, all JSX, and all helpers mixed together.
- ✅ **Good:** Extract `ClauseCard` that receives `clause`, `isChecked`, `onToggle` as props and renders one clause.
- ❌ **Bad:** Inline 50+ lines of JSX for each clause inside a `.map()` in the parent component.
- ✅ **Good:** Reusable `ConfirmDialog` in `components/common/` used across multiple pages.
- ❌ **Bad:** Copy-pasting dialog markup in every component that needs a confirmation modal.

- **Modularize**: Split large components into smaller ones. Reuse primitives from `components/ui/` (Button, Card, Input, Dialog, Select, Badge, etc.). Do not duplicate UI patterns that already exist in `ui/`.

- **pages/**  
  Full-page views (e.g. LoginPage, SavedMapsPage, AdminDashboard). Compose from layout and ui components.

- **stages/**  
  Stage-specific UI (Stage1Syntax … Stage5Discourse). Use stores and services; keep presentation and data flow clear.

---

## 3. Styling and Tailwind

- **Use Tailwind only** for layout, spacing, colors, typography, and responsive behavior.
- **Avoid inline styles** for things Tailwind can handle (e.g. `className="flex items-center gap-2"` instead of `style={{ display: 'flex', alignItems: 'center' }}`).  
  Use inline `style` **only when strictly necessary** (e.g. dynamic values or third-party integrations).
- **Always use the design tokens** defined in `tailwind.config.js` for colors and semantics  
  (`branco`, `areia`, `azul`, `telha`, `verde`, `verde-claro`, `preto`, and semantic tokens like `primary`, `background`, `border`, `ring`).
- `tailwind.config.js` **must stay in sync** with `design-system/tokens/*.json`.  
  Do **not** introduce arbitrary hex values in JSX; extend the theme if new tokens are required.

### Centralized style constants

- **Use `src/styles/`** for reusable style constants. This directory contains TypeScript objects with Tailwind class strings organized by purpose:
  - `cards.ts` — card, clause, event, participant card styles
  - `sections.ts` — collapsible section variant styles (roles, emotions, etc.)
  - `badges.ts` — category colors for participants, discourse, roles, validation
  - `layout.ts` — page, header, grid, form, modal layout patterns
  - `states.ts` — empty, loading, error, success, warning, info, read-only banners
- **Import from `@/styles`** when using these constants: `import { cardStyles, emptyStateStyles } from '@/styles'`
- **Prefer centralized styles** over repeating the same class strings across components. If you find yourself copying the same `className` pattern in multiple places, extract it to `src/styles/`.
- **Extend the central styles** when adding new patterns. Add new style objects to the appropriate file or create a new file if the category doesn't exist.

**Examples:**

- ✅ **Good:** `<div className={cn(cardStyles.base, cardStyles.hover)}>` — uses centralized card styles
- ❌ **Bad:** `<div className="bg-white rounded-lg border border-areia/30 shadow-sm transition-all duration-200 hover:shadow-md">` repeated in 10 components
- ✅ **Good:** `<div className={emptyStateStyles.container}>` — consistent empty state styling
- ❌ **Bad:** Different padding, colors, and icon sizes for empty states across components
- ✅ **Good:** `participantCategoryColors[category]` — category color lookup from central definition
- ❌ **Bad:** Hardcoded `bg-amber-100 text-amber-800` for divine participants in every component
- **Class merging**: Always use `cn()` from `src/utils/cn.ts` when combining conditional or overridden classes (e.g. `cn('base-class', className)`). Use `cva` for variant-based components (see `components/ui/button.tsx`).
- **No raw HTML for layout**: Prefer React components and Tailwind classes. Do not rely on hand-written HTML/CSS files for app layout or styling.

---

## 4. State Management

- **Zustand**: Use for **application and passage state** (e.g. passage data, participants, relations, events, discourse, validation, read-only flag). The main store is in `src/stores/passageStore.ts`. Follow the same pattern: one store per domain, `create` with optional `persist` middleware.
- **React Context**: Use for **auth** (AuthContext: user, login, logout) and **UI state** (SidebarContext: collapsed, etc.). Do not put passage or domain data in Context; use Zustand for that.
- **Local state**: Use `useState` / `useReducer` for component-local UI state (e.g. form fields, modals). Do not lift state to a global store unless it is shared across routes or stages.

---

## 5. API and Data

- **Single API client**: All backend calls go through `src/services/api.ts`. The file uses one Axios instance with interceptors (e.g. JWT). Namespaced methods: `authAPI`, `usersAPI`, `bhsaAPI`, `passagesAPI`, etc.
- **New endpoints**: Add methods to the appropriate namespace in `api.ts`; do not create a second axios client or duplicate auth handling.
- **Types**: Prefer types from `src/types/` or from the API module. Keep request/response types aligned with the backend and with the store (e.g. `ParticipantResponse`, `PassageData`).

---

## 6. Components and UI

- **Functional components**: Only function components; no class components.
- **UI primitives**: Use and extend components in `components/ui/` (Button, Card, Input, Dialog, Select, Badge, Progress, etc.). They use Radix + Tailwind + `cva` + `cn`. Match their API (e.g. `variant`, `size`, `className`).
- **Icons**: Use **lucide-react** only. Do not add another icon library.
- **Toasts**: Use **sonner** (`toast.success`, `toast.error`, `toast.warning`, etc.) as in the rest of the app.

---

## 7. Code Style (Frontend-Specific)

- **No comments for "what"**: Code and names should be self-explanatory. Comments only for non-obvious "why" (see root [GENERAL-WEB-APP.md](https://github.com/shemaobt/reference-agents-md/blob/main/GENERAL-WEB-APP.md)).
- **No module-level comments**: Do not add `/** Module description */` or similar at the top of files. The file name and location convey purpose.
- **TypeScript**: Prefer explicit types for props and for API/store types. Avoid `any` where a proper type exists.
- **File names**: PascalCase for components (e.g. `Stage2Participants.tsx`); camelCase for utilities, hooks, stores (e.g. `passageStore.ts`, `useOptions.ts`, `cn.ts`).

---

## 8. Summary Checklist (Frontend)

- [ ] Follow root [GENERAL-WEB-APP.md](https://github.com/shemaobt/reference-agents-md/blob/main/GENERAL-WEB-APP.md) (functional preference, no comments for "what", clean architecture, no commit unless asked, semantic commits).
- [ ] Use only the stack above: React, TypeScript, Vite, Tailwind, Zustand, Context, Axios, Radix/shadcn-style ui, lucide-react, sonner.
- [ ] **React**: Functional components only; modularize; reuse `components/ui/` primitives.
- [ ] **Component size**: Keep components under 300 lines; split if over 400 lines. Extract sub-components by responsibility.
- [ ] **Styling**: Tailwind only; use `cn()` and design tokens from `tailwind.config.js`; avoid inline styles except when necessary.
- [ ] **Centralized styles**: Use `src/styles/` for reusable patterns (cards, badges, states, layout); avoid repeating the same className strings.
- [ ] **State**: Zustand for passage/app state; Context for auth and UI state; local state for component-only state.
- [ ] **API**: Single `api.ts` client; add new methods to the existing namespaces.
- [ ] No raw HTML/CSS for app layout; no new state or styling libraries.

---

*Reference copy from [mm_poc_v2/frontend/AGENTS.md](https://github.com/shemaobt/mm_poc_v2/blob/main/frontend/AGENTS.md). Place in your repo at `frontend/AGENTS.md` or `frontend/FRONTEND.md`. Built using [agents.md](https://agents.md/).*
---

# Design System — Shema (Conteúdo Completo Mesclado)

> O conteúdo abaixo foi mesclado a partir de todos os arquivos `.md` da pasta `design-system/`.
> Informações duplicadas entre os arquivos originais foram consolidadas em seções únicas.
> O arquivo `README.md` foi omitido pois serve apenas como índice de navegação.

---

## DS-1. Guia para AI Agents — Princípios de Marca e Regras Visuais

> Origem: `design-system/AGENTS.md`

## 1. Purpose
This Design System defines the visual and behavioral rules for creating interfaces for the **Shema** platform, covering **Web** and **Mobile App (Flutter)**.

The Shema brand operates in the context of biblical translation and sacred text reading. Its visual identity must reflect the following values:

- Simple  
- Accessible  
- Lively  
- Friendly  
- Human  

This document acts as a **mandatory contract** for designers, developers, and AI agents.

---

## 2. Visual Principles

### Natural Feel
- Avoid pure white (#FFFFFF) as the main background.
- Use **Shema White / Cream (#F6F5EB)** to simulate paper and provide visual comfort.
- Pure white is reserved only for elevated surfaces (cards, inputs).

### Soft Contrast
- Text uses **Shema Black (#0A0703)**, never absolute black.
- Subtitles and secondary text use **Shema Dark Green (#3F3E20)**.

### Typography
- **Montserrat**: entire interface (UI, buttons, navigation).
- **Merriweather**: long-form texts, biblical content, and continuous reading.
- Fonts observed in screenshots should be ignored if they conflict with this guide.

### Color Hierarchy
- **Tile / Clay (#BE4A01)** is exclusive to:
  - CTAs
  - Primary actions
  - Active icons
- Never use Tile as a neutral decorative color.

---

## 3. UI Generation Rules

### What TO DO

#### Mobile (Flutter)
- Use **Elevation** to separate surfaces.
- Buttons and cards with generously rounded corners (16px+).
- Large touch areas.
- Components compatible with `ColorScheme` and `TextTheme`.

#### Web
- Wider, more breathable layouts.
- Cards with corner radius between 8px and 12px.
- Hover and focus states using opacity, never new colors.

#### Colors
- Use only the defined design tokens.
- Variations only through **opacity** or **state**.

---

## Color Modes Governance

The Shema Design System officially supports two visual modes.

---

### ☀️ Light Mode — “Paper & Ink”

**Metaphor:** Printed paper.

- Background: Cream Shema (#F6F5EB)
- Surface: Pure White (#FFFFFF)
- Primary Text: Black Shema (#0A0703)
- Secondary Text: Dark Green (#3F3E20)
- Borders: Sand (#C5C29F)

Pure white must never be used as a page background.

---

### 🌙 Dark Mode — “Night & Earth”

**Metaphor:** Organic night environment.

- Background: Black Shema (#0A0703)
- Surface: Black Shema with visible borders
- Highlight Surface: Dark Green (#3F3E20)
- Primary Text: Cream Shema (#F6F5EB)
- Secondary Text: Sand (#C5C29F)

---

### Strict Restrictions

- Do NOT use generic neutral greys.
- Do NOT approximate Material Design dark palettes.
- Dark interfaces must be composed only using Shema palette colors.

Failure to follow these rules must be treated as a design defect, not a stylistic preference.

### What NOT TO DO
- Do not create complex gradients.
- Do not invent new semantic colors outside the earthy palette.
- Do not use Merriweather for buttons, menus, or navigation.
- Do not mix Web and App patterns without explicit documentation.

---

### Spacing and Layout
- **Generous breathing room**: Use the 4px base spacing scale (Tailwind).
- **Card padding**: 16px minimum (mobile), 24px recommended (desktop).
- **Section gaps**: Space-y-6 or space-y-8 for vertical rhythm.
- **Grid systems**: Responsive grids that adapt from single column (mobile) to multi-column (desktop).

### Component Guidelines

#### Buttons
- **Primary (Tile)**: Reserved for main CTAs only.
- **Rounded corners**: 8px+ for buttons (Web), 16px+ for mobile.
- **Touch targets**: Minimum 44px height for mobile buttons.
- **States**: Use opacity for hover/focus, never introduce new colors.

#### Cards
- **Background**: White (#FFFFFF) for elevated surfaces.
- **Borders**: Subtle with `border-areia/30`.
- **Corner radius**: 8-12px (Web), 16px+ (Mobile).
- **Shadows**: Soft shadows for elevation (`shadow-sm`, `shadow-md`).
- **Hover states**: Increase shadow and adjust border opacity.

#### Forms
- **Inputs**: White background with `border-areia`.
- **Focus states**: Ring with telha color (`ring-telha`).
- **Labels**: Montserrat medium, text-sm.
- **Validation**: Use verde-claro for success, red for errors.

#### Badges
- **Rounded**: Full rounded (`rounded-full`) for pill-shaped badges.
- **Category colors**: Predefined color combinations for participants, events, discourse.
- **Size**: text-xs with medium weight for clarity.

---

## 4. Animation Principles

### Transitions
- **Duration**: 200ms default for most interactions.
- **Easing**: Use `ease-out` for entrances, `ease-in-out` for state changes.
- **Properties**: Prefer `transform` and `opacity` (GPU-accelerated).

### Keyframes
- **fade-in**: Subtle entrance with vertical movement.
- **slide-in**: Horizontal entrance for modals/sheets.
- **pulse-soft**: Gentle attention grabber.
- **celebrate**: Success feedback animation.

### Best Practices
- Avoid animating layout properties (width, height, top, left).
- Respect `prefers-reduced-motion` user preference.
- Keep animations subtle and non-distracting.

For complete animation specifications, see [animations.md](./animations.md).

---

## 5. Detailed Color Usage

### Primary Colors
- **Telha (#BE4A01)**: Exclusive to CTAs, primary actions, active states.
  - **Variations**: `telha-light`, `telha-dark`, `telha-muted` for different contexts.
  - **Never** use telha as neutral decoration or background.

- **Shema White / Cream (#F6F5EB)**: Main background color.
  - Provides paper-like warmth and reduces eye strain.
  - Pure white (#FFFFFF) is reserved for elevated surfaces (cards, inputs).

- **Shema Black (#0A0703)**: Primary text color.
  - Softer than absolute black, better for long reading sessions.

- **Shema Dark Green (#3F3E20)**: Secondary text, subtitles, descriptions.

### Supporting Colors
- **Blue (#89AAA3)**: Supporting elements, subtle backgrounds.
- **Light Green (#777D45)**: Success states, positive indicators, validation.
- **Sand (#C5C29F)**: Borders, muted elements, warnings.

### Opacity Patterns
- `/10`: Very subtle backgrounds
- `/20`: Soft backgrounds for badges/highlights
- `/30`: Borders and subtle separators
- `/50`: Medium overlays
- `/90`: Strong hover states

For complete color specifications, see [colors.md](./colors.md).

---

## 6. Governance

The single source of truth consists of:

### Conflict Resolution
1. **Token files** override visual references
2. **This AGENTS.md** defines brand authority and principles
3. **Implementation docs** provide detailed usage patterns
4. When in doubt, consult token files first, then this document

Any exception must be documented.

---

## DS-2. Design System — Visão Geral e Quick Start

## 📖 Overview

The She design system for the **Shema** platform provides a comprehensive visual language and component library for creating consistent, accessible, and beautiful interfaces across Web and Mobile applications.

### Brand Values

Shema operates in the context of biblical translation and sacred text reading. The design system reflects these core values:

- **Simple** - Clean interfaces that don't overwhelm
- **Accessible** - Usable by all, with proper contrast and semantic HTML
- **Lively** - Warm, engaging colors that invite interaction
- **Friendly** - Approachable components and gentle animations
- **Human** - Natural feel with paper-like backgrounds and soft contrasts

---

## 🎨 Quick Start

### Color Palette (Earthy Tones)

| Color | Hex | Usage |
|-------|-----|-------|
| **Telha** (Clay/Tile) | `#BE4A01` | CTAs, primary actions, active states |
| **Shema White** (Cream) | `#F6F5EB` | Main background |
| **Shema Black** | `#0A0703` | Primary text |
| **Shema Dark Green** | `#3F3E20` | Secondary text |
| **Blue** | `#89AAA3` | Supporting elements |
| **Light Green** | `#777D45` | Success, validation |
| **Sand** | `#C5C29F` | Borders, muted elements |

### Typography

- **Montserrat**: Entire UI (buttons, navigation, labels, headings)
- **Merriweather**: Long-form text, biblical content, continuous reading

### Spacing Scale

Based on **4px base unit** (Tailwind default):
- `space-2` (8px) - Tight spacing
- `space-4` (16px) - Default spacing
- `space-6` (24px) - Section spacing
- `space-8` (32px) - Large gaps

### Component Basics

```tsx
import { Button, Card, Badge } from '@/components/ui'
import { cardStyles } from '@/styles'

// Primary button
<Button variant="default">Save Changes</Button>

// Card with content
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
  </CardHeader>
  <CardContent>Content</CardContent>
</Card>

// Category badge
<Badge className={participantCategoryColors['person']}>
  Person
</Badge>
```

---

## 📚 Complete Documentation

### Design Tokens (Authoritative Source)

Tokens are the single source of truth. All implementation must align with these files:

- **[colors.json](./tokens/colors.json)** - Color palette, semantic tokens, category colors
- **[typography.json](./tokens/typography.json)** - Font families, scales, weights, line heights
- **[spacing.json](./tokens/spacing.json)** - Spacing scale, semantic spacing values
- **[animations.json](./tokens/animations.json)** - Keyframes, durations, easing functions
- **[borders.json](./tokens/borders.json)** - Border widths, corner radius values
- **[shadows.json](./tokens/shadows.json)** - Shadow scales for elevation

### Implementation Guides

Detailed usage patterns and code examples for each design system element:

1. **[colors.md](./colors.md)** - Complete color system
   - Base palette and semantic tokens
   - Category colors (participants, events, discourse)
   - Validation and state colors
   - Opacity patterns and usage examples

2. **[typography.md](typography.md)** - Typography hierarchy
   - Font families (Montserrat, Merriweather)
   - Type scale (headings, body, captions)
   - Font weights, line heights, letter spacing
   - Hebrew text specifications

3. **[spacing.md](./spacing.md)** - Spacing and layout
   - Spacing scale (4px base)
   - Layout patterns (grids, containers)
   - Padding and margin conventions
   - Label → Input/Select spacing (mb-2 default)
   - Dropdown spacing and icon positioning

4. **[animations.md](./animations.md)** - Motion design
   - Keyframes (fade-in, slide-in, pulse, celebrate)
   - Transition patterns and durations
   - Performance best practices

5. **[components.md](./components.md)** - UI components
   - Progress Step (preferred option for progress indicators)
   - Button, Card, Input, Select, Dialog
   - Component variants and sizes
   - Usage patterns and examples

6. **[cards.md](./cards.md)** - Card system
   - Card variants (base, hover, selected, dashed)
   - Specialized cards (clause, event, participant)
   - States and interactions

7. **[badges.md](./badges.md)** - Badge system
   - Badge variants and sizes
   - Category colors and semantic badges
   - Validation and status badges

8. **[states.md](./states.md)** - UI states
   - Loading states and spinners
   - Error, success, warning banners
   - Empty states and placeholders

9. **[layout.md](./layout.md)** - Layout patterns
   - Grid systems (responsive)
   - Page templates and containers
   - Modal and dialog layouts

10. **[border-radius.md](./border-radius.md)** - Corner radius
    - Radius scale (sm, md, lg)
    - Component-specific radius values
    - Platform differences (Web vs Mobile)

11. **[sections.md](./sections.md)** - Section patterns
    - Collapsible sections
    - Section variants (roles, emotions, etc.)
    - Header patterns

12. **[themes.md](./themes.md)** - Theme system
    - Light theme (current)
    - Dark theme (future)
    - Theme switching implementation

---

## 🎯 Design Principles

### 1. Natural Feel

Avoid stark, clinical interfaces. Use **Shema White / Cream (#F6F5EB)** as the main background to simulate paper texture and provide visual comfort. Reserve pure white (#FFFFFF) for elevated surfaces like cards and inputs.

### 2. Soft Contrast

Text uses **Shema Black (#0A0703)** instead of absolute black. Secondary text uses **Shema Dark Green (#3F3E20)**. This creates legible but gentle contrast suitable for long reading sessions.

### 3. Intentional Color

**Telha / Clay (#BE4A01)** is exclusive to primary actions, CTAs, and active states. Never use Telha as neutral decoration. This preserves its visual weight and guides users to key actions.

### 4 Responsive Typography

Use **Montserrat** for all UI elements (navigation, buttons, labels). Use **Merriweather** exclusively for long-form biblical text and continuous reading contexts.

### 5. Elevation Through Shadow

Create depth with subtle shadows (`shadow-sm`, `shadow-md`), not heavy outlines or thick borders. Hover states should increase shadow intensity.

### 6. Gentle Motion

Animations are subtle and non-distracting. Default duration is 200ms. Prefer `transform` and `opacity` for smooth, GPU-accelerated transitions.

---

## 🛠️ Using the Design System

### In React Components

```tsx
import { Button, Card, Badge, Input } from '@/components/ui'
import { cardStyles, participantCategoryColors } from '@/styles'
import { cn } from '@/utils/cn'

export function ExampleComponent() {
  return (
    <Card className={cn(cardStyles.base, cardStyles.hover)}>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Icon className="w-5 h-5 text-telha" />
          Passage Details
        </CardTitle>
        <CardDescription>Genesis 1:1-3</CardDescription>
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          <Input placeholder="Add notes..." />
          <Badge className={participantCategoryColors['divine']}>
            Divine
          </Badge>
        </div>
      </CardContent>
      <CardFooter>
        <Button variant="default">Save</Button>
        <Button variant="outline">Cancel</Button>
      </CardFooter>
    </Card>
  )
}
```

### With Tailwind Classes

```tsx
// Background and text colors
<div className="bg-branco text-preto">
  <h1 className="text-2xl font-bold text-preto">Heading</h1>
  <p className="text-sm text-verde">Description</p>
</div>

// Spacing and layout
<div className="p-6 space-y-4">
  <div className="flex items-center gap-2">
    ...
  </div>
</div>

// Transitions and hover
<button className="bg-telha hover:bg-telha-dark transition-all duration-200 shadow-sm hover:shadow-md">
  Click me
</button>
```

---

## 📱 Platform Differences

### Web
- Border radius: 8-12px for cards, 8px for buttons
- Hover states: Use opacity and shadow changes
- Layouts: Wider, more breathable spacing

### Mobile (Flutter)
- Border radius: 16px+ for generous rounded corners
- Touch targets: Minimum 44px height
- Elevation: Use Material elevation for depth
- Large touch areas for accessibility

---

## 🔄 Governance and Authority

### Hierarchy of Truth

1. **Token files** (`/tokens/*.json`) are authoritative. If there's a conflict between code and tokens, tokens win.
2. **[AGENTS.md](./AGENTS.md)** defines brand values and core principles.
3. **Implementation docs** (this file and others) provide detailed usage patterns.

### When to Update

- **Tokens**: Only update with design team approval.
- **Implementation docs**: Update when patterns evolve or new use cases emerge.
- **Visual references**: Update when major visual changes occur.

### Requesting Changes

Document any exceptions or deviations. Propose token changes through design review process. Never introduce arbitrary colors or typography outside the defined system.

---

## ✅ Checklist for Contributors

Before creating or modifying UI:

- [ ] Use colors from `colors.json` only
- [ ] Use Montserrat for UI, Merriweather for reading content
- [ ] Follow spacing scale (4px base)
- [ ] Use existing components from `/components/ui`
- [ ] Apply centralized styles from `/styles`
- [ ] Test hover and focus states
- [ ] Verify accessibility (contrast, keyboard navigation)
- [ ] Respect `prefers-reduced-motion` for animations
- [ ] Check responsive behavior (mobile, tablet, desktop)

---

*This design system is maintained by the Shema design team. For questions or contributions, consult the governance section above.*

---

## DS-3. Sistema de Cores

## Overview

The Shema Design System uses an earthy color palette inspired by natural tones, reflecting the brand values: simple, accessible, lively, friendly, and human.

## Base Palette

| Name | Hex | Token | Usage |
|------|-----|-------|-----|
| **Telha (Clay/Tile)** | `#BE4A01` | `telha` | Primary color, CTAs, primary actions, active states |
| **Shema White (Cream)** | `#F6F5EB` | `branco` | Main background, simulates paper |
| **Sand** | `#C5C29F` | `areia` | Borders, secondary elements, muted |
| **Blue** | `#89AAA3` | `azul` | Supporting elements, subtle backgrounds |
| **Light Green** | `#777D45` | `verde-claro` | Success, validation, positive states |
| **Dark Green** | `#3F3E20` | `verde` | Secondary text, descriptions |
| **Shema Black** | `#0A0703` | `preto` | Primary text, foreground |
| **Pure White** | `#FFFFFF` | `white` | Elevated surfaces (cards, inputs) |

> [!IMPORTANT]
> **Shema Brand Rule**: Never use pure white (#FFFFFF) as the main background. Use **Shema White / Cream (#F6F5EB)** to simulate paper and provide visual comfort. Pure white is reserved exclusively for elevated surfaces (cards, inputs).

## Primary Colors

### Telha (#BE4A01)

**Exclusive to CTAs, primary actions, and active icons.**

- **Never** use Telha as neutral decoration or background.
- Variations are created through opacity or state changes.
- Hover states use opacity, never new colors.

### Shema White / Cream (#F6F5EB)

**Main background color.**

- Provides paper-like warmth and reduces eye strain.
- Pure white (#FFFFFF) is reserved for elevated surfaces (cards, inputs).

### Shema Black (#0A0703)

**Primary text color.**

- Softer than absolute black, better for long reading sessions.
- Never use absolute black (#000000).

### Shema Dark Green (#3F3E20)

**Secondary text, subtitles, descriptions.**

## Supporting Colors

### Blue (#89AAA3)

Supporting elements and subtle backgrounds.

### Light Green (#777D45)

Success states, positive indicators, validation.

### Sand (#C5C29F)

Borders, muted elements, warnings.

## Semantic Tokens

The system defines semantic tokens that map to base colors:

```typescript
primary: {
  DEFAULT: '#BE4A01',      // telha
  foreground: '#F6F5EB',   // branco
}

secondary: {
  DEFAULT: '#89AAA3',      // azul
  foreground: '#0A0703',   // preto
}

success: {
  DEFAULT: '#777D45',      // verde-claro
  foreground: '#F6F5EB',  // branco
}

background: '#F6F5EB'     // branco (Shema Cream)
foreground: '#0A0703'     // preto (Shema Black)

card: {
  DEFAULT: '#FFFFFF',      // white
  foreground: '#0A0703',  // preto
}

border: '#C5C29F'         // areia
input: '#C5C29F'          // areia
ring: '#BE4A01'           // telha (focus rings)

muted: {
  DEFAULT: '#C5C29F',     // areia
  foreground: '#3F3E20', // verde
}

accent: {
  DEFAULT: '#89AAA3',     // azul
  foreground: '#0A0703', // preto
}

destructive: {
  DEFAULT: '#BE4A01',     // telha (same as primary)
  foreground: '#F6F5EB', // branco
}
```

## Opacity Patterns

The system uses opacity to create subtle variations:

- `/10` - Very subtle backgrounds (e.g., `bg-telha/10`)
- `/20` - Soft backgrounds for badges/highlights (e.g., `bg-verde-claro/20`)
- `/30` - Borders and subtle separators (e.g., `border-areia/30`)
- `/50` - Medium overlays
- `/90` - Strong hover states

### Examples

```tsx
// Soft background
<div className="bg-verde-claro/10">...</div>

// Border with opacity
<div className="border border-areia/30">...</div>

// Hover with opacity
<button className="hover:bg-telha/20">...</button>
```

## Category Colors

### Participants

Colors for different participant categories:

```typescript
participantCategoryColors = {
  divine: 'bg-amber-100 text-amber-800 border-amber-200',
  person: 'bg-telha/10 text-telha-dark border-telha/20',
  place: 'bg-azul/20 text-verde border-azul/30',
  time: 'bg-verde-claro/20 text-verde border-verde-claro/30',
  object: 'bg-gray-100 text-gray-800 border-gray-200',
  abstract: 'bg-areia/30 text-preto border-areia',
  group: 'bg-indigo-100 text-indigo-800 border-indigo-200',
  animal: 'bg-emerald-100 text-emerald-800 border-emerald-200',
}
```

### Events

Colors for event categories:

```typescript
eventCategoryColors = {
  ACTION: 'bg-telha/10 text-telha border-telha/20',
  SPEECH: 'bg-azul/20 text-verde border-azul/30',
  MOTION: 'bg-verde-claro/20 text-verde border-verde-claro/30',
  STATE: 'bg-areia/30 text-verde border-areia',
  PROCESS: 'bg-purple-100 text-purple-800 border-purple-200',
  TRANSFER: 'bg-blue-100 text-blue-800 border-blue-200',
  INTERNAL: 'bg-pink-100 text-pink-800 border-pink-200',
  RITUAL: 'bg-amber-100 text-amber-800 border-amber-200',
  META: 'bg-gray-100 text-gray-800 border-gray-200',
}
```

### Discourse

Colors for discourse relations:

```typescript
discourseCategoryColors = {
  temporal: 'bg-blue-100 text-blue-800',
  logical: 'bg-purple-100 text-purple-800',
  rhetorical: 'bg-orange-100 text-orange-800',
  narrative: 'bg-emerald-100 text-emerald-800',
}
```

## Validation States

Colors for validation states:

```typescript
validationBadgeStyles = {
  validated: 'bg-verde-claro/20 text-verde-claro border-verde-claro/30',
  pending: 'bg-areia/30 text-verde border-areia',
  error: 'bg-red-100 text-red-800 border-red-200',
}
```

## Accessibility

### Contrast

All color combinations follow WCAG standards:

- **Normal text**: Minimum contrast of 4.5:1
- **Large text**: Minimum contrast of 3:1
- **Interactive elements**: Minimum contrast of 3:1

### Contrast Examples

- `preto` on `branco`: ✅ 21:1 (Excellent)
- `telha` on `branco`: ✅ 4.8:1 (Adequate)
- `verde` on `branco`: ✅ 8.2:1 (Excellent)
- `telha` on `areia`: ⚠️ 2.1:1 (Not adequate - avoid)

## Usage in Code

### Tailwind Classes

```tsx
// Direct colors
<div className="bg-telha text-white">...</div>
<div className="text-verde">...</div>

// With opacity
<div className="bg-verde-claro/10 border-verde-claro/30">...</div>

// Semantic tokens
<div className="bg-primary text-primary-foreground">...</div>
```

### TypeScript/JavaScript

```typescript
import { participantCategoryColors } from '@/styles'

const categoryColor = participantCategoryColors[participant.category]
```
---

## DS-4. Tipografia

## Font Families

### Montserrat — Primary Font (UI)

**Usage**: Entire interface (buttons, navigation, labels, headings, forms)

```css
font-family: 'Montserrat', system-ui, -apple-system, sans-serif;
```

> [!IMPORTANT]
> **Montserrat is exclusive for UI**. Use Montserrat for all interface elements: buttons, menus, navigation, card titles, form labels, badges, and any interactive element.

### Merriweather — Secondary Font (Reading)

**Usage**: Long-form text, biblical content, continuous reading

```css
font-family: 'Merriweather', Georgia, serif;
```

> [!IMPORTANT]
> **Merriweather is exclusive for reading contexts**. Use Merriweather only for continuous reading text, especially biblical content and extensive passages.

### Tailwind Configuration

```javascript
fontFamily: {
  sans: ['Montserrat', 'system-ui', '-apple-system', 'sans-serif'],
  serif: ['Merriweather', 'Georgia', 'serif'],
}
```

### Hebrew Text Font

For Hebrew text, use a serif font with RTL direction:

```css
.hebrew-text {
  font-family: serif;
  text-align: right;
  direction: rtl;
  font-size: 1.125rem; /* text-lg */
  line-height: 1.75;    /* leading-relaxed */
}
```

## Font Weights

Available weights:

| Class | Weight | Usage |
|--------|------|-----|
| `font-normal` | 400 | Default text, body, reading |
| `font-medium` | 500 | Labels, badges, subtle emphasis |
| `font-semibold` | 600 | Card titles, subtitles |
| `font-bold` | 700 | Main headings, strong emphasis |

## Type Scale

### Web Scale

| Style | Font Family | Weight | Size | Line Height | Usage |
|-------|-------------|--------|------|-------------|-------|
| `h1` | Montserrat | 700 | 32px | 1.2 | Main page titles |
| `h2` | Montserrat | 700 | 24px | 1.3 | Section headings |
| `h3` | Montserrat | 600 | 20px | 1.4 | Card titles, subsections |
| `body` | Montserrat | 400 | 16px | 1.5 | Default UI text |
| `body_serif` | Merriweather | 400 | 16px | 1.6 | Reading contexts |
| `caption` | Montserrat | 500 | 12px | 1.5 | Labels, hints, badges |

### App Scale (Flutter)

| Style | Font Family | Weight | Size | Flutter Style |
|-------|-------------|--------|------|---------------|
| `display` | Montserrat | 700 | 28px | headlineMedium |
| `title` | Montserrat | 700 | 20px | titleLarge |
| `body` | Montserrat | 400 | 16px | bodyMedium |
| `label` | Montserrat | 500 | 14px | labelLarge |

## Tailwind Size Classes

| Class | Size | Line Height | Usage |
|--------|---------|-------------|-----|
| `text-xs` | 0.75rem (12px) | 1rem | Small labels, badges, hints |
| `text-sm` | 0.875rem (14px) | 1.25rem | Secondary text, descriptions, inputs |
| `text-base` | 1rem (16px) | 1.5rem | Default body text |
| `text-lg` | 1.125rem (18px) | 1.75rem | Hebrew text, highlights, subtitles |
| `text-xl` | 1.25rem (20px) | 1.75rem | Card titles, section subtitles |
| `text-2xl` | 1.5rem (24px) | 2rem | Page titles, main headers |
| `text-3xl` | 1.875rem (30px) | 2.25rem | Hero titles, large titles |
| `text-4xl` | 2.25rem (36px) | 2.5rem | Large headers (mobile hero) |

## Line Height

| Class | Value | Usage |
|--------|-------|-----|
| `leading-none` | 1 | Very compact headings |
| `leading-tight` | 1.25 | Headings, headers |
| `leading-snug` | 1.375 | Subtitles |
| `leading-normal` | 1.5 | Default UI text |
| `leading-relaxed` | 1.75 | Hebrew text, reading, long paragraphs |
| `leading-loose` | 2 | Very spaced text |

## Letter Spacing

| Class | Value | Usage |
|--------|-------|-----|
| `tracking-tighter` | -0.05em | Large display headings |
| `tracking-tight` | -0.025em | Normal headings |
| `tracking-normal` | 0 | Default (most cases) |
| `tracking-wide` | 0.025em | Labels, badges, uppercase |
| `tracking-wider` | 0.05em | Spaced headers |
| `tracking-widest` | 0.1em | Decorative headings |

## Typography Hierarchy

### Page Title

```tsx
<h1 className="text-2xl font-bold text-preto flex items-center gap-2">
  <Icon className="w-5 h-5 text-telha" />
  Page Title
</h1>
```

**Font**: Montserrat Bold 24px, text-preto

### Card Title

```tsx
<CardTitle className="text-xl font-semibold leading-none tracking-tight text-preto">
  Card Title
</CardTitle>
```

**Font**: Montserrat Semibold 20px, text-preto

### Description

```tsx
<CardDescription className="text-sm text-verde">
  Card or section description
</CardDescription>
```

**Font**: Montserrat Regular 14px, text-verde

### Body Text (UI)

```tsx
<p className="text-base text-preto leading-normal">
  Application body text
</p>
```

**Font**: Montserrat Regular 16px, text-preto

### Reading Content (Biblical Content)

```tsx
<div className="font-serif text-base leading-relaxed text-preto">
  <p>
    In the beginning, God created the heavens and the earth...
  </p>
</div>
```

**Font**: Merriweather Regular 16px, leading-relaxed, text-preto

### Secondary Text

```tsx
<p className="text-sm text-verde">
  Secondary or descriptive text
</p>
```

**Font**: Montserrat Regular 14px, text-verde

### Labels and Hints

```tsx
<label className="text-sm font-medium text-preto">
  Field Label
</label>
<span className="text-xs text-verde/60">
  Hint or help
</span>
```

**Font**: Montserrat Medium/Regular, text-xs or text-sm

## Text Styles

### Decoration

```tsx
// Underlined (links)
<a className="underline underline-offset-4">Link</a>

// Strikethrough
<span className="line-through">Strikethrough text</span>

// No decoration
<span className="no-underline">No decoration text</span>
```

### Transformation

```tsx
// Uppercase
<span className="uppercase">UPPERCASE TEXT</span>

// Lowercase
<span className="lowercase">lowercase text</span>

// Capitalize
<span className="capitalize">capitalized text</span>
```

### Alignment

```tsx
// Left (default)
<p className="text-left">...</p>

// Center
<p className="text-center">...</p>

// Right
<p className="text-right">...</p>

// Justified
<p className="text-justify">...</p>
```

## Truncation and Overflow

```tsx
// Truncate with ellipsis
<p className="truncate">Very long text that will be truncated...</p>

// Break words
<p className="break-words">Text that breaks long words</p>

// Break all
<p className="break-all">Text that breaks anywhere</p>
```

## Antialiasing

The application uses antialiasing to improve font rendering:

```css
body {
  font-smoothing: antialiased;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

## Font Features

Advanced typographic features are enabled:

```css
body {
  font-feature-settings: "rlig" 1, "calt" 1;
}
```

- `rlig`: Required ligatures
- `calt`: Contextual alternates

## Text Colors

### Primary Colors

```tsx
// Primary text (Shema Black)
<p className="text-preto">Primary text</p>

// Secondary text (Shema Dark Green)
<p className="text-verde">Secondary text</p>

// Muted text
<p className="text-verde/60">Muted text</p>

// Text on primary button
<button className="text-white">Button</button>
```

### Semantic Colors

```tsx
// Success
<p className="text-verde-claro">Success text</p>

// Error
<p className="text-red-600">Error text</p>

// Warning
<p className="text-yellow-600">Warning text</p>

// Info
<p className="text-azul">Informative text</p>
```

## Component Examples

### CardTitle (Montserrat)

```tsx
<CardTitle className="text-xl font-semibold leading-none tracking-tight text-preto">
  Card Title
</CardTitle>
```

### CardDescription (Montserrat)

```tsx
<CardDescription className="text-sm text-verde">
  Card description
</CardDescription>
```

### Page Header (Montserrat)

```tsx
<div className="text-2xl font-bold text-preto flex items-center gap-2">
  <Icon className="w-5 h-5 text-telha" />
  Page Title
</div>
<p className="text-verde mt-1">Subtitle or description</p>
```

### Reading Content (Merriweather)

```tsx
<div className="prose prose-lg">
  <p className="font-serif text-base leading-relaxed text-preto">
    This is an example of long text for continuous reading. 
    The Merriweather font is optimized for on-screen reading and 
    provides a comfortable experience even with extensive texts.
  </p>
</div>
```

## DS-5. Espaçamento

## Overview

The application uses the Tailwind CSS spacing system, based on a 4px (0.25rem) scale.

## Base Unit

The spacing system uses a **4px base unit** (Tailwind default).

## Spacing Scale

| Class | Value | Pixels | Usage |
|---------|-------|--------|-----|
| `0` | 0 | 0px | No spacing |
| `0.5` | 0.125rem | 2px | Minimum spacing |
| `1` | 0.25rem | 4px | Very small spacing |
| `1.5` | 0.375rem | 6px | Small spacing |
| `2` | 0.5rem | 8px | Small spacing |
| `2.5` | 0.625rem | 10px | Small-medium spacing |
| `3` | 0.75rem | 12px | Medium spacing |
| `4` | 1rem | 16px | Default spacing |
| `5` | 1.25rem | 20px | Medium-large spacing |
| `6` | 1.5rem | 24px | Large spacing |
| `8` | 2rem | 32px | Very large spacing |
| `10` | 2.5rem | 40px | Extra large spacing |
| `12` | 3rem | 48px | Maximum common spacing |

### Semantic Spacing Values

```json
{
  "base": 4,
  "scale": {
    "xs": { "value": "4px", "flutter": 4 },
    "sm": { "value": "8px", "flutter": 8 },
    "md": { "value": "16px", "flutter": 16 },
    "lg": { "value": "24px", "flutter": 24 },
    "xl": { "value": "32px", "flutter": 32 },
    "xxl": { "value": "48px", "flutter": 48 }
  }
}
```

## Padding

### Card Padding

```tsx
// Default card
<Card className="p-6">...</Card>

// Card header
<CardHeader className="p-6">...</CardHeader>

// Card content
<CardContent className="p-6 pt-0">...</CardContent>

// Card footer
<CardFooter className="p-6 pt-0">...</CardFooter>
```

**Minimum**: 16px (mobile), **Recommended**: 24px (desktop)

### Button Padding

```tsx
// Default button
<Button className="px-4 py-2">...</Button>

// Small button
<Button size="sm" className="px-3">...</Button>

// Large button
<Button size="lg" className="px-8">...</Button>

// Icon button
<Button size="icon" className="w-10 h-10">...</Button>
```

### Input Padding

```tsx
<Input className="px-3 py-2">...</Input>
```

### Badge Padding

```tsx
<Badge className="px-2.5 py-0.5">...</Badge>
```

### Responsive Padding

```tsx
// Mobile: p-4, Desktop: p-6
<div className="p-4 md:p-6">...</div>

// Mobile: px-3, Desktop: px-6
<div className="px-3 md:px-6">...</div>
```

## Margin

### Vertical Spacing (space-y)

```tsx
// Default spacing between elements
<div className="space-y-4">...</div>

// Small spacing
<div className="space-y-2">...</div>

// Large spacing
<div className="space-y-6">...</div>

// Very large spacing
<div className="space-y-8">...</div>
```

**Recommended**: `space-y-6` or `space-y-8` for vertical rhythm.

### Horizontal Spacing (space-x)

```tsx
// Default horizontal spacing
<div className="flex space-x-2">...</div>

// Large horizontal spacing
<div className="flex space-x-4">...</div>
```

### Individual Margin

```tsx
// Top
<div className="mt-4">...</div>

// Bottom
<div className="mb-4">...</div>

// Left
<div className="ml-4">...</div>

// Right
<div className="mr-4">...</div>

// All sides
<div className="m-4">...</div>
```

### Negative Margin

```tsx
// Element overlap
<div className="-mt-4">...</div>
```

## Gap (Flexbox/Grid)

### Gap in Flex

```tsx
// Default gap
<div className="flex gap-2">...</div>

// Medium gap
<div className="flex gap-4">...</div>

// Large gap
<div className="flex gap-6">...</div>
```

### Gap in Grid

```tsx
// Grid with gap
<div className="grid grid-cols-2 gap-4">...</div>

// Responsive grid
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">...</div>
```

## Layout Patterns

### Container

```tsx
// Container with padding
<div className="container mx-auto p-6">...</div>

// Responsive container padding
<div className="container mx-auto p-4 md:p-6">...</div>
```

**Max width**: 1200px (from tokens/spacing.json)

### Page Layout

```tsx
// Default page
<div className="container mx-auto p-6 space-y-8">...</div>

// Page with smaller spacing
<div className="container mx-auto p-6 space-y-6">...</div>
```

### Card Layout

```tsx
// Card with internal spacing
<Card className="p-6">
  <div className="space-y-4">...</div>
</Card>
```

### Form Layout

```tsx
// Form group
<div className="space-y-2">
  <label>...</label>
  <Input />
  <span className="text-xs">Hint</span>
</div>

// Form with multiple groups
<form className="space-y-4">
  <div className="space-y-2">...</div>
  <div className="space-y-2">...</div>
</form>
```

### Modal Layout

```tsx
<Dialog>
  <DialogHeader className="space-y-1.5">...</DialogHeader>
  <DialogContent className="p-6">
    <div className="space-y-4">...</div>
  </DialogContent>
  <DialogFooter className="pt-4">
    <div className="flex gap-2">...</div>
  </DialogFooter>
</Dialog>
```

## Grids

### 2-Column Grid

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 gap-4">...</div>
```

### 3-Column Grid

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">...</div>
```

### 4-Column Grid

```tsx
<div className="grid grid-cols-2 md:grid-cols-4 gap-4">...</div>
```

## Component-Specific Spacing

### Stage Cards

```tsx
<div className="stage-card p-6">
  <div className="space-y-6">...</div>
</div>
```

### Clause Cards

```tsx
<div className="clause-card p-4">
  <div className="space-y-2">...</div>
</div>
```

### Event Cards

```tsx
<div className="event-card p-4">
  <div className="space-y-3">...</div>
</div>
```

### Participant Cards

```tsx
<div className="participant-card p-4">
  <div className="space-y-2">...</div>
</div>
```

## Icon Spacing

### Icons with Text

```tsx
// Icon on the left
<div className="flex items-center gap-2">
  <Icon className="w-4 h-4" />
  <span>Text</span>
</div>

// Icon on the right
<div className="flex items-center gap-2">
  <span>Text</span>
  <Icon className="w-4 h-4" />
</div>
```

### Icons in Titles

```tsx
<h1 className="flex items-center gap-2">
  <Icon className="w-5 h-5" />
  Title
</h1>
```

## Responsive Spacing

### Breakpoints

```tsx
// Mobile first
<div className="p-4 md:p-6 lg:p-8">...</div>

// Conditional spacing
<div className="space-y-4 md:space-y-6">...</div>

// Responsive gap
<div className="grid gap-2 md:gap-4 lg:gap-6">...</div>
```

## Spacing Patterns by Context

### Empty States

```tsx
<div className="py-12 text-center">...</div>
```

### Loading States

```tsx
<div className="flex items-center justify-center py-12">...</div>
```

### Error States

```tsx
<div className="p-8 text-center">...</div>
```

### Section Headers

```tsx
<div className="flex items-start justify-between mb-4">...</div>
```

## Generous Breathing Room

The design system emphasizes **generous breathing room**:

- Use the 4px base spacing scale consistently
- Card padding: 16px minimum (mobile), 24px recommended (desktop)
- Section gaps: `space-y-6` or `space-y-8` for vertical rhythm
- Grid systems: Responsive grids that adapt from single column (mobile) to multi-column (desktop)


## DS-6. Animações e Transições

## Animation System

The application uses smooth animations and consistent transitions to improve user experience.

## Keyframes

### Fade In

Fade in animation with vertical movement.

```css
@keyframes fade-in {
  0% {
    opacity: 0;
    transform: translateY(10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'fade-in': {
    '0%': { opacity: '0', transform: 'translateY(10px)' },
    '100%': { opacity: '1', transform: 'translateY(0)' },
  },
}
```

#### Usage

```tsx
<div className="animate-fade-in">...</div>
```

### Slide In

Slide in animation from the left.

```css
@keyframes slide-in {
  0% {
    opacity: 0;
    transform: translateX(-10px);
  }
  100% {
    opacity: 1;
    transform: translateX(0);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'slide-in': {
    '0%': { opacity: '0', transform: 'translateX(-10px)' },
    '100%': { opacity: '1', transform: 'translateX(0)' },
  },
}
```

#### Usage

```tsx
<div className="animate-slide-in">...</div>
```

### Pulse Soft

Soft pulse animation.

```css
@keyframes pulse-soft {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'pulse-soft': {
    '0%, 100%': { opacity: '1' },
    '50%': { opacity: '0.7' },
  },
}
```

#### Usage

```tsx
<div className="animate-pulse-soft">...</div>
```

### Bounce Subtle

Subtle bounce animation.

```css
@keyframes bounce-subtle {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-3px);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'bounce-subtle': {
    '0%, 100%': { transform: 'translateY(0)' },
    '50%': { transform: 'translateY(-3px)' },
  },
}
```

#### Usage

```tsx
<div className="animate-bounce-subtle">...</div>
```

### Celebrate

Celebration animation (scale).

```css
@keyframes celebrate {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'celebrate': {
    '0%': { transform: 'scale(1)' },
    '50%': { transform: 'scale(1.1)' },
    '100%': { transform: 'scale(1)' },
  },
}
```

#### Usage

```tsx
<div className="animate-celebrate">...</div>
```

## Configured Animations

### Fade In

```javascript
animation: {
  'fade-in': 'fade-in 0.3s ease-out',
}
```

#### Usage

```tsx
<div className="animate-fade-in">...</div>
```

### Slide In

```javascript
animation: {
  'slide-in': 'slide-in 0.3s ease-out',
}
```

#### Usage

```tsx
<div className="animate-slide-in">...</div>
```

### Pulse Soft

```javascript
animation: {
  'pulse-soft': 'pulse-soft 2s ease-in-out infinite',
}
```

#### Usage

```tsx
<div className="animate-pulse-soft">...</div>
```

### Bounce Subtle

```javascript
animation: {
  'bounce-subtle': 'bounce-subtle 0.5s ease-in-out',
}
```

#### Usage

```tsx
<div className="animate-bounce-subtle">...</div>
```

### Celebrate

```javascript
animation: {
  'celebrate': 'celebrate 0.4s ease-in-out',
}
```

#### Usage

```tsx
<div className="animate-celebrate">...</div>
```

## Transitions

### Default Duration

The application uses a default duration of **200ms** for most transitions.

### Hover Transitions

```tsx
// Card with hover
<div className="transition-all duration-200 hover:shadow-md hover:border-telha/30">
  ...
</div>

// Button with hover
<button className="transition-all duration-200 hover:bg-telha-dark">
  ...
</button>
```

### State Transitions

```tsx
// Element with color transition
<div className="transition-colors duration-200 hover:bg-areia/20">
  ...
</div>

// Element with scale transition
<button className="transition-transform duration-200 active:scale-[0.98]">
  ...
</button>
```

### Opacity Transitions

```tsx
// Element with fade
<div className="transition-opacity duration-200 hover:opacity-80">
  ...
</div>
```

## Loading Animations

### Spinner

```tsx
<div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
```

### Small Spinner

```tsx
<div className="animate-spin w-4 h-4 border-2 border-telha border-t-transparent rounded-full" />
```

### Spinner with Text

```tsx
<div className="flex items-center gap-2">
  <div className="animate-spin w-4 h-4 border-2 border-telha border-t-transparent rounded-full" />
  <span>Loading...</span>
</div>
```

## Entrance Animations

### Fade In in List

```tsx
{items.map((item, index) => (
  <div 
    key={item.id}
    className="animate-fade-in"
    style={{ animationDelay: `${index * 0.1}s` }}
  >
    ...
  </div>
))}
```

### Slide In in Modal

```tsx
<Dialog>
  <DialogContent className="animate-slide-in">
    ...
  </DialogContent>
</Dialog>
```

## Interaction Animations

### Button with Scale

```tsx
<Button className="active:scale-[0.98]">
  Button
</Button>
```

### Card with Hover

```tsx
<Card className="transition-all duration-200 hover:shadow-md hover:border-telha/30">
  ...
</Card>
```

### Badge with Pulse

```tsx
<Badge className="animate-pulse-soft">
  New
</Badge>
```

## Validation Animations

### Celebration on Validation

```tsx
{isValidated && (
  <div className="animate-celebrate">
    <CheckCircle2 className="w-5 h-5 text-verde-claro" />
  </div>
)}
```

### Bounce on Completion

```tsx
{isCompleted && (
  <div className="animate-bounce-subtle">
    <CheckCircle2 className="w-5 h-5 text-verde-claro" />
  </div>
)}
```

## Custom CSS Classes

### Animate In

```css
.animate-in {
  animation: fade-in 0.3s ease-out;
}
```

#### Usage

```tsx
<div className="animate-in">...</div>
```

### Slide In Left

```css
.slide-in-left {
  animation: slide-in 0.3s ease-out;
}
```

#### Usage

```tsx
<div className="slide-in-left">...</div>
```

## Performance

### Optimizations

- Use `transform` and `opacity` for animations (GPU-accelerated)
- Avoid animating `width`, `height`, `top`, `left` (causes reflow)
- Use `will-change` carefully (only when necessary)

### Optimized Example

```tsx
// ✅ Good - uses transform
<div className="transition-transform duration-200 hover:scale-105">
  ...
</div>

// ❌ Avoid - animates width
<div className="transition-all duration-200 hover:w-full">
  ...
</div>
```

## User Preferences

### Reduce Motion

Respect the user preference for reduced animations:

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## DS-7. Componentes UI

## Component System

The application uses base components built with Radix UI, Tailwind CSS, and class-variance-authority (cva).

## Component Structure

All components follow this pattern:

```tsx
import * as React from "react"
import { cn } from "@/utils/cn"
import { cva, type VariantProps } from "class-variance-authority"

// Variants using cva
const componentVariants = cva(
  "base-classes",
  {
    variants: {
      variant: { ... },
      size: { ... },
    },
    defaultVariants: { ... }
  }
)

// Props interface
export interface ComponentProps
  extends React.HTMLAttributes<HTMLElement>,
    VariantProps<typeof componentVariants> {
  // additional props
}

// Component
const Component = React.forwardRef<HTMLElement, ComponentProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <element
        ref={ref}
        className={cn(componentVariants({ variant, size, className }))}
        {...props}
      />
    )
  }
)

Component.displayName = "Component"

export { Component, componentVariants }
```

## Progress Step

Component for displaying step progress in a process or flow. Supports horizontal (desktop) and vertical (mobile) layouts.

### States

- **completed**: Completed step (light green with checkmark)
- **current**: Current step (telha with number and pulse animation)
- **pending**: Pending step (areia/30 with number)

### Base Styles

#### Progress Step Container

```typescript
ProgressStepContainer: "bg-white rounded-xl border border-areia/30 shadow-sm p-6 md:p-8"
ProgressStepTitle: "text-xl font-semibold text-preto mb-6 flex items-center gap-2"
```

#### Step Circle (Step Icon)

**Mobile (w-10 h-10):**
```typescript
// Completed
"w-10 h-10 rounded-full bg-verde-claro flex items-center justify-center text-white"

// Current
"w-10 h-10 rounded-full bg-telha flex items-center justify-center text-white font-semibold animate-pulse"

// Pending
"w-10 h-10 rounded-full bg-areia/30 flex items-center justify-center text-verde font-semibold"
```

**Desktop (w-12 h-12):**
```typescript
// Completed
"w-12 h-12 rounded-full bg-verde-claro flex items-center justify-center text-white mb-3"

// Current
"w-12 h-12 rounded-full bg-telha flex items-center justify-center text-white font-semibold mb-3 animate-pulse"

// Pending
"w-12 h-12 rounded-full bg-areia/30 flex items-center justify-center text-verde font-semibold mb-3"
```

#### Connectors (Lines between steps)

**Mobile (vertical):**
```typescript
// Completed connector
"w-0.5 h-12 bg-verde-claro mt-2"

// Pending connector
"w-0.5 h-12 bg-areia/50 mt-2"
```

**Desktop (horizontal):**
```typescript
// Completed connector
"flex-1 h-1 bg-verde-claro mx-2 -mt-8"

// Pending connector
"flex-1 h-1 bg-areia/50 mx-2 -mt-8"
```

#### Step Texts

**Mobile:**
```typescript
StepTitle: "font-semibold text-preto"
StepTitlePending: "font-semibold text-verde/60"
StepStatus: "text-sm text-verde mt-1"
StepStatusCurrent: "text-sm text-telha mt-1"
StepStatusPending: "text-sm text-verde/50 mt-1"
```

**Desktop:**
```typescript
StepTitle: "font-semibold text-preto text-center"
StepTitlePending: "font-semibold text-verde/60 text-center"
StepStatus: "text-sm text-verde mt-1 text-center"
StepStatusCurrent: "text-sm text-telha mt-1 text-center"
StepStatusPending: "text-sm text-verde/50 mt-1 text-center"
```

### Layout Mobile (Vertical)

```tsx
<div className="flex flex-col md:hidden space-y-4">
  {steps.map((step, index) => (
    <div key={index} className="flex items-start gap-4">
      <div className="flex flex-col items-center">
        <div className={stepCircleClasses[step.status]}>
          {step.status === 'completed' ? (
            <CheckIcon className="w-5 h-5" />
          ) : (
            <span>{step.number}</span>
          )}
        </div>
        {index < steps.length - 1 && (
          <div className={connectorClasses[step.status]} />
        )}
      </div>
      <div className="flex-1 pt-2">
        <p className={stepTitleClasses[step.status]}>
          {step.title}
        </p>
        <p className={stepStatusClasses[step.status]}>
          {step.statusText}
        </p>
      </div>
    </div>
  ))}
</div>
```

### Layout Desktop (Horizontal)

```tsx
<div className="hidden md:flex items-center justify-between">
  {steps.map((step, index) => (
    <>
      <div key={index} className="flex flex-col items-center flex-1">
        <div className={stepCircleClasses[step.status]}>
          {step.status === 'completed' ? (
            <CheckIcon className="w-6 h-6" />
          ) : (
            <span>{step.number}</span>
          )}
        </div>
        <p className={stepTitleClasses[step.status]}>
          {step.title}
        </p>
        <p className={stepStatusClasses[step.status]}>
          {step.statusText}
        </p>
      </div>
      {index < steps.length - 1 && (
        <div className={connectorClasses[step.status]} />
      )}
    </>
  ))}
</div>
```

### Spacing

- **Container padding**: `p-6 md:p-8` (24px mobile, 32px desktop)
- **Gap between steps (mobile)**: `space-y-4` (16px vertical)
- **Gap between step and content (mobile)**: `gap-4` (16px horizontal)
- **Title margin bottom**: `mb-6` (24px)
- **Status margin top**: `mt-1` (4px)
- **Content padding top (mobile)**: `pt-2` (8px)
- **Circle margin bottom (desktop)**: `mb-3` (12px)
- **Connector horizontal margin (desktop)**: `mx-2` (8px)
- **Connector negative top margin (desktop)**: `-mt-8` (-32px to align with circle)

### Full Usage

```tsx
<section className="bg-white rounded-xl border border-areia/30 shadow-sm p-6 md:p-8">
  <h2 className="text-xl font-semibold text-preto mb-6 flex items-center gap-2">
    <ListChecksIcon className="w-5 h-5 text-telha" />
    Project Progress
  </h2>
  
  <div className="relative">
    {/* Mobile Layout */}
    <div className="flex flex-col md:hidden space-y-4">
      {/* Steps here */}
    </div>
    
    {/* Desktop Layout */}
    <div className="hidden md:flex items-center justify-between">
      {/* Steps here */}
    </div>
  </div>
</section>
```

## Button

### Variants

```typescript
variant: {
  default: "bg-telha text-white hover:bg-telha-dark shadow-md hover:shadow-lg",
  secondary: "bg-azul text-white hover:bg-azul/90",
  outline: "border-2 border-areia bg-transparent hover:bg-areia/20 text-preto",
  ghost: "hover:bg-areia/20 text-preto",
  success: "bg-verde-claro text-white hover:bg-verde",
  destructive: "bg-red-500 text-white hover:bg-red-600",
  link: "text-telha underline-offset-4 hover:underline",
}
```

### Sizes

```typescript
size: {
  default: "h-10 px-4 py-2",
  sm: "h-9 rounded-md px-3",
  lg: "h-12 rounded-lg px-8 text-base",
  icon: "h-10 w-10",
}
```

### Usage

```tsx
import { Button } from '@/components/ui/button'

// Default button
<Button>Click here</Button>

// Secondary button
<Button variant="secondary">Secondary</Button>

// Outline button
<Button variant="outline">Outline</Button>

// Ghost button
<Button variant="ghost">Ghost</Button>

// Success button
<Button variant="success">Success</Button>

// Destructive button
<Button variant="destructive">Delete</Button>

// Link button
<Button variant="link">Link</Button>

// Sizes
<Button size="sm">Small</Button>
<Button size="default">Default</Button>
<Button size="lg">Large</Button>
<Button size="icon"><Icon /></Button>

// With icon
<Button>
  <Icon className="w-4 h-4 mr-2" />
  Text
</Button>
```

## Card

### Structure

```tsx
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card'

<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
    <CardDescription>Description</CardDescription>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
  <CardFooter>
    Footer
  </CardFooter>
</Card>
```

### Styles

```typescript
Card: "rounded-xl border border-areia/30 bg-white shadow-sm transition-all duration-200 hover:shadow-md"
CardHeader: "flex flex-col space-y-1.5 p-6"
CardTitle: "text-xl font-semibold leading-none tracking-tight text-preto"
CardDescription: "text-sm text-verde"
CardContent: "p-6 pt-0"
CardFooter: "flex items-center p-6 pt-0"
```

### Usage

```tsx
<Card>
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card description</CardDescription>
  </CardHeader>
  <CardContent>
    <p>Card content</p>
  </CardContent>
  <CardFooter>
    <Button>Action</Button>
  </CardFooter>
</Card>
```

## Input

### Styles

```typescript
Input: "flex h-10 w-full rounded-lg border border-areia bg-white px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-verde/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-telha focus-visible:ring-offset-2 focus-visible:border-telha disabled:cursor-not-allowed disabled:opacity-50 transition-all duration-200"
```

### Usage

```tsx
import { Input } from '@/components/ui/input'

<Input type="text" placeholder="Type here..." />

<Input type="email" placeholder="email@example.com" />

<Input type="password" placeholder="Password" />

<Input disabled placeholder="Disabled" />
```

## Textarea

### Styles

Similar to Input, but with adjustable height.

### Usage

```tsx
import { Textarea } from '@/components/ui/textarea'

<Textarea placeholder="Type your message..." />

<Textarea rows={5} placeholder="Long text..." />
```

## Badge

See complete documentation in [Badges](./badges.md).

### Basic Usage

```tsx
import { Badge } from '@/components/ui/badge'

<Badge variant="default">Badge</Badge>
<Badge variant="success">Success</Badge>
<Badge variant="warning">Warning</Badge>
```

## Select / Dropdown

### Select Styles

```typescript
SelectContainer: "relative"
SelectTrigger: "w-full h-10 px-3 pr-8 rounded-lg border border-areia bg-white text-sm appearance-none focus:outline-none focus:ring-2 focus:ring-telha focus:border-telha transition-all duration-200"
SelectIcon: "w-4 h-4 absolute right-3 top-1/2 transform -translate-y-1/2 text-verde/50 pointer-events-none"
```

### Label with Default Spacing

```typescript
Label: "text-sm font-medium text-preto block mb-2"
```

The default spacing between label and input/select is **`mb-2`** (8px).

### Usage with Label

```tsx
<div className="w-full md:w-48">
  <label className="text-sm font-medium text-preto block mb-2">
    Period
  </label>
  <div className="relative">
    <select className="w-full h-10 px-3 pr-8 rounded-lg border border-areia bg-white text-sm appearance-none focus:outline-none focus:ring-2 focus:ring-telha focus:border-telha transition-all duration-200">
      <option>Last 7 days</option>
      <option>Last 30 days</option>
      <option>Last 90 days</option>
    </select>
    <ChevronDownIcon className="w-4 h-4 absolute right-3 top-1/2 transform -translate-y-1/2 text-verde/50 pointer-events-none" />
  </div>
</div>
```

### Usage with Radix UI Select

```tsx
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

<div className="space-y-2">
  <label className="text-sm font-medium text-preto block mb-2">
    Select an option
  </label>
  <Select>
    <SelectTrigger className="w-full h-10">
      <SelectValue placeholder="Select..." />
    </SelectTrigger>
    <SelectContent>
      <SelectItem value="option1">Option 1</SelectItem>
      <SelectItem value="option2">Option 2</SelectItem>
      <SelectItem value="option3">Option 3</SelectItem>
    </SelectContent>
  </Select>
</div>
```

### Sizes and Spacing

- **Select height**: `h-10` (40px)
- **Horizontal padding**: `px-3` (12px)
- **Right padding (for icon)**: `pr-8` (32px)
- **Label → select spacing**: `mb-2` (8px)
- **Chevron icon**: `w-4 h-4` (16px)
- **Icon position**: `right-3` (12px from right)

## Dialog

### Usage

```tsx
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'

<Dialog>
  <DialogTrigger asChild>
    <Button>Open Dialog</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Dialog Title</DialogTitle>
      <DialogDescription>
        Dialog description
      </DialogDescription>
    </DialogHeader>
    <div>
      Dialog content
    </div>
    <DialogFooter>
      <Button variant="outline">Cancel</Button>
      <Button>Confirm</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

## Alert Dialog

### Usage

```tsx
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from '@/components/ui/alert-dialog'

<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Delete</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Confirm deletion</AlertDialogTitle>
      <AlertDialogDescription>
        This action cannot be undone.
      </AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Cancel</AlertDialogCancel>
      <AlertDialogAction>Confirm</AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>
```

## Sheet

### Usage

```tsx
import { Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle, SheetTrigger } from '@/components/ui/sheet'

<Sheet>
  <SheetTrigger asChild>
    <Button>Open Sheet</Button>
  </SheetTrigger>
  <SheetContent>
    <SheetHeader>
      <SheetTitle>Title</SheetTitle>
      <SheetDescription>
        Description
      </SheetDescription>
    </SheetHeader>
    <div>
      Content
    </div>
  </SheetContent>
</Sheet>
```

## Progress

### Usage

```tsx
import { Progress } from '@/components/ui/progress'

<Progress value={33} />

<Progress value={66} className="h-2" />
```

## Usage Patterns

### Complete Form

```tsx
<Card>
  <CardHeader>
    <CardTitle>Form</CardTitle>
    <CardDescription>Fill in the fields below</CardDescription>
  </CardHeader>
  <CardContent>
    <form className="space-y-4">
      <div className="space-y-2">
        <label className="text-sm font-medium">Name</label>
        <Input placeholder="Enter your name" />
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium">Email</label>
        <Input type="email" placeholder="email@example.com" />
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium">Message</label>
        <Textarea placeholder="Type your message..." />
      </div>
    </form>
  </CardContent>
  <CardFooter>
    <Button variant="outline">Cancel</Button>
    <Button>Send</Button>
  </CardFooter>
</Card>
```

### List with Actions

```tsx
<Card>
  <CardHeader>
    <div className="flex items-center justify-between">
      <CardTitle>Items</CardTitle>
      <Button size="sm">
        <Plus className="w-4 h-4 mr-2" />
        Add
      </Button>
    </div>
  </CardHeader>
  <CardContent>
    <div className="space-y-2">
      {items.map(item => (
        <div key={item.id} className="flex items-center justify-between p-2 border rounded">
          <span>{item.name}</span>
          <div className="flex items-center gap-2">
            <Button variant="ghost" size="icon">
              <Edit className="w-4 h-4" />
            </Button>
            <Button variant="ghost" size="icon">
              <Trash className="w-4 h-4" />
            </Button>
          </div>
        </div>
      ))}
    </div>
  </CardContent>
</Card>
```

## DS-8. Cards

## Card System

The application uses a consistent card system with different variants and styles.

## Card Base

### Card Component

The base `Card` component provides the default structure:

```tsx
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card'

<Card>
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card description</CardDescription>
  </CardHeader>
  <CardContent>
    Card content
  </CardContent>
  <CardFooter>
    Card actions
  </CardFooter>
</Card>
```

### Base Styles

```typescript
Card: "rounded-xl border border-areia/30 bg-white shadow-sm transition-all duration-200 hover:shadow-md"

CardHeader: "flex flex-col space-y-1.5 p-6"
CardTitle: "text-xl font-semibold leading-none tracking-tight text-preto"
CardDescription: "text-sm text-verde"
CardContent: "p-6 pt-0"
CardFooter: "flex items-center p-6 pt-0"
```

### Border

All cards **must** include a visible border for visual separation:

```css
border: 1.5px solid var(--border-color);
```

> **Note:** This applies to every card variant (default, clause, event, participant, etc.). The `--border-color` CSS variable adapts automatically between light and dark themes.

## Centralized Styles

### Card Styles

```typescript
export const cardStyles = {
  base: 'bg-white rounded-lg border border-areia/30 shadow-sm',
  hover: 'transition-all duration-200 hover:shadow-md hover:border-telha/30',
  dashed: 'border-dashed',
  selected: 'ring-2 ring-telha/50 border-telha',
}
```

### Usage

```tsx
import { cardStyles } from '@/styles'
import { cn } from '@/utils/cn'

<div className={cn(cardStyles.base, cardStyles.hover)}>
  ...
</div>
```

## Card Variants

### 1. Default Card

```tsx
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
    <CardDescription>Description</CardDescription>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
</Card>
```

### 2. Card with Hover

```tsx
<div className={cn(cardStyles.base, cardStyles.hover)}>
  ...
</div>
```

### 3. Selected Card

```tsx
<div className={cn(
  cardStyles.base,
  isSelected && cardStyles.selected
)}>
  ...
</div>
```

### 4. Card with Dashed Border

```tsx
<div className={cn(cardStyles.base, cardStyles.dashed)}>
  ...
</div>
```

## Specific Cards

### Stage Card

Card used in application stages:

```tsx
<div className="stage-card">
  {/* bg-white rounded-lg shadow-md border border-areia/30 p-6 */}
  ...
</div>
```

### Clause Card

Card for displaying clauses:

```typescript
export const clauseCardStyles = {
  base: 'bg-white rounded-lg border border-areia/30 p-4 transition-all duration-200 hover:shadow-md hover:border-telha/30',
  mainline: 'border-l-4 border-l-telha',
  background: 'border-l-4 border-l-azul',
}
```

#### Usage

```tsx
import { clauseCardStyles } from '@/styles'

// Default clause card
<div className={clauseCardStyles.base}>
  ...
</div>

// Mainline clause card
<div className={cn(clauseCardStyles.base, clauseCardStyles.mainline)}>
  ...
</div>

// Background clause card
<div className={cn(clauseCardStyles.base, clauseCardStyles.background)}>
  ...
</div>
```

### Event Card

Card for displaying events:

```typescript
export const eventCardStyles = {
  base: 'bg-white rounded-lg border border-areia/30 p-4',
  validated: 'border-verde-claro/50 bg-verde-claro/5',
  error: 'border-red-300 bg-red-50',
}
```

#### Usage

```tsx
import { eventCardStyles } from '@/styles'

// Default event card
<div className={eventCardStyles.base}>
  ...
</div>

// Validated event card
<div className={cn(eventCardStyles.base, eventCardStyles.validated)}>
  ...
</div>

// Event card with error
<div className={cn(eventCardStyles.base, eventCardStyles.error)}>
  ...
</div>
```

### Participant Card

Card for displaying participants:

```typescript
export const participantCardStyles = {
  base: 'bg-white rounded-lg border border-areia/30 p-4 transition-all duration-200',
  validated: 'border-verde-claro/50 bg-verde-claro/5',
  hover: 'hover:shadow-md hover:border-telha/30',
}
```

#### Usage

```tsx
import { participantCardStyles } from '@/styles'

// Default participant card
<div className={cn(participantCardStyles.base, participantCardStyles.hover)}>
  ...
</div>

// Validated participant card
<div className={cn(
  participantCardStyles.base,
  participantCardStyles.validated
)}>
  ...
</div>
```

## Card States

### Card with Loading

```tsx
<Card>
  <CardContent className="py-12">
    <div className="flex items-center justify-center">
      <div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
    </div>
  </CardContent>
</Card>
```

### Card with Error

```tsx
<Card>
  <CardContent className="py-8 text-center">
    <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg">
      Error loading
    </div>
  </CardContent>
</Card>
```

### Empty Card

```tsx
<Card>
  <CardContent className="py-12 text-center text-verde/60">
    <Icon className="w-12 h-12 mx-auto mb-4 opacity-30" />
    <p className="text-sm">No items found</p>
  </CardContent>
</Card>
```

## Interactive Cards

### Clickable Card

```tsx
<button
  className={cn(
    cardStyles.base,
    cardStyles.hover,
    "cursor-pointer text-left w-full"
  )}
  onClick={handleClick}
>
  ...
</button>
```

### Expandable Card

```tsx
const [isExpanded, setIsExpanded] = useState(false)

<Card>
  <CardHeader>
    <button
      onClick={() => setIsExpanded(!isExpanded)}
      className="flex items-center justify-between w-full"
    >
      <CardTitle>Title</CardTitle>
      {isExpanded ? <ChevronUp /> : <ChevronDown />}
    </button>
  </CardHeader>
  {isExpanded && (
    <CardContent>
      Expanded content
    </CardContent>
  )}
</Card>
```

## Cards in Grid

### Card Grid

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  {items.map(item => (
    <Card key={item.id}>
      ...
    </Card>
  ))}
</div>
```

### 2-Column Grid

```tsx
<div className="grid grid-cols-1 md:grid-cols-2 gap-4">
  <Card>...</Card>
  <Card>...</Card>
</div>
```

### 4-Column Grid

```tsx
<div className="grid grid-cols-2 md:grid-cols-4 gap-4">
  <Card>...</Card>
  <Card>...</Card>
  <Card>...</Card>
  <Card>...</Card>
</div>
```

## Cards with Icons

### Card with Icon in Title

```tsx
<Card>
  <CardHeader>
    <CardTitle className="flex items-center gap-2">
      <Icon className="w-5 h-5 text-telha" />
      Card Title
    </CardTitle>
  </CardHeader>
  <CardContent>
    ...
  </CardContent>
</Card>
```

### Card with Status Icon

```tsx
<Card>
  <CardHeader>
    <div className="flex items-center justify-between">
      <CardTitle>Title</CardTitle>
      <div className="flex items-center gap-2">
        {isValidated && (
          <CheckCircle2 className="w-5 h-5 text-verde-claro" />
        )}
      </div>
    </div>
  </CardHeader>
  ...
</Card>
```

## Cards with Actions

### Card with Buttons

```tsx
<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
  <CardFooter className="flex justify-end gap-2">
    <Button variant="outline">Cancel</Button>
    <Button>Confirm</Button>
  </CardFooter>
</Card>
```

### Card with Actions in Header

```tsx
<Card>
  <CardHeader>
    <div className="flex items-center justify-between">
      <div>
        <CardTitle>Title</CardTitle>
        <CardDescription>Description</CardDescription>
      </div>
      <Button variant="ghost" size="icon">
        <MoreVertical />
      </Button>
    </div>
  </CardHeader>
  ...
</Card>
```

## Responsive Cards

### Adaptive Card

```tsx
<Card className="w-full">
  <CardHeader className="p-4 md:p-6">
    ...
  </CardHeader>
  <CardContent className="p-4 md:p-6 pt-0">
    ...
  </CardContent>
</Card>
```

## DS-9. Badges

## Badge System

The application uses badges to categorize and identify different types of elements, especially participants, events, and discourse relations.

## Badge Base

### Badge Component

```tsx
import { Badge } from '@/components/ui/badge'

<Badge variant="default">Badge</Badge>
```

### Base Styles

```typescript
Badge: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border transition-colors"
```

## Badge Variants

### Default Variants

```typescript
const variantClasses = {
  default: 'bg-areia/30 text-preto border-areia',
  success: 'bg-verde-claro/20 text-verde-claro border-verde-claro/30',
  warning: 'bg-telha/10 text-telha border-telha/20',
  secondary: 'bg-gray-100 text-gray-800 border-gray-200',
  outline: 'bg-transparent border-gray-200 text-gray-800',
}
```

### Usage

```tsx
<Badge variant="default">Default</Badge>
<Badge variant="success">Success</Badge>
<Badge variant="warning">Warning</Badge>
<Badge variant="secondary">Secondary</Badge>
<Badge variant="outline">Outline</Badge>
```

## Badges by Category

### Participants

Specific colors for different participant categories:

```typescript
export const participantCategoryColors: Record<ParticipantCategory, string> = {
  divine: 'bg-amber-100 text-amber-800 border-amber-200',
  person: 'bg-telha/10 text-telha-dark border-telha/20',
  place: 'bg-azul/20 text-verde border-azul/30',
  time: 'bg-verde-claro/20 text-verde border-verde-claro/30',
  object: 'bg-gray-100 text-gray-800 border-gray-200',
  abstract: 'bg-areia/30 text-preto border-areia',
  group: 'bg-indigo-100 text-indigo-800 border-indigo-200',
  animal: 'bg-emerald-100 text-emerald-800 border-emerald-200',
}
```

#### Usage

```tsx
import { participantCategoryColors } from '@/styles'

<Badge 
  variant="person"
  className={participantCategoryColors[participant.category]}
>
  {participant.category}
</Badge>
```

#### Badge Variants for Participants

```tsx
<Badge variant="divine">Divine</Badge>
<Badge variant="person">Person</Badge>
<Badge variant="place">Place</Badge>
<Badge variant="time">Time</Badge>
<Badge variant="object">Object</Badge>
<Badge variant="abstract">Abstract</Badge>
<Badge variant="group">Group</Badge>
```

### Events

Colors for event categories:

```typescript
export const eventCategoryColors: Record<EventCategory, string> = {
  ACTION: 'bg-telha/10 text-telha border-telha/20',
  SPEECH: 'bg-azul/20 text-verde border-azul/30',
  MOTION: 'bg-verde-claro/20 text-verde border-verde-claro/30',
  STATE: 'bg-areia/30 text-verde border-areia',
  PROCESS: 'bg-purple-100 text-purple-800 border-purple-200',
  TRANSFER: 'bg-blue-100 text-blue-800 border-blue-200',
  INTERNAL: 'bg-pink-100 text-pink-800 border-pink-200',
  RITUAL: 'bg-amber-100 text-amber-800 border-amber-200',
  META: 'bg-gray-100 text-gray-800 border-gray-200',
}
```

#### Usage

```tsx
import { eventCategoryColors } from '@/styles'

<Badge className={eventCategoryColors[event.category]}>
  {event.category}
</Badge>
```

### Discourse

Colors for discourse relations:

```typescript
export const discourseCategoryColors: Record<DiscourseCategory, string> = {
  temporal: 'bg-blue-100 text-blue-800',
  logical: 'bg-purple-100 text-purple-800',
  rhetorical: 'bg-orange-100 text-orange-800',
  narrative: 'bg-emerald-100 text-emerald-800',
}
```

#### Usage

```tsx
import { discourseCategoryColors } from '@/styles'

<Badge className={discourseCategoryColors[relation.category]}>
  {relation.category}
</Badge>
```

## Validation Badges

### Validation States

```typescript
export const validationBadgeStyles = {
  validated: 'bg-verde-claro/20 text-verde-claro border-verde-claro/30',
  pending: 'bg-areia/30 text-verde border-areia',
  error: 'bg-red-100 text-red-800 border-red-200',
}
```

#### Usage

```tsx
import { validationBadgeStyles } from '@/styles'

<Badge className={validationBadgeStyles.validated}>
  Validated
</Badge>

<Badge className={validationBadgeStyles.pending}>
  Pending
</Badge>

<Badge className={validationBadgeStyles.error}>
  Error
</Badge>
```

## Role Badges

### Semantic Roles

```typescript
export const roleBadgeStyles = {
  agent: 'bg-amber-100 text-amber-800',
  patient: 'bg-blue-100 text-blue-800',
  experiencer: 'bg-purple-100 text-purple-800',
  instrument: 'bg-gray-100 text-gray-800',
  beneficiary: 'bg-green-100 text-green-800',
  location: 'bg-cyan-100 text-cyan-800',
  source: 'bg-orange-100 text-orange-800',
  goal: 'bg-pink-100 text-pink-800',
}
```

#### Usage

```tsx
import { roleBadgeStyles } from '@/styles'

  <Badge className={roleBadgeStyles.agent}>
    Agent
  </Badge>
```

## Badges with Icons

### Badge with Icon on Left

```tsx
<Badge variant="success" className="flex items-center gap-1">
  <CheckCircle2 className="w-3 h-3" />
  Validated
</Badge>
```

### Badge with Icon on Right

```tsx
<Badge variant="warning" className="flex items-center gap-1">
  Pending
  <Clock className="w-3 h-3" />
</Badge>
```

### Badge with Icon Only

```tsx
<Badge variant="outline" className="p-1">
  <Icon className="w-3 h-3" />
</Badge>
```

## Status Badges

### Progress Status

```tsx
<Badge variant="success">Complete</Badge>
<Badge variant="warning">In Progress</Badge>
<Badge variant="secondary">Pending</Badge>
```

### Approval Status

```tsx
{user.role === 'admin' && (
  <Badge variant="default" className="text-xs">
    Admin
  </Badge>
)}
```

## Interactive Badges

### Clickable Badge

```tsx
<button
  className={cn(
    "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium border transition-colors",
    "cursor-pointer hover:opacity-80",
    participantCategoryColors[category]
  )}
  onClick={handleClick}
>
  {category}
</button>
```

### Removable Badge

```tsx
<Badge className="flex items-center gap-1">
  {label}
  <button
    onClick={onRemove}
    className="ml-1 hover:opacity-70"
  >
    <X className="w-3 h-3" />
  </button>
</Badge>
```

## Badges in Lists

### Badge List

```tsx
<div className="flex flex-wrap gap-2">
  {categories.map(category => (
    <Badge key={category} variant="default">
      {category}
    </Badge>
  ))}
</div>
```

### Badges in Grid

```tsx
<div className="grid grid-cols-2 md:grid-cols-4 gap-2">
  {items.map(item => (
    <Badge key={item.id} variant="default">
      {item.label}
    </Badge>
  ))}
</div>
```

## Custom Badges

### Badge with Custom Background

```tsx
<Badge className="bg-telha/10 text-telha border-telha/20">
  Custom
</Badge>
```

### Badge with Custom Size

```tsx
<Badge className="px-3 py-1 text-sm">
  Large Badge
</Badge>
```

## Custom CSS Classes

### Badge Classes in CSS

```css
.badge {
  @apply inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium;
}

.badge-divine {
  @apply bg-amber-100 text-amber-800 border border-amber-200;
}

.badge-place {
  @apply bg-azul/20 text-verde border border-azul/30;
}

.badge-time {
  @apply bg-verde-claro/20 text-verde border border-verde-claro/30;
}

.badge-person {
  @apply bg-telha/10 text-telha-dark border border-telha/20;
}

.badge-abstract {
  @apply bg-areia/30 text-preto border border-areia;
}

.badge-object {
  @apply bg-gray-100 text-gray-800 border border-gray-200;
}
```

## DS-10. Estados (Loading, Error, Success, etc.)

## State System

The application uses consistent visual states to communicate different conditions: loading, error, success, warning, information, and empty states.

## Available States

### Empty State

Used when there is no data to display.

```typescript
export const emptyStateStyles = {
  container: 'py-12 text-center text-verde/60',
  icon: 'w-12 h-12 mx-auto mb-4 opacity-30',
  text: 'text-sm',
}
```

#### Usage

```tsx
import { emptyStateStyles } from '@/styles'

<div className={emptyStateStyles.container}>
  <Icon className={emptyStateStyles.icon} />
  <p className={emptyStateStyles.text}>
    No items found
  </p>
</div>
```

#### Complete Example

```tsx
{items.length === 0 ? (
  <div className="py-12 text-center text-verde/60">
    <Icon className="w-12 h-12 mx-auto mb-4 opacity-30" />
    <p className="text-sm">No items found</p>
  </div>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

### Loading State

Used during asynchronous operations.

```typescript
export const loadingStateStyles = {
  container: 'flex items-center justify-center py-12',
  spinner: 'w-8 h-8 animate-spin text-telha',
  smallSpinner: 'w-4 h-4 animate-spin text-telha',
  text: 'text-verde ml-3',
}
```

#### Default Spinner

```tsx
import { loadingStateStyles } from '@/styles'

<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.spinner}>
    <div className="w-8 h-8 border-4 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
</div>
```

#### Small Spinner

```tsx
<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.smallSpinner}>
    <div className="w-4 h-4 border-2 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
</div>
```

#### Loading with Text

```tsx
<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.spinner}>
    <div className="w-8 h-8 border-4 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
  <p className={loadingStateStyles.text}>Loading...</p>
</div>
```

#### Loading in Card

```tsx
<Card>
  <CardContent className="py-12">
    <div className="flex items-center justify-center">
      <div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
    </div>
  </CardContent>
</Card>
```

### Error State

Used to display error messages.

```typescript
export const errorStateStyles = {
  banner: 'bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-red-600',
  text: 'text-sm',
}
```

#### Error Banner

```tsx
import { errorStateStyles } from '@/styles'

<div className={errorStateStyles.banner}>
  Error loading data
</div>
```

#### Error with Icon

```tsx
<div className={errorStateStyles.banner}>
  <div className="flex items-center gap-2">
    <AlertCircle className={errorStateStyles.icon} />
    <span>Error loading data</span>
  </div>
</div>
```

#### Error in Card

```tsx
<Card>
  <CardContent className="py-8 text-center">
    <div className={errorStateStyles.banner}>
      {error}
    </div>
    <div className="mt-4">
      <Button onClick={retry}>Try Again</Button>
    </div>
  </CardContent>
</Card>
```

#### Error in Form

```tsx
<div className="space-y-2">
  <Input />
  {error && (
    <p className="text-xs text-red-600">
      {error}
    </p>
  )}
</div>
```

### Success State

Used to confirm successful actions.

```typescript
export const successStateStyles = {
  banner: 'bg-verde-claro/10 border border-verde-claro/30 text-verde px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-verde-claro',
  text: 'text-sm',
}
```

#### Success Banner

```tsx
import { successStateStyles } from '@/styles'

<div className={successStateStyles.banner}>
  Operation completed successfully
</div>
```

#### Success with Icon

```tsx
<div className={successStateStyles.banner}>
  <div className="flex items-center gap-2">
    <CheckCircle2 className={successStateStyles.icon} />
    <span>Saved successfully</span>
  </div>
</div>
```

#### Success Toast

```tsx
import { toast } from 'sonner'

toast.success('Operation completed successfully', {
  description: 'The data was saved correctly'
})
```

### Warning State

Used for alerts and warnings.

```typescript
export const warningStateStyles = {
  banner: 'bg-yellow-50 border border-yellow-200 text-yellow-800 px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-yellow-600',
  text: 'text-sm',
}
```

#### Warning Banner

```tsx
import { warningStateStyles } from '@/styles'

<div className={warningStateStyles.banner}>
  Warning: This action cannot be undone
</div>
```

#### Warning with Icon

```tsx
<div className={warningStateStyles.banner}>
  <div className="flex items-center gap-2">
    <AlertTriangle className={warningStateStyles.icon} />
    <span>Warning: This action cannot be undone</span>
  </div>
</div>
```

### Info State

Used for informative messages.

```typescript
export const infoStateStyles = {
  banner: 'bg-azul/10 border border-azul/30 text-verde px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-azul',
  text: 'text-sm',
}
```

#### Info Banner

```tsx
import { infoStateStyles } from '@/styles'

<div className={infoStateStyles.banner}>
  Important information about this feature
</div>
```

#### Info with Icon

```tsx
<div className={infoStateStyles.banner}>
  <div className="flex items-center gap-2">
    <Info className={infoStateStyles.icon} />
    <span>Important information</span>
  </div>
</div>
```

### Read-Only Banner

Used to indicate that a resource is in read-only mode.

```typescript
export const readOnlyBannerStyles = {
  container: 'bg-azul/10 border border-azul/30 text-verde px-4 py-3 rounded-lg flex items-center gap-2',
  icon: 'w-4 h-4 text-azul',
  text: 'text-sm font-medium',
}
```

#### Usage

```tsx
import { readOnlyBannerStyles } from '@/styles'

<div className={readOnlyBannerStyles.container}>
  <Lock className={readOnlyBannerStyles.icon} />
  <span className={readOnlyBannerStyles.text}>
    This resource is in read-only mode
  </span>
</div>
```

## Validation States

### Validation Progress

Validation progress indicator.

```typescript
export const validationProgressStyles = {
  container: 'flex items-center gap-4',
  bar: 'flex-1 h-2 bg-areia/30 rounded-full overflow-hidden',
  fill: 'h-full bg-verde-claro transition-all duration-300',
  text: 'text-sm text-verde whitespace-nowrap',
}
```

#### Usage

```tsx
import { validationProgressStyles } from '@/styles'

<div className={validationProgressStyles.container}>
  <div className={validationProgressStyles.bar}>
    <div 
      className={validationProgressStyles.fill}
      style={{ width: `${progress}%` }}
    />
  </div>
  <span className={validationProgressStyles.text}>
    {validated}/{total} validated
  </span>
</div>
```

## Combined States

### Loading with Empty State

```tsx
{loading ? (
  <div className="flex items-center justify-center py-12">
    <div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
  </div>
) : items.length === 0 ? (
  <div className="py-12 text-center text-verde/60">
    <Icon className="w-12 h-12 mx-auto mb-4 opacity-30" />
    <p className="text-sm">No items found</p>
  </div>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

### Error with Retry

```tsx
{error ? (
  <Card>
    <CardContent className="py-8 text-center">
      <div className={errorStateStyles.banner}>
        {error}
      </div>
      <div className="mt-4">
        <Button onClick={retry}>Try Again</Button>
      </div>
    </CardContent>
  </Card>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

## States in Specific Components

### Clause State

```tsx
{clause.validated ? (
  <div className="border-verde-claro/50 bg-verde-claro/5">
    Validated clause
  </div>
) : (
  <div className="border-areia/30">
    Pending clause
  </div>
)}
```

### Event State

```tsx
{event.validated ? (
  <div className="border-verde-claro/50 bg-verde-claro/5">
    Validated event
  </div>
) : event.errors.length > 0 ? (
  <div className="border-red-300 bg-red-50">
    Event with errors
  </div>
) : (
  <div className="border-areia/30">
    Pending event
  </div>
)}
```

## Icons by State

### Recommended Icons

- **Loading**: `Loader2` (with spin animation)
- **Error**: `AlertCircle`, `XCircle`
- **Success**: `CheckCircle2`, `Check`
- **Warning**: `AlertTriangle`, `AlertCircle`
- **Info**: `Info`, `InfoCircle`
- **Empty**: `Inbox`, `FileX`, `FolderOpen`
- **Read-Only**: `Lock`

### Icon Usage

```tsx
import { 
  Loader2, 
  AlertCircle, 
  CheckCircle2, 
  AlertTriangle, 
  Info,
  Lock 
} from 'lucide-react'

// Loading
<Loader2 className="w-4 h-4 animate-spin" />

// Error
<AlertCircle className="w-4 h-4 text-red-600" />

// Success
<CheckCircle2 className="w-4 h-4 text-verde-claro" />

// Warning
<AlertTriangle className="w-4 h-4 text-yellow-600" />

// Info
<Info className="w-4 h-4 text-azul" />

// Read-Only
<Lock className="w-4 h-4 text-azul" />
```

## References
- Icons: `lucide-react`

---

## DS-11. Layout

## Layout System

The application uses a consistent layout system based on containers, grids, and spacing patterns.

## Containers

### Default Container

```tsx
<div className="container mx-auto p-6">
  ...
</div>
```

### Responsive Container

```tsx
<div className="container mx-auto p-4 md:p-6 lg:p-8">
  ...
</div>
```

## Grids

### 2-Column Grid

```typescript
export const gridStyles = {
  twoColumn: 'grid grid-cols-1 md:grid-cols-2 gap-4',
  threeColumn: 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4',
  fourColumn: 'grid grid-cols-2 md:grid-cols-4 gap-4',
}
```

#### Usage

```tsx
import { gridStyles } from '@/styles'

<div className={gridStyles.twoColumn}>
  <Card>...</Card>
  <Card>...</Card>
</div>
```

### Custom Grid

```tsx
// 1 column on mobile, 2 on tablet, 3 on desktop
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  ...
</div>

// 2 columns on mobile, 4 on desktop
<div className="grid grid-cols-2 md:grid-cols-4 gap-4">
  ...
</div>
```

## Pages

### Page Structure

```typescript
export const pageStyles = {
  container: 'space-y-6',
  header: 'flex items-start justify-between',
  title: 'text-2xl font-bold text-preto flex items-center gap-2',
  subtitle: 'text-verde mt-1',
  actions: 'flex items-center gap-2',
}
```

#### Usage

```tsx
import { pageStyles } from '@/styles'

<div className={pageStyles.container}>
  <div className={pageStyles.header}>
    <div>
      <h1 className={pageStyles.title}>
        <Icon className="w-5 h-5 text-telha" />
        Page Title
      </h1>
      <p className={pageStyles.subtitle}>
        Subtitle or description
      </p>
    </div>
    <div className={pageStyles.actions}>
      <Button>Action</Button>
    </div>
  </div>
  <div>
    Page content
  </div>
</div>
```

### Complete Page

```tsx
<div className="container mx-auto p-6 space-y-8">
  <div className="flex items-start justify-between">
    <div>
      <h1 className="text-2xl font-bold text-preto flex items-center gap-2">
        <Icon className="w-5 h-5 text-telha" />
        Title
      </h1>
      <p className="text-verde mt-1">Description</p>
    </div>
    <div className="flex items-center gap-2">
      <Button variant="outline">Action 1</Button>
      <Button>Action 2</Button>
    </div>
  </div>
  
  <div className="space-y-6">
    {/* Content */}
  </div>
</div>
```

## Headers

### Stage Header

```typescript
export const stageHeaderStyles = {
  icon: 'w-6 h-6 text-telha',
  title: 'text-2xl font-bold text-preto flex items-center gap-2',
  description: 'text-verde mt-1',
}
```

#### Usage

```tsx
import { stageHeaderStyles } from '@/styles'

<div>
  <h1 className={stageHeaderStyles.title}>
    <Icon className={stageHeaderStyles.icon} />
    Stage Title
  </h1>
  <p className={stageHeaderStyles.description}>
    Stage description
  </p>
</div>
```

## Forms

### Form Group

```typescript
export const formStyles = {
  group: 'space-y-2',
  label: 'text-sm font-medium text-preto',
  hint: 'text-xs text-verde/60',
  error: 'text-xs text-red-600',
}
```

#### Usage

```tsx
import { formStyles } from '@/styles'

<div className={formStyles.group}>
  <label className={formStyles.label}>
    Field Name
  </label>
  <Input placeholder="Type..." />
  <span className={formStyles.hint}>
    Hint or help
  </span>
  {error && (
    <span className={formStyles.error}>
      {error}
    </span>
  )}
</div>
```

### Complete Form

```tsx
<form className="space-y-4">
  <div className={formStyles.group}>
    <label className={formStyles.label}>Name</label>
    <Input />
    <span className={formStyles.hint}>Enter your full name</span>
  </div>
  
  <div className={formStyles.group}>
    <label className={formStyles.label}>Email</label>
    <Input type="email" />
    {errors.email && (
      <span className={formStyles.error}>{errors.email}</span>
    )}
  </div>
  
  <div className="flex justify-end gap-2">
    <Button variant="outline">Cancel</Button>
    <Button>Save</Button>
  </div>
</form>
```

## Modals

### Modal Styles

```typescript
export const modalStyles = {
  header: 'text-lg font-semibold text-preto',
  description: 'text-sm text-verde',
  footer: 'flex justify-end gap-2 pt-4',
}
```

#### Usage

```tsx
import { modalStyles } from '@/styles'

<Dialog>
  <DialogContent>
    <DialogHeader>
      <DialogTitle className={modalStyles.header}>
        Title
      </DialogTitle>
      <DialogDescription className={modalStyles.description}>
        Description
      </DialogDescription>
    </DialogHeader>
    <div>
      Content
    </div>
    <DialogFooter className={modalStyles.footer}>
      <Button variant="outline">Cancel</Button>
      <Button>Confirm</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

## Flexbox

### Flex Row

```tsx
<div className="flex items-center gap-2">
  <Icon />
  <span>Text</span>
</div>
```

### Flex Column

```tsx
<div className="flex flex-col gap-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

### Flex with Spacing

```tsx
<div className="flex items-center justify-between">
  <span>Left</span>
  <span>Right</span>
</div>
```

### Flex Wrap

```tsx
<div className="flex flex-wrap gap-2">
  {items.map(item => (
    <Badge key={item.id}>{item.label}</Badge>
  ))}
</div>
```

## Spacing

See complete documentation in [Spacing](./spacing.md).

### Vertical Spacing

```tsx
<div className="space-y-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

### Horizontal Spacing

```tsx
<div className="flex space-x-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

## Responsiveness

### Breakpoints

- `sm`: 640px
- `md`: 768px
- `lg`: 1024px
- `xl`: 1280px
- `2xl`: 1536px

### Responsive Layout

```tsx
// Mobile: 1 column, Desktop: 2 columns
<div className="grid grid-cols-1 md:grid-cols-2 gap-4">
  ...
</div>

// Mobile: stack, Desktop: row
<div className="flex flex-col md:flex-row gap-4">
  ...
</div>

// Responsive padding
<div className="p-4 md:p-6 lg:p-8">
  ...
</div>
```

## DS-12. Border Radius

## Border Radius System

The application uses a consistent border radius system based on rounded values.

## Default Values

### Tailwind Configuration

```javascript
borderRadius: {
  sm: '0.25rem',   // 4px
  md: '0.5rem',    // 8px
  lg: '0.75rem',   // 12px
}
```

### CSS Variable

```css
:root {
  --radius: 0.5rem; /* 8px - default value */
}
```

## Border Radius Scale

| Class | Value | Pixels | Usage |
|--------|-------|--------|-----|
| `rounded-none` | 0 | 0px | No rounding |
| `rounded-sm` | 0.25rem | 4px | Small rounding |
| `rounded` | 0.5rem | 8px | Default rounding |
| `rounded-md` | 0.5rem | 8px | Medium rounding (same as default) |
| `rounded-lg` | 0.75rem | 12px | Large rounding |
| `rounded-xl` | 1rem | 16px | Extra large rounding |
| `rounded-2xl` | 1.5rem | 24px | Very large rounding |
| `rounded-full` | 9999px | - | Full circle |

## Usage by Component

### Cards

```tsx
// Default card
<Card className="rounded-xl">...</Card>

// Stage card
<div className="stage-card rounded-lg">...</div>

// Clause card
<div className="clause-card rounded-lg">...</div>

// Event card
<div className="event-card rounded-lg">...</div>
```

### Buttons

```tsx
// Default button
<Button className="rounded-lg">...</Button>

// Small button
<Button size="sm" className="rounded-md">...</Button>

// Large button
<Button size="lg" className="rounded-lg">...</Button>
```

### Inputs

```tsx
// Default input
<Input className="rounded-lg">...</Input>

// Textarea
<Textarea className="rounded-lg">...</Textarea>
```

### Badges

```tsx
// Default badge (full circle)
<Badge className="rounded-full">...</Badge>
```

### Modals and Dialogs

```tsx
// Dialog
<DialogContent className="rounded-xl">...</DialogContent>

// Sheet
<SheetContent className="rounded-l-xl">...</SheetContent>
```

## Specific Border Radius

### Individual Corners

```tsx
// Top left
<div className="rounded-tl-lg">...</div>

// Top right
<div className="rounded-tr-lg">...</div>

// Bottom left
<div className="rounded-bl-lg">...</div>

// Bottom right
<div className="rounded-br-lg">...</div>

// Top (both)
<div className="rounded-t-lg">...</div>

// Bottom (both)
<div className="rounded-b-lg">...</div>

// Left (both)
<div className="rounded-l-lg">...</div>

// Right (both)
<div className="rounded-r-lg">...</div>
```

## Usage Patterns

### Cards with Border Radius

```tsx
// Default card
<Card className="rounded-xl border border-areia/30">
  ...
</Card>

// Card with hover
<Card className="rounded-lg hover:shadow-md">
  ...
</Card>
```

### Buttons with Border Radius

```tsx
// Primary button
<Button className="rounded-lg">
  Button
</Button>

// Outline button
<Button variant="outline" className="rounded-lg">
  Button
</Button>
```

### Inputs with Border Radius

```tsx
// Default input
<Input className="rounded-lg border border-areia" />

// Input with focus
<Input className="rounded-lg focus-visible:ring-2 focus-visible:ring-telha" />
```

### Badges with Border Radius

```tsx
// Default badge (always rounded-full)
<Badge className="rounded-full px-2.5 py-0.5">
  Badge
</Badge>
```

## Border Radius in States

### Selected Cards

```tsx
<div className={cn(
  "rounded-lg",
  isSelected && "ring-2 ring-telha/50"
)}>
  ...
</div>
```

### Cards with Hover

```tsx
<div className="rounded-lg transition-all hover:shadow-md">
  ...
</div>
```

## Responsive Border Radius

Although uncommon, responsive border radius can be used:

```tsx
// Mobile: rounded-md, Desktop: rounded-lg
<div className="rounded-md md:rounded-lg">...</div>
```

## Special Shapes

### Circles

```tsx
// Circular avatar
<div className="w-10 h-10 rounded-full bg-telha/20">
  ...
</div>

// Circular icon
<button className="w-10 h-10 rounded-full bg-areia/20">
  <Icon />
</button>
```

### Pills

```tsx
// Pill-shaped badge
<Badge className="rounded-full px-3 py-1">
  Badge
</Badge>

// Pill-shaped button
<Button className="rounded-full px-6">
  Pill Button
</Button>
```

## Border Radius in Sections

### Collapsible Sections

```tsx
<div className="rounded-lg border border-areia/30 overflow-hidden">
  <div className="bg-areia/10 p-4">
    Header
  </div>
  <div className="bg-white p-4">
    Content
  </div>
</div>
```

### Cards with Border Left

```tsx
// Card with highlighted left border
<div className="rounded-lg border-l-4 border-l-telha">
  ...
</div>

// Mainline clause card
<div className="clause-card-mainline rounded-lg border-l-4 border-l-telha">
  ...
</div>

// Background clause card
<div className="clause-card-background rounded-lg border-l-4 border-l-azul">
  ...
</div>
```

## Visual Consistency

### Border Radius Hierarchy

1. **Small elements** (badges, tags): `rounded-full`
2. **Medium elements** (buttons, inputs): `rounded-lg`
3. **Large elements** (cards, modals): `rounded-xl`
4. **Very large elements** (containers): `rounded-2xl`

### Hierarchy Examples

```tsx
// Large container
<div className="rounded-2xl bg-white p-8">
  {/* Medium card */}
  <Card className="rounded-xl">
    {/* Small button */}
    <Button className="rounded-lg">...</Button>
    {/* Badge */}
    <Badge className="rounded-full">...</Badge>
  </Card>
</div>
```

## DS-13. Seções Colapsáveis

## Section System

The application uses collapsible sections with different visual variants to organize related content.

## Base Section

### Section Structure

```tsx
<div className="border border-areia/30 rounded-lg overflow-hidden">
  <button className="bg-areia/10 hover:bg-areia/20 p-4 w-full text-left">
    Section Header
  </button>
  <div className="bg-white p-4">
    Section Content
  </div>
</div>
```

## Section Variants

### Variant Types

```typescript
export type SectionVariant = 
  | 'default' 
  | 'roles' 
  | 'modifiers' 
  | 'pragmatic' 
  | 'emotion' 
  | 'la-tags' 
  | 'figurative' 
  | 'key-terms' 
  | 'speech'
  | 'narrator'
```

### Style Interface

```typescript
export interface SectionStyle {
  header: string
  content: string
  border: string
}
```

## Styles by Variant

### Default

```typescript
default: {
  header: 'bg-areia/10 hover:bg-areia/20',
  content: 'bg-white',
  border: 'border-areia/30',
}
```

#### Usage

```tsx
import { sectionStyles } from '@/styles'

<div className={cn("border rounded-lg overflow-hidden", sectionStyles.default.border)}>
  <button className={cn("p-4 w-full text-left", sectionStyles.default.header)}>
    Default Section
  </button>
  <div className={sectionStyles.default.content}>
    Content
  </div>
</div>
```

### Roles

```typescript
roles: {
  header: 'bg-amber-50 hover:bg-amber-100',
  content: 'bg-amber-50/50',
  border: 'border-l-4 border-l-amber-400 border-areia/30',
}
```

#### Usage

```tsx
<div className={cn("border rounded-lg overflow-hidden", sectionStyles.roles.border)}>
  <button className={cn("p-4 w-full text-left", sectionStyles.roles.header)}>
    Roles
  </button>
  <div className={sectionStyles.roles.content}>
    Roles content
  </div>
</div>
```

### Modifiers

```typescript
modifiers: {
  header: 'bg-slate-50 hover:bg-slate-100',
  content: 'bg-white',
  border: 'border-areia/30',
}
```

#### Usage

```tsx
<div className={cn("border rounded-lg overflow-hidden", sectionStyles.modifiers.border)}>
  <button className={cn("p-4 w-full text-left", sectionStyles.modifiers.header)}>
    Modifiers
  </button>
  <div className={sectionStyles.modifiers.content}>
    Modifiers content
  </div>
</div>
```

### Pragmatic

```typescript
pragmatic: {
  header: 'bg-yellow-50 hover:bg-yellow-100',
  content: 'bg-yellow-50/50',
  border: 'border-areia/30',
}
```

### Emotion

```typescript
emotion: {
  header: 'bg-pink-50 hover:bg-pink-100',
  content: 'bg-pink-50/50',
  border: 'border-areia/30',
}
```

### LA Tags

```typescript
'la-tags': {
  header: 'bg-emerald-50 hover:bg-emerald-100',
  content: 'bg-emerald-50/50',
  border: 'border-areia/30',
}
```

### Figurative

```typescript
figurative: {
  header: 'bg-purple-50 hover:bg-purple-100',
  content: 'bg-purple-50/50',
  border: 'border-areia/30',
}
```

### Key Terms

```typescript
'key-terms': {
  header: 'bg-orange-50 hover:bg-orange-100',
  content: 'bg-orange-50/50',
  border: 'border-areia/30',
}
```

### Speech

```typescript
speech: {
  header: 'bg-blue-50 hover:bg-blue-100',
  content: 'bg-blue-50/50',
  border: 'border-areia/30',
}
```

### Narrator

```typescript
narrator: {
  header: 'bg-indigo-50 hover:bg-indigo-100',
  content: 'bg-indigo-50/50',
  border: 'border-areia/30',
}
```

## Collapsible Section

### Collapsible Section Component

```tsx
import { useState } from 'react'
import { ChevronDown, ChevronUp } from 'lucide-react'
import { sectionStyles } from '@/styles'
import { cn } from '@/utils/cn'

function CollapsibleSection({ variant = 'default', title, children }) {
  const [isOpen, setIsOpen] = useState(false)
  const styles = sectionStyles[variant]

  return (
    <div className={cn("border rounded-lg overflow-hidden", styles.border)}>
      <button
        onClick={() => setIsOpen(!isOpen)}
        className={cn("p-4 w-full text-left flex items-center justify-between", styles.header)}
      >
        <span className="font-medium">{title}</span>
        {isOpen ? (
          <ChevronUp className="w-4 h-4" />
        ) : (
          <ChevronDown className="w-4 h-4" />
        )}
      </button>
      {isOpen && (
        <div className={styles.content}>
          {children}
        </div>
      )}
    </div>
  )
}
```

### Usage

```tsx
<CollapsibleSection variant="roles" title="Roles">
  <div className="space-y-2">
    {/* Content */}
  </div>
</CollapsibleSection>
```

## Section with Icon

### Header with Icon

```tsx
<button className={cn("p-4 w-full text-left flex items-center gap-2", sectionStyles.roles.header)}>
  <Icon className="w-4 h-4" />
  <span className="font-medium">Section Title</span>
</button>
```

## Section with Badge

### Header with Counter

```tsx
<button className={cn("p-4 w-full text-left flex items-center justify-between", sectionStyles.roles.header)}>
  <div className="flex items-center gap-2">
    <Icon className="w-4 h-4" />
    <span className="font-medium">Title</span>
  </div>
  <Badge variant="default">{count}</Badge>
</button>
```

## Section with Actions

### Header with Buttons

```tsx
<button className={cn("p-4 w-full text-left flex items-center justify-between", sectionStyles.roles.header)}>
  <span className="font-medium">Title</span>
  <div className="flex items-center gap-2" onClick={(e) => e.stopPropagation()}>
    <Button variant="ghost" size="sm">
      <Plus className="w-4 h-4" />
    </Button>
  </div>
</button>
```

## Multiple Sections

### Section List

```tsx
<div className="space-y-4">
  <CollapsibleSection variant="roles" title="Roles">
    ...
  </CollapsibleSection>
  <CollapsibleSection variant="modifiers" title="Modifiers">
    ...
  </CollapsibleSection>
  <CollapsibleSection variant="emotion" title="Emotions">
    ...
  </CollapsibleSection>
</div>
```

## Section Expanded by Default

### Initially Open Section

```tsx
function CollapsibleSection({ variant = 'default', title, children, defaultOpen = false }) {
  const [isOpen, setIsOpen] = useState(defaultOpen)
  // ...
}
```

### Usage

```tsx
<CollapsibleSection variant="roles" title="Roles" defaultOpen={true}>
  ...
</CollapsibleSection>
```

## Section with Custom Content

### Content with Custom Padding

```tsx
<div className={cn(sectionStyles.roles.content, "p-6")}>
  {children}
</div>
```

## Nested Section

### Sections Within Sections

```tsx
<CollapsibleSection variant="default" title="Main Section">
  <div className="space-y-2">
    <CollapsibleSection variant="roles" title="Sub-section">
      ...
    </CollapsibleSection>
  </div>
</CollapsibleSection>
```

## Section with Validation State

### Validated Section

```tsx
<div className={cn(
  "border rounded-lg overflow-hidden",
  sectionStyles.roles.border,
  isValidated && "border-verde-claro/50"
)}>
  <button className={cn(
    "p-4 w-full text-left flex items-center justify-between",
    sectionStyles.roles.header
  )}>
    <div className="flex items-center gap-2">
      <span className="font-medium">Title</span>
      {isValidated && (
        <CheckCircle2 className="w-4 h-4 text-verde-claro" />
      )}
    </div>
  </button>
  ...
</div>
```

## DS-14. Temas (Light / Dark)

## Overview

The Shema Design System officially supports two visual modes: **Light Mode** ("Paper & Ink") and **Dark Mode** ("Night & Earth").

## Light Mode — "Paper & Ink"

**Metaphor:** Printed paper.

### Colors

```typescript
// Base colors
background: '#F6F5EB'        // Shema White (Cream) - Main background
surface: '#FFFFFF'            // Pure White - Elevated surfaces
primaryText: '#0A0703'        // Shema Black - Primary text
secondaryText: '#3F3E20'     // Shema Dark Green - Secondary text
borders: '#C5C29F'            // Sand - Borders
```

### CSS Variables

```css
:root {
  --background: 48 29% 95%;      /* Shema White (Cream) */
  --foreground: 30 43% 3%;       /* Shema Black */
  --card: 0 0% 100%;             /* Pure White */
  --card-foreground: 30 43% 3%;   /* Shema Black */
  --primary: 22 97% 38%;         /* Telha */
  --primary-foreground: 48 29% 95%; /* Shema White */
  --secondary: 167 19% 60%;       /* Blue */
  --secondary-foreground: 30 43% 3%; /* Shema Black */
  --muted: 53 19% 70%;           /* Sand */
  --muted-foreground: 60 34% 19%;  /* Dark Green */
  --accent: 167 19% 60%;         /* Blue */
  --accent-foreground: 30 43% 3%; /* Shema Black */
  --destructive: 22 97% 38%;      /* Telha */
  --destructive-foreground: 48 29% 95%; /* Shema White */
  --border: 53 19% 70%;          /* Sand */
  --input: 53 19% 70%;           /* Sand */
  --ring: 22 97% 38%;            /* Telha */
  --radius: 0.5rem;
}
```

### Body Application

```css
body {
  background: hsl(var(--background));  /* Shema Cream, not pure white */
  color: hsl(var(--foreground));       /* Shema Black, softer than absolute black */
  font-family: 'Montserrat', system-ui, sans-serif;
}
```

> [!IMPORTANT]
> Pure white must never be used as a page background. Use Shema White / Cream (#F6F5EB) to simulate paper and provide visual comfort.

## Dark Mode — "Night & Earth"

**Metaphor:** Organic night environment.

### Colors

```typescript
// Base colors
background: '#0A0703'        // Shema Black - Main background
surface: '#0A0703'           // Shema Black with visible borders
highlightSurface: '#3F3E20'  // Dark Green - Highlighted surfaces
primaryText: '#F6F5EB'       // Shema White (Cream) - Primary text
secondaryText: '#C5C29F'     // Sand - Secondary text
borders: '#3F3E20'           // Dark Green - Borders
```

### Web CSS Variables (Proposed)

```css
[data-theme="dark"] {
  --background: 30 43% 3%;        /* Shema Black */
  --foreground: 48 29% 95%;       /* Shema White (Cream) */
  --card: 30 43% 3%;              /* Shema Black */
  --card-foreground: 48 29% 95%;  /* Shema White */
  --primary: 22 97% 38%;          /* Telha */
  --primary-foreground: 48 29% 95%; /* Shema White */
  --secondary: 167 19% 60%;       /* Blue */
  --secondary-foreground: 48 29% 95%; /* Shema White */
  --muted: 60 34% 19%;            /* Dark Green */
  --muted-foreground: 53 19% 70%; /* Sand */
  --border: 60 34% 19%;           /* Dark Green */
  --input: 60 34% 19%;            /* Dark Green */
  --ring: 22 97% 38%;             /* Telha */
}
```

## Strict Restrictions

- Do **NOT** use generic neutral greys.
- Do **NOT** approximate Material Design dark palettes.
- Dark interfaces must be composed **only** using Shema palette colors.

Failure to follow these rules must be treated as a design defect, not a stylistic preference.

## Theme Switching

### Implementation (Future)

#### 1. Add Theme Toggle

```tsx
import { useState, useEffect } from 'react'

function ThemeToggle() {
  const [theme, setTheme] = useState<'light' | 'dark'>('light')

  useEffect(() => {
    const root = document.documentElement
    if (theme === 'dark') {
      root.setAttribute('data-theme', 'dark')
    } else {
      root.removeAttribute('data-theme')
    }
  }, [theme])

  return (
    <button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
      {theme === 'light' ? <Moon /> : <Sun />}
    </button>
  )
}
```

#### 2. Persist Preference

```tsx
useEffect(() => {
  const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null
  if (savedTheme) {
    setTheme(savedTheme)
  } else {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    setTheme(prefersDark ? 'dark' : 'light')
  }
}, [])

useEffect(() => {
  localStorage.setItem('theme', theme)
}, [theme])
```

#### 3. Update Components

All components should use CSS variables or Tailwind classes that support both themes:

```tsx
// ✅ Good - uses CSS variables
<div className="bg-background text-foreground">
  ...
</div>

// ✅ Good - uses Tailwind with dark:
<div className="bg-white dark:bg-gray-900 text-preto dark:text-branco">
  ...
</div>

// ❌ Avoid - hardcoded colors
<div className="bg-[#F6F5EB] text-[#0A0703]">
  ...
</div>
```

## System Preference

### Detect User Preference

```tsx
useEffect(() => {
  const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
  
  const handleChange = (e: MediaQueryListEvent) => {
    setTheme(e.matches ? 'dark' : 'light')
  }
  
  mediaQuery.addEventListener('change', handleChange)
  return () => mediaQuery.removeEventListener('change', handleChange)
}, [])
```

## Theme Transitions

### Smooth Animation

```css
* {
  transition: background-color 0.2s ease, color 0.2s ease, border-color 0.2s ease;
}
```

## Accessibility

### Contrast in Both Themes

- **Light Theme**: Minimum contrast of 4.5:1 for normal text
- **Dark Theme**: Minimum contrast of 4.5:1 for normal text
- Both themes must pass WCAG AA tests

### Reduced Motion Preference

```css
@media (prefers-reduced-motion: reduce) {
  * {
    transition: none !important;
  }
}
```