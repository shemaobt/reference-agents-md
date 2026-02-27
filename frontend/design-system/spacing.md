# Spacing — Shema Design System

## Overview

The application uses the Tailwind CSS spacing system, based on a 4px (0.25rem) scale. The spacing system is defined in [tokens/spacing.json](./tokens/spacing.json), which is the authoritative source.

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

From [tokens/spacing.json](./tokens/spacing.json):

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

## References

- Design tokens: [tokens/spacing.json](./tokens/spacing.json)
- Brand guidelines: [AGENTS.md](./AGENTS.md)
- Tailwind config: `frontend/tailwind.config.js`
- Layout styles: `frontend/src/styles/layout.ts`
- UI components: `frontend/src/components/ui/`
