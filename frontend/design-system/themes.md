# Themes — Shema Design System

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

### Flutter Implementation Reference

The dark theme is implemented in Flutter as follows (from `assets/references/app/components/themes/night-and-earth.dart`):

```dart
final shemaDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: colorShemaBlack,

  colorScheme: const ColorScheme.dark(
    primary: colorShemaTile,           // #BE4A01
    secondary: colorShemaBlue,          // #89AAA3
    tertiary: colorShemaGreenLight,     // #777D45
    surface: colorShemaBlack,           // #0A0703
    background: colorShemaBlack,        // #0A0703
    onPrimary: colorShemaCream,         // #F6F5EB
    onSurface: colorShemaCream,         // #F6F5EB
    onSurfaceVariant: colorShemaSand,   // #C5C29F
    outline: colorShemaGreenDark,       // #3F3E20
  ),

  cardTheme: CardTheme(
    color: colorShemaBlack,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(
        color: colorShemaGreenDark,  // #3F3E20
        width: 1.5,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorShemaGreenDark.withOpacity(0.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: colorShemaGreenDark),
    ),
    hintStyle: const TextStyle(color: colorShemaSand),
  ),
);
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

## References

- Brand guidelines: [AGENTS.md](./AGENTS.md)
- Color system: [colors.md](./colors.md)
- Flutter light theme: [assets/references/app/components/themes/paper-and-ink.dart](./assets/references/app/components/themes/paper-and-ink.dart)
- Flutter dark theme: [assets/references/app/components/themes/night-and-earth.dart](./assets/references/app/components/themes/night-and-earth.dart)
- Tailwind config: `frontend/tailwind.config.js`
- CSS variables: `frontend/src/styles/main.css`
