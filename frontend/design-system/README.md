# Shema Design System

This folder contains the complete visual ground truth for the Shema Design System.

## Quick Navigation

### 🎨 Start Here
- **[DESIGN.md](./DESIGN.md)** - Design system overview, quick start, and complete index
- **[AGENTS.md](./AGENTS.md)** - Brand authority, AI agent guidelines, and core principles

### 🔧 Design Tokens (Authoritative)
- [colors.json](./tokens/colors.json) - Color palette and semantic tokens
- [typography.json](./tokens/typography.json) - Font families (Montserrat/Merriweather), scales, weights
- [spacing.json](./tokens/spacing.json) - Spacing scale and layout tokens
- [animations.json](./tokens/animations.json) - Keyframes and animation timings
- [borders.json](./tokens/borders.json) - Border widths and radius values
- [shadows.json](./tokens/shadows.json) - Shadow scales for elevation

### 📚 Implementation Guides
- [colors.md](./colors.md) - Complete color system with usage examples
- [typography.md](./typography.md) - Typography hierarchy and font usage
- [spacing.md](./spacing.md) - Spacing scale and layout patterns
- [animations.md](./animations.md) - Motion design and transitions
- [components.md](./components.md) - UI component specifications
- [cards.md](./cards.md) - Card variants and patterns
- [badges.md](./badges.md) - Badge system and categories
- [states.md](./states.md) - Loading, error, success states
- [layout.md](./layout.md) - Grid systems and containers
- [border-radius.md](./border-radius.md) - Corner radius system
-[sections.md](./sections.md) - Section patterns
- [themes.md](./themes.md) - Light/dark theme specifications

### 🎯 Visual References
- [assets/references/](./assets/references/) - Visual examples and screenshots
- [figma-links.md](./figma-links.md) - Links to Figma design files

## Rules

### Conflict Resolution
1. **Token files** override visual references
2. **AGENTS.md** defines brand authority and principles  
3. **Implementation docs** provide detailed usage patterns
4. Images define visual intent, not pixel-perfect specs
5. Web and App references must not be mixed without justification

### Making Changes
- Token files require design team approval
- Document all exceptions
- Never introduce arbitrary colors or typography
- Follow the governance guidelines in [AGENTS.md](./AGENTS.md)

## Brand Essentials

### Colors
- **Telha (#BE4A01)**: Exclusive to CTAs and primary actions
- **Shema White (#F6F5EB)**: Main background (not pure white)
- **Pure White (#FFFFFF)**: Elevated surfaces only (cards, inputs)

### Typography
- **Montserrat**: All UI elements (buttons, navigation, labels)
- **Merriweather**: Long-form text and biblical content

### Key Principles
- Natural feel (paper-like backgrounds)
- Soft contrast (Shema Black, not absolute black)
- Intentional color (Telha for actions only)
- Gentle motion (200ms default, subtle)
