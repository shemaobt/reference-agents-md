# Badges — Shema Design System

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
// frontend/src/components/ui/badge.tsx
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
// frontend/src/styles/badges.ts
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

## References

- Badge component: `frontend/src/components/ui/badge.tsx`
- Badge colors: `frontend/src/styles/badges.ts`
- CSS styles: `frontend/src/styles/main.css`

