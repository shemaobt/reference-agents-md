# Sections — Shema Design System

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
// frontend/src/styles/sections.ts
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

## References

- Section styles: `frontend/src/styles/sections.ts`
- Section components: `frontend/src/components/stages/Stage4Events/CollapsibleSection.tsx`

