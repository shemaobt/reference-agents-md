# Cards — Shema Design System

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
// frontend/src/components/ui/card.tsx
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
// frontend/src/styles/cards.ts
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

## References

- Card component: `frontend/src/components/ui/card.tsx`
- Card styles: `frontend/src/styles/cards.ts`
- CSS styles: `frontend/src/styles/main.css`

