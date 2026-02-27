# Layout — Shema Design System

## Layout System

The application uses a consistent layout system based on containers, grids, and spacing patterns.

## Containers

### Default Container

```tsx
<div className="container mx-auto p-6">
  ...
</div>
```

### Responsive Container

```tsx
<div className="container mx-auto p-4 md:p-6 lg:p-8">
  ...
</div>
```

## Grids

### 2-Column Grid

```typescript
// frontend/src/styles/layout.ts
export const gridStyles = {
  twoColumn: 'grid grid-cols-1 md:grid-cols-2 gap-4',
  threeColumn: 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4',
  fourColumn: 'grid grid-cols-2 md:grid-cols-4 gap-4',
}
```

#### Usage

```tsx
import { gridStyles } from '@/styles'

<div className={gridStyles.twoColumn}>
  <Card>...</Card>
  <Card>...</Card>
</div>
```

### Custom Grid

```tsx
// 1 column on mobile, 2 on tablet, 3 on desktop
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  ...
</div>

// 2 columns on mobile, 4 on desktop
<div className="grid grid-cols-2 md:grid-cols-4 gap-4">
  ...
</div>
```

## Pages

### Page Structure

```typescript
export const pageStyles = {
  container: 'space-y-6',
  header: 'flex items-start justify-between',
  title: 'text-2xl font-bold text-preto flex items-center gap-2',
  subtitle: 'text-verde mt-1',
  actions: 'flex items-center gap-2',
}
```

#### Usage

```tsx
import { pageStyles } from '@/styles'

<div className={pageStyles.container}>
  <div className={pageStyles.header}>
    <div>
      <h1 className={pageStyles.title}>
        <Icon className="w-5 h-5 text-telha" />
        Page Title
      </h1>
      <p className={pageStyles.subtitle}>
        Subtitle or description
      </p>
    </div>
    <div className={pageStyles.actions}>
      <Button>Action</Button>
    </div>
  </div>
  <div>
    Page content
  </div>
</div>
```

### Complete Page

```tsx
<div className="container mx-auto p-6 space-y-8">
  <div className="flex items-start justify-between">
    <div>
      <h1 className="text-2xl font-bold text-preto flex items-center gap-2">
        <Icon className="w-5 h-5 text-telha" />
        Title
      </h1>
      <p className="text-verde mt-1">Description</p>
    </div>
    <div className="flex items-center gap-2">
      <Button variant="outline">Action 1</Button>
      <Button>Action 2</Button>
    </div>
  </div>
  
  <div className="space-y-6">
    {/* Content */}
  </div>
</div>
```

## Headers

### Stage Header

```typescript
export const stageHeaderStyles = {
  icon: 'w-6 h-6 text-telha',
  title: 'text-2xl font-bold text-preto flex items-center gap-2',
  description: 'text-verde mt-1',
}
```

#### Usage

```tsx
import { stageHeaderStyles } from '@/styles'

<div>
  <h1 className={stageHeaderStyles.title}>
    <Icon className={stageHeaderStyles.icon} />
    Stage Title
  </h1>
  <p className={stageHeaderStyles.description}>
    Stage description
  </p>
</div>
```

## Forms

### Form Group

```typescript
export const formStyles = {
  group: 'space-y-2',
  label: 'text-sm font-medium text-preto',
  hint: 'text-xs text-verde/60',
  error: 'text-xs text-red-600',
}
```

#### Usage

```tsx
import { formStyles } from '@/styles'

<div className={formStyles.group}>
  <label className={formStyles.label}>
    Field Name
  </label>
  <Input placeholder="Type..." />
  <span className={formStyles.hint}>
    Hint or help
  </span>
  {error && (
    <span className={formStyles.error}>
      {error}
    </span>
  )}
</div>
```

### Complete Form

```tsx
<form className="space-y-4">
  <div className={formStyles.group}>
    <label className={formStyles.label}>Name</label>
    <Input />
    <span className={formStyles.hint}>Enter your full name</span>
  </div>
  
  <div className={formStyles.group}>
    <label className={formStyles.label}>Email</label>
    <Input type="email" />
    {errors.email && (
      <span className={formStyles.error}>{errors.email}</span>
    )}
  </div>
  
  <div className="flex justify-end gap-2">
    <Button variant="outline">Cancel</Button>
    <Button>Save</Button>
  </div>
</form>
```

## Modals

### Modal Styles

```typescript
export const modalStyles = {
  header: 'text-lg font-semibold text-preto',
  description: 'text-sm text-verde',
  footer: 'flex justify-end gap-2 pt-4',
}
```

#### Usage

```tsx
import { modalStyles } from '@/styles'

<Dialog>
  <DialogContent>
    <DialogHeader>
      <DialogTitle className={modalStyles.header}>
        Title
      </DialogTitle>
      <DialogDescription className={modalStyles.description}>
        Description
      </DialogDescription>
    </DialogHeader>
    <div>
      Content
    </div>
    <DialogFooter className={modalStyles.footer}>
      <Button variant="outline">Cancel</Button>
      <Button>Confirm</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

## Flexbox

### Flex Row

```tsx
<div className="flex items-center gap-2">
  <Icon />
  <span>Text</span>
</div>
```

### Flex Column

```tsx
<div className="flex flex-col gap-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

### Flex with Spacing

```tsx
<div className="flex items-center justify-between">
  <span>Left</span>
  <span>Right</span>
</div>
```

### Flex Wrap

```tsx
<div className="flex flex-wrap gap-2">
  {items.map(item => (
    <Badge key={item.id}>{item.label}</Badge>
  ))}
</div>
```

## Spacing

See complete documentation in [Spacing](./spacing.md).

### Vertical Spacing

```tsx
<div className="space-y-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

### Horizontal Spacing

```tsx
<div className="flex space-x-4">
  <div>Item 1</div>
  <div>Item 2</div>
</div>
```

## Responsiveness

### Breakpoints

- `sm`: 640px
- `md`: 768px
- `lg`: 1024px
- `xl`: 1280px
- `2xl`: 1536px

### Responsive Layout

```tsx
// Mobile: 1 column, Desktop: 2 columns
<div className="grid grid-cols-1 md:grid-cols-2 gap-4">
  ...
</div>

// Mobile: stack, Desktop: row
<div className="flex flex-col md:flex-row gap-4">
  ...
</div>

// Responsive padding
<div className="p-4 md:p-6 lg:p-8">
  ...
</div>
```

## References

- Layout styles: `frontend/src/styles/layout.ts`
- Layout components: `frontend/src/components/layout/`

