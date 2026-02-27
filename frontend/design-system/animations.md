# Animations and Transitions — Shema Design System

## Animation System

The application uses smooth animations and consistent transitions to improve user experience.

## Keyframes

### Fade In

Fade in animation with vertical movement.

```css
@keyframes fade-in {
  0% {
    opacity: 0;
    transform: translateY(10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'fade-in': {
    '0%': { opacity: '0', transform: 'translateY(10px)' },
    '100%': { opacity: '1', transform: 'translateY(0)' },
  },
}
```

#### Usage

```tsx
<div className="animate-fade-in">...</div>
```

### Slide In

Slide in animation from the left.

```css
@keyframes slide-in {
  0% {
    opacity: 0;
    transform: translateX(-10px);
  }
  100% {
    opacity: 1;
    transform: translateX(0);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'slide-in': {
    '0%': { opacity: '0', transform: 'translateX(-10px)' },
    '100%': { opacity: '1', transform: 'translateX(0)' },
  },
}
```

#### Usage

```tsx
<div className="animate-slide-in">...</div>
```

### Pulse Soft

Soft pulse animation.

```css
@keyframes pulse-soft {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.7;
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'pulse-soft': {
    '0%, 100%': { opacity: '1' },
    '50%': { opacity: '0.7' },
  },
}
```

#### Usage

```tsx
<div className="animate-pulse-soft">...</div>
```

### Bounce Subtle

Subtle bounce animation.

```css
@keyframes bounce-subtle {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-3px);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'bounce-subtle': {
    '0%, 100%': { transform: 'translateY(0)' },
    '50%': { transform: 'translateY(-3px)' },
  },
}
```

#### Usage

```tsx
<div className="animate-bounce-subtle">...</div>
```

### Celebrate

Celebration animation (scale).

```css
@keyframes celebrate {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}
```

#### Tailwind Configuration

```javascript
keyframes: {
  'celebrate': {
    '0%': { transform: 'scale(1)' },
    '50%': { transform: 'scale(1.1)' },
    '100%': { transform: 'scale(1)' },
  },
}
```

#### Usage

```tsx
<div className="animate-celebrate">...</div>
```

## Configured Animations

### Fade In

```javascript
animation: {
  'fade-in': 'fade-in 0.3s ease-out',
}
```

#### Usage

```tsx
<div className="animate-fade-in">...</div>
```

### Slide In

```javascript
animation: {
  'slide-in': 'slide-in 0.3s ease-out',
}
```

#### Usage

```tsx
<div className="animate-slide-in">...</div>
```

### Pulse Soft

```javascript
animation: {
  'pulse-soft': 'pulse-soft 2s ease-in-out infinite',
}
```

#### Usage

```tsx
<div className="animate-pulse-soft">...</div>
```

### Bounce Subtle

```javascript
animation: {
  'bounce-subtle': 'bounce-subtle 0.5s ease-in-out',
}
```

#### Usage

```tsx
<div className="animate-bounce-subtle">...</div>
```

### Celebrate

```javascript
animation: {
  'celebrate': 'celebrate 0.4s ease-in-out',
}
```

#### Usage

```tsx
<div className="animate-celebrate">...</div>
```

## Transitions

### Default Duration

The application uses a default duration of **200ms** for most transitions.

### Hover Transitions

```tsx
// Card with hover
<div className="transition-all duration-200 hover:shadow-md hover:border-telha/30">
  ...
</div>

// Button with hover
<button className="transition-all duration-200 hover:bg-telha-dark">
  ...
</button>
```

### State Transitions

```tsx
// Element with color transition
<div className="transition-colors duration-200 hover:bg-areia/20">
  ...
</div>

// Element with scale transition
<button className="transition-transform duration-200 active:scale-[0.98]">
  ...
</button>
```

### Opacity Transitions

```tsx
// Element with fade
<div className="transition-opacity duration-200 hover:opacity-80">
  ...
</div>
```

## Loading Animations

### Spinner

```tsx
<div className="animate-spin w-8 h-8 border-4 border-telha border-t-transparent rounded-full" />
```

### Small Spinner

```tsx
<div className="animate-spin w-4 h-4 border-2 border-telha border-t-transparent rounded-full" />
```

### Spinner with Text

```tsx
<div className="flex items-center gap-2">
  <div className="animate-spin w-4 h-4 border-2 border-telha border-t-transparent rounded-full" />
  <span>Loading...</span>
</div>
```

## Entrance Animations

### Fade In in List

```tsx
{items.map((item, index) => (
  <div 
    key={item.id}
    className="animate-fade-in"
    style={{ animationDelay: `${index * 0.1}s` }}
  >
    ...
  </div>
))}
```

### Slide In in Modal

```tsx
<Dialog>
  <DialogContent className="animate-slide-in">
    ...
  </DialogContent>
</Dialog>
```

## Interaction Animations

### Button with Scale

```tsx
<Button className="active:scale-[0.98]">
  Button
</Button>
```

### Card with Hover

```tsx
<Card className="transition-all duration-200 hover:shadow-md hover:border-telha/30">
  ...
</Card>
```

### Badge with Pulse

```tsx
<Badge className="animate-pulse-soft">
  New
</Badge>
```

## Validation Animations

### Celebration on Validation

```tsx
{isValidated && (
  <div className="animate-celebrate">
    <CheckCircle2 className="w-5 h-5 text-verde-claro" />
  </div>
)}
```

### Bounce on Completion

```tsx
{isCompleted && (
  <div className="animate-bounce-subtle">
    <CheckCircle2 className="w-5 h-5 text-verde-claro" />
  </div>
)}
```

## Custom CSS Classes

### Animate In

```css
.animate-in {
  animation: fade-in 0.3s ease-out;
}
```

#### Usage

```tsx
<div className="animate-in">...</div>
```

### Slide In Left

```css
.slide-in-left {
  animation: slide-in 0.3s ease-out;
}
```

#### Usage

```tsx
<div className="slide-in-left">...</div>
```

## Performance

### Optimizations

- Use `transform` and `opacity` for animations (GPU-accelerated)
- Avoid animating `width`, `height`, `top`, `left` (causes reflow)
- Use `will-change` carefully (only when necessary)

### Optimized Example

```tsx
// ✅ Good - uses transform
<div className="transition-transform duration-200 hover:scale-105">
  ...
</div>

// ❌ Avoid - animates width
<div className="transition-all duration-200 hover:w-full">
  ...
</div>
```

## User Preferences

### Reduce Motion

Respect the user preference for reduced animations:

```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

## References

- Tailwind configuration: `frontend/tailwind.config.js`
- CSS styles: `frontend/src/styles/main.css`

