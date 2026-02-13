# States — Shema Design System

## State System

The application uses consistent visual states to communicate different conditions: loading, error, success, warning, information, and empty states.

## Available States

### Empty State

Used when there is no data to display.

```typescript
// frontend/src/styles/states.ts
export const emptyStateStyles = {
  container: 'py-12 text-center text-verde/60',
  icon: 'w-12 h-12 mx-auto mb-4 opacity-30',
  text: 'text-sm',
}
```

#### Usage

```tsx
import { emptyStateStyles } from '@/styles'

<div className={emptyStateStyles.container}>
  <Icon className={emptyStateStyles.icon} />
  <p className={emptyStateStyles.text}>
    No items found
  </p>
</div>
```

#### Complete Example

```tsx
{items.length === 0 ? (
  <div className="py-12 text-center text-verde/60">
    <Icon className="w-12 h-12 mx-auto mb-4 opacity-30" />
    <p className="text-sm">No items found</p>
  </div>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

### Loading State

Used during asynchronous operations.

```typescript
export const loadingStateStyles = {
  container: 'flex items-center justify-center py-12',
  spinner: 'w-8 h-8 animate-spin text-telha',
  smallSpinner: 'w-4 h-4 animate-spin text-telha',
  text: 'text-verde ml-3',
}
```

#### Default Spinner

```tsx
import { loadingStateStyles } from '@/styles'

<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.spinner}>
    <div className="w-8 h-8 border-4 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
</div>
```

#### Small Spinner

```tsx
<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.smallSpinner}>
    <div className="w-4 h-4 border-2 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
</div>
```

#### Loading with Text

```tsx
<div className={loadingStateStyles.container}>
  <div className={loadingStateStyles.spinner}>
    <div className="w-8 h-8 border-4 border-telha border-t-transparent rounded-full animate-spin" />
  </div>
  <p className={loadingStateStyles.text}>Loading...</p>
</div>
```

#### Loading in Card

```tsx
<Card>
  <CardContent className="py-12">
    <div className="flex items-center justify-center">
      <div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
    </div>
  </CardContent>
</Card>
```

### Error State

Used to display error messages.

```typescript
export const errorStateStyles = {
  banner: 'bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-red-600',
  text: 'text-sm',
}
```

#### Error Banner

```tsx
import { errorStateStyles } from '@/styles'

<div className={errorStateStyles.banner}>
  Error loading data
</div>
```

#### Error with Icon

```tsx
<div className={errorStateStyles.banner}>
  <div className="flex items-center gap-2">
    <AlertCircle className={errorStateStyles.icon} />
    <span>Error loading data</span>
  </div>
</div>
```

#### Error in Card

```tsx
<Card>
  <CardContent className="py-8 text-center">
    <div className={errorStateStyles.banner}>
      {error}
    </div>
    <div className="mt-4">
      <Button onClick={retry}>Try Again</Button>
    </div>
  </CardContent>
</Card>
```

#### Error in Form

```tsx
<div className="space-y-2">
  <Input />
  {error && (
    <p className="text-xs text-red-600">
      {error}
    </p>
  )}
</div>
```

### Success State

Used to confirm successful actions.

```typescript
export const successStateStyles = {
  banner: 'bg-verde-claro/10 border border-verde-claro/30 text-verde px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-verde-claro',
  text: 'text-sm',
}
```

#### Success Banner

```tsx
import { successStateStyles } from '@/styles'

<div className={successStateStyles.banner}>
  Operation completed successfully
</div>
```

#### Success with Icon

```tsx
<div className={successStateStyles.banner}>
  <div className="flex items-center gap-2">
    <CheckCircle2 className={successStateStyles.icon} />
    <span>Saved successfully</span>
  </div>
</div>
```

#### Success Toast

```tsx
import { toast } from 'sonner'

toast.success('Operation completed successfully', {
  description: 'The data was saved correctly'
})
```

### Warning State

Used for alerts and warnings.

```typescript
export const warningStateStyles = {
  banner: 'bg-yellow-50 border border-yellow-200 text-yellow-800 px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-yellow-600',
  text: 'text-sm',
}
```

#### Warning Banner

```tsx
import { warningStateStyles } from '@/styles'

<div className={warningStateStyles.banner}>
  Warning: This action cannot be undone
</div>
```

#### Warning with Icon

```tsx
<div className={warningStateStyles.banner}>
  <div className="flex items-center gap-2">
    <AlertTriangle className={warningStateStyles.icon} />
    <span>Warning: This action cannot be undone</span>
  </div>
</div>
```

### Info State

Used for informative messages.

```typescript
export const infoStateStyles = {
  banner: 'bg-azul/10 border border-azul/30 text-verde px-4 py-3 rounded-lg',
  icon: 'w-4 h-4 text-azul',
  text: 'text-sm',
}
```

#### Info Banner

```tsx
import { infoStateStyles } from '@/styles'

<div className={infoStateStyles.banner}>
  Important information about this feature
</div>
```

#### Info with Icon

```tsx
<div className={infoStateStyles.banner}>
  <div className="flex items-center gap-2">
    <Info className={infoStateStyles.icon} />
    <span>Important information</span>
  </div>
</div>
```

### Read-Only Banner

Used to indicate that a resource is in read-only mode.

```typescript
export const readOnlyBannerStyles = {
  container: 'bg-azul/10 border border-azul/30 text-verde px-4 py-3 rounded-lg flex items-center gap-2',
  icon: 'w-4 h-4 text-azul',
  text: 'text-sm font-medium',
}
```

#### Usage

```tsx
import { readOnlyBannerStyles } from '@/styles'

<div className={readOnlyBannerStyles.container}>
  <Lock className={readOnlyBannerStyles.icon} />
  <span className={readOnlyBannerStyles.text}>
    This resource is in read-only mode
  </span>
</div>
```

## Validation States

### Validation Progress

Validation progress indicator.

```typescript
export const validationProgressStyles = {
  container: 'flex items-center gap-4',
  bar: 'flex-1 h-2 bg-areia/30 rounded-full overflow-hidden',
  fill: 'h-full bg-verde-claro transition-all duration-300',
  text: 'text-sm text-verde whitespace-nowrap',
}
```

#### Usage

```tsx
import { validationProgressStyles } from '@/styles'

<div className={validationProgressStyles.container}>
  <div className={validationProgressStyles.bar}>
    <div 
      className={validationProgressStyles.fill}
      style={{ width: `${progress}%` }}
    />
  </div>
  <span className={validationProgressStyles.text}>
    {validated}/{total} validated
  </span>
</div>
```

## Combined States

### Loading with Empty State

```tsx
{loading ? (
  <div className="flex items-center justify-center py-12">
    <div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
  </div>
) : items.length === 0 ? (
  <div className="py-12 text-center text-verde/60">
    <Icon className="w-12 h-12 mx-auto mb-4 opacity-30" />
    <p className="text-sm">No items found</p>
  </div>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

### Error with Retry

```tsx
{error ? (
  <Card>
    <CardContent className="py-8 text-center">
      <div className={errorStateStyles.banner}>
        {error}
      </div>
      <div className="mt-4">
        <Button onClick={retry}>Try Again</Button>
      </div>
    </CardContent>
  </Card>
) : (
  <div className="space-y-4">
    {items.map(item => ...)}
  </div>
)}
```

## States in Specific Components

### Clause State

```tsx
{clause.validated ? (
  <div className="border-verde-claro/50 bg-verde-claro/5">
    Validated clause
  </div>
) : (
  <div className="border-areia/30">
    Pending clause
  </div>
)}
```

### Event State

```tsx
{event.validated ? (
  <div className="border-verde-claro/50 bg-verde-claro/5">
    Validated event
  </div>
) : event.errors.length > 0 ? (
  <div className="border-red-300 bg-red-50">
    Event with errors
  </div>
) : (
  <div className="border-areia/30">
    Pending event
  </div>
)}
```

## Icons by State

### Recommended Icons

- **Loading**: `Loader2` (with spin animation)
- **Error**: `AlertCircle`, `XCircle`
- **Success**: `CheckCircle2`, `Check`
- **Warning**: `AlertTriangle`, `AlertCircle`
- **Info**: `Info`, `InfoCircle`
- **Empty**: `Inbox`, `FileX`, `FolderOpen`
- **Read-Only**: `Lock`

### Icon Usage

```tsx
import { 
  Loader2, 
  AlertCircle, 
  CheckCircle2, 
  AlertTriangle, 
  Info,
  Lock 
} from 'lucide-react'

// Loading
<Loader2 className="w-4 h-4 animate-spin" />

// Error
<AlertCircle className="w-4 h-4 text-red-600" />

// Success
<CheckCircle2 className="w-4 h-4 text-verde-claro" />

// Warning
<AlertTriangle className="w-4 h-4 text-yellow-600" />

// Info
<Info className="w-4 h-4 text-azul" />

// Read-Only
<Lock className="w-4 h-4 text-azul" />
```

## References

- State styles: `frontend/src/styles/states.ts`
- UI components: `frontend/src/components/ui/`
- Icons: `lucide-react`

