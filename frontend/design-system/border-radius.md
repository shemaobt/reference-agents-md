# Border Radius — Shema Design System

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

## References

- Tailwind configuration: `frontend/tailwind.config.js`
- CSS variable: `frontend/src/styles/main.css`
- UI components: `frontend/src/components/ui/`

