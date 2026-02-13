# Shema Design System — AI Agents Guide

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

## Visual Rationale

When generating or evaluating user interfaces:
- Always compare decisions with visual references in `assets/references/`.
- If there is a conflict between written rules and visual references, follow the written design tokens.
- Visual references define *intent*, not pixel-perfect layouts.

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

### Design Tokens (Authoritative)
- [colors.json](./tokens/colors.json) - Color palette and semantic tokens
- [typography.json](./tokens/typography.json) - Font families, scales, weights
- [spacing.json](./tokens/spacing.json) - Spacing scale and layout tokens
- [animations.json](./tokens/animations.json) - Animation keyframes and timings
- [borders.json](./tokens/borders.json) - Border widths and radius values
- [shadows.json](./tokens/shadows.json) - Shadow scales for elevation

### Visual References
- Visual examples in [assets/references/](./assets/references/)
- Figma links in [figma-links.md](./figma-links.md)

### Implementation Documentation
- [DESIGN.md](./DESIGN.md) - Design system overview and quick start
- [colors.md](./colors.md) - Complete color system with usage examples
- [typography.md](./typography.md) - Typography hierarchy and usage
- [spacing.md](./spacing.md) - Spacing scale and layout patterns
- [animations.md](./animations.md) - Animation and transition patterns
- [components.md](./components.md) - UI component specifications
- [cards.md](./cards.md) - Card variants and patterns
- [badges.md](./badges.md) - Badge system and categories
- [states.md](./states.md) - Loading, error, success states
- [layout.md](./layout.md) - Grid systems and containers
- [border-radius.md](./border-radius.md) - Corner radius system
- [sections.md](./sections.md) - Section patterns
- [themes.md](./themes.md) - Light/dark theme specifications

### Conflict Resolution
1. **Token files** override visual references
2. **This AGENTS.md** defines brand authority and principles
3. **Implementation docs** provide detailed usage patterns
4. When in doubt, consult token files first, then this document

Any exception must be documented.
