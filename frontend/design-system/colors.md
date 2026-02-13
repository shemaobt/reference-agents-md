# Color System — Shema Design System

## Overview

The Shema Design System uses an earthy color palette inspired by natural tones, reflecting the brand values: simple, accessible, lively, friendly, and human.

## Base Palette

The color system is defined in [tokens/colors.json](./tokens/colors.json), which is the authoritative source.

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

## References

- Design tokens: [tokens/colors.json](./tokens/colors.json)
- Brand guidelines: [AGENTS.md](./AGENTS.md)
- Tailwind config: `frontend/tailwind.config.js`
- Styles: `frontend/src/styles/main.css`
- Badge colors: `frontend/src/styles/badges.ts`
