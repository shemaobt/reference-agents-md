# Shema Design System

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

## 📖 Additional Resources

- **[AGENTS.md](./AGENTS.md)** - AI agent guidelines and brand authority
- **[README.md](./README.md)** - Visual references and conflict resolution
- **[figma-links.md](./figma-links.md)** - Links to Figma design files
- **[assets/references/](./assets/references/)** - Visual examples and screenshots

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
