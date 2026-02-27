# UI Components — Shema Design System

## Component System

The application uses base components built with Radix UI, Tailwind CSS, and class-variance-authority (cva).

## Component Structure

All components follow this pattern:

```tsx
import * as React from "react"
import { cn } from "@/utils/cn"
import { cva, type VariantProps } from "class-variance-authority"

// Variants using cva
const componentVariants = cva(
  "base-classes",
  {
    variants: {
      variant: { ... },
      size: { ... },
    },
    defaultVariants: { ... }
  }
)

// Props interface
export interface ComponentProps
  extends React.HTMLAttributes<HTMLElement>,
    VariantProps<typeof componentVariants> {
  // additional props
}

// Component
const Component = React.forwardRef<HTMLElement, ComponentProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <element
        ref={ref}
        className={cn(componentVariants({ variant, size, className }))}
        {...props}
      />
    )
  }
)

Component.displayName = "Component"

export { Component, componentVariants }
```

## Progress Step

Component for displaying step progress in a process or flow. Supports horizontal (desktop) and vertical (mobile) layouts.

### States

- **completed**: Completed step (light green with checkmark)
- **current**: Current step (telha with number and pulse animation)
- **pending**: Pending step (areia/30 with number)

### Base Styles

#### Progress Step Container

```typescript
ProgressStepContainer: "bg-white rounded-xl border border-areia/30 shadow-sm p-6 md:p-8"
ProgressStepTitle: "text-xl font-semibold text-preto mb-6 flex items-center gap-2"
```

#### Step Circle (Step Icon)

**Mobile (w-10 h-10):**
```typescript
// Completed
"w-10 h-10 rounded-full bg-verde-claro flex items-center justify-center text-white"

// Current
"w-10 h-10 rounded-full bg-telha flex items-center justify-center text-white font-semibold animate-pulse"

// Pending
"w-10 h-10 rounded-full bg-areia/30 flex items-center justify-center text-verde font-semibold"
```

**Desktop (w-12 h-12):**
```typescript
// Completed
"w-12 h-12 rounded-full bg-verde-claro flex items-center justify-center text-white mb-3"

// Current
"w-12 h-12 rounded-full bg-telha flex items-center justify-center text-white font-semibold mb-3 animate-pulse"

// Pending
"w-12 h-12 rounded-full bg-areia/30 flex items-center justify-center text-verde font-semibold mb-3"
```

#### Connectors (Lines between steps)

**Mobile (vertical):**
```typescript
// Completed connector
"w-0.5 h-12 bg-verde-claro mt-2"

// Pending connector
"w-0.5 h-12 bg-areia/50 mt-2"
```

**Desktop (horizontal):**
```typescript
// Completed connector
"flex-1 h-1 bg-verde-claro mx-2 -mt-8"

// Pending connector
"flex-1 h-1 bg-areia/50 mx-2 -mt-8"
```

#### Step Texts

**Mobile:**
```typescript
StepTitle: "font-semibold text-preto"
StepTitlePending: "font-semibold text-verde/60"
StepStatus: "text-sm text-verde mt-1"
StepStatusCurrent: "text-sm text-telha mt-1"
StepStatusPending: "text-sm text-verde/50 mt-1"
```

**Desktop:**
```typescript
StepTitle: "font-semibold text-preto text-center"
StepTitlePending: "font-semibold text-verde/60 text-center"
StepStatus: "text-sm text-verde mt-1 text-center"
StepStatusCurrent: "text-sm text-telha mt-1 text-center"
StepStatusPending: "text-sm text-verde/50 mt-1 text-center"
```

### Layout Mobile (Vertical)

```tsx
<div className="flex flex-col md:hidden space-y-4">
  {steps.map((step, index) => (
    <div key={index} className="flex items-start gap-4">
      <div className="flex flex-col items-center">
        <div className={stepCircleClasses[step.status]}>
          {step.status === 'completed' ? (
            <CheckIcon className="w-5 h-5" />
          ) : (
            <span>{step.number}</span>
          )}
        </div>
        {index < steps.length - 1 && (
          <div className={connectorClasses[step.status]} />
        )}
      </div>
      <div className="flex-1 pt-2">
        <p className={stepTitleClasses[step.status]}>
          {step.title}
        </p>
        <p className={stepStatusClasses[step.status]}>
          {step.statusText}
        </p>
      </div>
    </div>
  ))}
</div>
```

### Layout Desktop (Horizontal)

```tsx
<div className="hidden md:flex items-center justify-between">
  {steps.map((step, index) => (
    <>
      <div key={index} className="flex flex-col items-center flex-1">
        <div className={stepCircleClasses[step.status]}>
          {step.status === 'completed' ? (
            <CheckIcon className="w-6 h-6" />
          ) : (
            <span>{step.number}</span>
          )}
        </div>
        <p className={stepTitleClasses[step.status]}>
          {step.title}
        </p>
        <p className={stepStatusClasses[step.status]}>
          {step.statusText}
        </p>
      </div>
      {index < steps.length - 1 && (
        <div className={connectorClasses[step.status]} />
      )}
    </>
  ))}
</div>
```

### Spacing

- **Container padding**: `p-6 md:p-8` (24px mobile, 32px desktop)
- **Gap between steps (mobile)**: `space-y-4` (16px vertical)
- **Gap between step and content (mobile)**: `gap-4` (16px horizontal)
- **Title margin bottom**: `mb-6` (24px)
- **Status margin top**: `mt-1` (4px)
- **Content padding top (mobile)**: `pt-2` (8px)
- **Circle margin bottom (desktop)**: `mb-3` (12px)
- **Connector horizontal margin (desktop)**: `mx-2` (8px)
- **Connector negative top margin (desktop)**: `-mt-8` (-32px to align with circle)

### Full Usage

```tsx
<section className="bg-white rounded-xl border border-areia/30 shadow-sm p-6 md:p-8">
  <h2 className="text-xl font-semibold text-preto mb-6 flex items-center gap-2">
    <ListChecksIcon className="w-5 h-5 text-telha" />
    Project Progress
  </h2>
  
  <div className="relative">
    {/* Mobile Layout */}
    <div className="flex flex-col md:hidden space-y-4">
      {/* Steps here */}
    </div>
    
    {/* Desktop Layout */}
    <div className="hidden md:flex items-center justify-between">
      {/* Steps here */}
    </div>
  </div>
</section>
```

## Button

### Variants

```typescript
variant: {
  default: "bg-telha text-white hover:bg-telha-dark shadow-md hover:shadow-lg",
  secondary: "bg-azul text-white hover:bg-azul/90",
  outline: "border-2 border-areia bg-transparent hover:bg-areia/20 text-preto",
  ghost: "hover:bg-areia/20 text-preto",
  success: "bg-verde-claro text-white hover:bg-verde",
  destructive: "bg-red-500 text-white hover:bg-red-600",
  link: "text-telha underline-offset-4 hover:underline",
}
```

### Sizes

```typescript
size: {
  default: "h-10 px-4 py-2",
  sm: "h-9 rounded-md px-3",
  lg: "h-12 rounded-lg px-8 text-base",
  icon: "h-10 w-10",
}
```

### Usage

```tsx
import { Button } from '@/components/ui/button'

// Default button
<Button>Click here</Button>

// Secondary button
<Button variant="secondary">Secondary</Button>

// Outline button
<Button variant="outline">Outline</Button>

// Ghost button
<Button variant="ghost">Ghost</Button>

// Success button
<Button variant="success">Success</Button>

// Destructive button
<Button variant="destructive">Delete</Button>

// Link button
<Button variant="link">Link</Button>

// Sizes
<Button size="sm">Small</Button>
<Button size="default">Default</Button>
<Button size="lg">Large</Button>
<Button size="icon"><Icon /></Button>

// With icon
<Button>
  <Icon className="w-4 h-4 mr-2" />
  Text
</Button>
```

## Card

### Structure

```tsx
import { Card, CardHeader, CardTitle, CardDescription, CardContent, CardFooter } from '@/components/ui/card'

<Card>
  <CardHeader>
    <CardTitle>Title</CardTitle>
    <CardDescription>Description</CardDescription>
  </CardHeader>
  <CardContent>
    Content
  </CardContent>
  <CardFooter>
    Footer
  </CardFooter>
</Card>
```

### Styles

```typescript
Card: "rounded-xl border border-areia/30 bg-white shadow-sm transition-all duration-200 hover:shadow-md"
CardHeader: "flex flex-col space-y-1.5 p-6"
CardTitle: "text-xl font-semibold leading-none tracking-tight text-preto"
CardDescription: "text-sm text-verde"
CardContent: "p-6 pt-0"
CardFooter: "flex items-center p-6 pt-0"
```

### Usage

```tsx
<Card>
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card description</CardDescription>
  </CardHeader>
  <CardContent>
    <p>Card content</p>
  </CardContent>
  <CardFooter>
    <Button>Action</Button>
  </CardFooter>
</Card>
```

## Input

### Styles

```typescript
Input: "flex h-10 w-full rounded-lg border border-areia bg-white px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-verde/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-telha focus-visible:ring-offset-2 focus-visible:border-telha disabled:cursor-not-allowed disabled:opacity-50 transition-all duration-200"
```

### Usage

```tsx
import { Input } from '@/components/ui/input'

<Input type="text" placeholder="Type here..." />

<Input type="email" placeholder="email@example.com" />

<Input type="password" placeholder="Password" />

<Input disabled placeholder="Disabled" />
```

## Textarea

### Styles

Similar to Input, but with adjustable height.

### Usage

```tsx
import { Textarea } from '@/components/ui/textarea'

<Textarea placeholder="Type your message..." />

<Textarea rows={5} placeholder="Long text..." />
```

## Badge

See complete documentation in [Badges](./badges.md).

### Basic Usage

```tsx
import { Badge } from '@/components/ui/badge'

<Badge variant="default">Badge</Badge>
<Badge variant="success">Success</Badge>
<Badge variant="warning">Warning</Badge>
```

## Select / Dropdown

### Select Styles

```typescript
SelectContainer: "relative"
SelectTrigger: "w-full h-10 px-3 pr-8 rounded-lg border border-areia bg-white text-sm appearance-none focus:outline-none focus:ring-2 focus:ring-telha focus:border-telha transition-all duration-200"
SelectIcon: "w-4 h-4 absolute right-3 top-1/2 transform -translate-y-1/2 text-verde/50 pointer-events-none"
```

### Label with Default Spacing

```typescript
Label: "text-sm font-medium text-preto block mb-2"
```

The default spacing between label and input/select is **`mb-2`** (8px).

### Usage with Label

```tsx
<div className="w-full md:w-48">
  <label className="text-sm font-medium text-preto block mb-2">
    Period
  </label>
  <div className="relative">
    <select className="w-full h-10 px-3 pr-8 rounded-lg border border-areia bg-white text-sm appearance-none focus:outline-none focus:ring-2 focus:ring-telha focus:border-telha transition-all duration-200">
      <option>Last 7 days</option>
      <option>Last 30 days</option>
      <option>Last 90 days</option>
    </select>
    <ChevronDownIcon className="w-4 h-4 absolute right-3 top-1/2 transform -translate-y-1/2 text-verde/50 pointer-events-none" />
  </div>
</div>
```

### Usage with Radix UI Select

```tsx
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'

<div className="space-y-2">
  <label className="text-sm font-medium text-preto block mb-2">
    Select an option
  </label>
  <Select>
    <SelectTrigger className="w-full h-10">
      <SelectValue placeholder="Select..." />
    </SelectTrigger>
    <SelectContent>
      <SelectItem value="option1">Option 1</SelectItem>
      <SelectItem value="option2">Option 2</SelectItem>
      <SelectItem value="option3">Option 3</SelectItem>
    </SelectContent>
  </Select>
</div>
```

### Sizes and Spacing

- **Select height**: `h-10` (40px)
- **Horizontal padding**: `px-3` (12px)
- **Right padding (for icon)**: `pr-8` (32px)
- **Label → select spacing**: `mb-2` (8px)
- **Chevron icon**: `w-4 h-4` (16px)
- **Icon position**: `right-3` (12px from right)

## Dialog

### Usage

```tsx
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog'

<Dialog>
  <DialogTrigger asChild>
    <Button>Open Dialog</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Dialog Title</DialogTitle>
      <DialogDescription>
        Dialog description
      </DialogDescription>
    </DialogHeader>
    <div>
      Dialog content
    </div>
    <DialogFooter>
      <Button variant="outline">Cancel</Button>
      <Button>Confirm</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

## Alert Dialog

### Usage

```tsx
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle, AlertDialogTrigger } from '@/components/ui/alert-dialog'

<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Delete</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogHeader>
      <AlertDialogTitle>Confirm deletion</AlertDialogTitle>
      <AlertDialogDescription>
        This action cannot be undone.
      </AlertDialogDescription>
    </AlertDialogHeader>
    <AlertDialogFooter>
      <AlertDialogCancel>Cancel</AlertDialogCancel>
      <AlertDialogAction>Confirm</AlertDialogAction>
    </AlertDialogFooter>
  </AlertDialogContent>
</AlertDialog>
```

## Sheet

### Usage

```tsx
import { Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle, SheetTrigger } from '@/components/ui/sheet'

<Sheet>
  <SheetTrigger asChild>
    <Button>Open Sheet</Button>
  </SheetTrigger>
  <SheetContent>
    <SheetHeader>
      <SheetTitle>Title</SheetTitle>
      <SheetDescription>
        Description
      </SheetDescription>
    </SheetHeader>
    <div>
      Content
    </div>
  </SheetContent>
</Sheet>
```

## Progress

### Usage

```tsx
import { Progress } from '@/components/ui/progress'

<Progress value={33} />

<Progress value={66} className="h-2" />
```

## Usage Patterns

### Complete Form

```tsx
<Card>
  <CardHeader>
    <CardTitle>Form</CardTitle>
    <CardDescription>Fill in the fields below</CardDescription>
  </CardHeader>
  <CardContent>
    <form className="space-y-4">
      <div className="space-y-2">
        <label className="text-sm font-medium">Name</label>
        <Input placeholder="Enter your name" />
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium">Email</label>
        <Input type="email" placeholder="email@example.com" />
      </div>
      <div className="space-y-2">
        <label className="text-sm font-medium">Message</label>
        <Textarea placeholder="Type your message..." />
      </div>
    </form>
  </CardContent>
  <CardFooter>
    <Button variant="outline">Cancel</Button>
    <Button>Send</Button>
  </CardFooter>
</Card>
```

### List with Actions

```tsx
<Card>
  <CardHeader>
    <div className="flex items-center justify-between">
      <CardTitle>Items</CardTitle>
      <Button size="sm">
        <Plus className="w-4 h-4 mr-2" />
        Add
      </Button>
    </div>
  </CardHeader>
  <CardContent>
    <div className="space-y-2">
      {items.map(item => (
        <div key={item.id} className="flex items-center justify-between p-2 border rounded">
          <span>{item.name}</span>
          <div className="flex items-center gap-2">
            <Button variant="ghost" size="icon">
              <Edit className="w-4 h-4" />
            </Button>
            <Button variant="ghost" size="icon">
              <Trash className="w-4 h-4" />
            </Button>
          </div>
        </div>
      ))}
    </div>
  </CardContent>
</Card>
```

## References

- UI components: `frontend/src/components/ui/`
- Utilities: `frontend/src/utils/cn.ts`
- class-variance-authority: https://cva.style/

