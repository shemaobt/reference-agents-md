# Typography — Shema Design System

## Font Families

The typography system is defined in [tokens/typography.json](./tokens/typography.json), which is the authoritative source.

### Montserrat — Primary Font (UI)

**Usage**: Entire interface (buttons, navigation, labels, headings, forms)

```css
font-family: 'Montserrat', system-ui, -apple-system, sans-serif;
```

> [!IMPORTANT]
> **Montserrat is exclusive for UI**. Use Montserrat for all interface elements: buttons, menus, navigation, card titles, form labels, badges, and any interactive element.

### Merriweather — Secondary Font (Reading)

**Usage**: Long-form text, biblical content, continuous reading

```css
font-family: 'Merriweather', Georgia, serif;
```

> [!IMPORTANT]
> **Merriweather is exclusive for reading contexts**. Use Merriweather only for continuous reading text, especially biblical content and extensive passages.

### Tailwind Configuration

```javascript
fontFamily: {
  sans: ['Montserrat', 'system-ui', '-apple-system', 'sans-serif'],
  serif: ['Merriweather', 'Georgia', 'serif'],
}
```

### Hebrew Text Font

For Hebrew text, use a serif font with RTL direction:

```css
.hebrew-text {
  font-family: serif;
  text-align: right;
  direction: rtl;
  font-size: 1.125rem; /* text-lg */
  line-height: 1.75;    /* leading-relaxed */
}
```

## Font Weights

Available weights:

| Class | Weight | Usage |
|--------|------|-----|
| `font-normal` | 400 | Default text, body, reading |
| `font-medium` | 500 | Labels, badges, subtle emphasis |
| `font-semibold` | 600 | Card titles, subtitles |
| `font-bold` | 700 | Main headings, strong emphasis |

## Type Scale

### Web Scale

| Style | Font Family | Weight | Size | Line Height | Usage |
|-------|-------------|--------|------|-------------|-------|
| `h1` | Montserrat | 700 | 32px | 1.2 | Main page titles |
| `h2` | Montserrat | 700 | 24px | 1.3 | Section headings |
| `h3` | Montserrat | 600 | 20px | 1.4 | Card titles, subsections |
| `body` | Montserrat | 400 | 16px | 1.5 | Default UI text |
| `body_serif` | Merriweather | 400 | 16px | 1.6 | Reading contexts |
| `caption` | Montserrat | 500 | 12px | 1.5 | Labels, hints, badges |

### App Scale (Flutter)

| Style | Font Family | Weight | Size | Flutter Style |
|-------|-------------|--------|------|---------------|
| `display` | Montserrat | 700 | 28px | headlineMedium |
| `title` | Montserrat | 700 | 20px | titleLarge |
| `body` | Montserrat | 400 | 16px | bodyMedium |
| `label` | Montserrat | 500 | 14px | labelLarge |

## Tailwind Size Classes

| Class | Size | Line Height | Usage |
|--------|---------|-------------|-----|
| `text-xs` | 0.75rem (12px) | 1rem | Small labels, badges, hints |
| `text-sm` | 0.875rem (14px) | 1.25rem | Secondary text, descriptions, inputs |
| `text-base` | 1rem (16px) | 1.5rem | Default body text |
| `text-lg` | 1.125rem (18px) | 1.75rem | Hebrew text, highlights, subtitles |
| `text-xl` | 1.25rem (20px) | 1.75rem | Card titles, section subtitles |
| `text-2xl` | 1.5rem (24px) | 2rem | Page titles, main headers |
| `text-3xl` | 1.875rem (30px) | 2.25rem | Hero titles, large titles |
| `text-4xl` | 2.25rem (36px) | 2.5rem | Large headers (mobile hero) |

## Line Height

| Class | Value | Usage |
|--------|-------|-----|
| `leading-none` | 1 | Very compact headings |
| `leading-tight` | 1.25 | Headings, headers |
| `leading-snug` | 1.375 | Subtitles |
| `leading-normal` | 1.5 | Default UI text |
| `leading-relaxed` | 1.75 | Hebrew text, reading, long paragraphs |
| `leading-loose` | 2 | Very spaced text |

## Letter Spacing

| Class | Value | Usage |
|--------|-------|-----|
| `tracking-tighter` | -0.05em | Large display headings |
| `tracking-tight` | -0.025em | Normal headings |
| `tracking-normal` | 0 | Default (most cases) |
| `tracking-wide` | 0.025em | Labels, badges, uppercase |
| `tracking-wider` | 0.05em | Spaced headers |
| `tracking-widest` | 0.1em | Decorative headings |

## Typography Hierarchy

### Page Title

```tsx
<h1 className="text-2xl font-bold text-preto flex items-center gap-2">
  <Icon className="w-5 h-5 text-telha" />
  Page Title
</h1>
```

**Font**: Montserrat Bold 24px, text-preto

### Card Title

```tsx
<CardTitle className="text-xl font-semibold leading-none tracking-tight text-preto">
  Card Title
</CardTitle>
```

**Font**: Montserrat Semibold 20px, text-preto

### Description

```tsx
<CardDescription className="text-sm text-verde">
  Card or section description
</CardDescription>
```

**Font**: Montserrat Regular 14px, text-verde

### Body Text (UI)

```tsx
<p className="text-base text-preto leading-normal">
  Application body text
</p>
```

**Font**: Montserrat Regular 16px, text-preto

### Reading Content (Biblical Content)

```tsx
<div className="font-serif text-base leading-relaxed text-preto">
  <p>
    In the beginning, God created the heavens and the earth...
  </p>
</div>
```

**Font**: Merriweather Regular 16px, leading-relaxed, text-preto

### Secondary Text

```tsx
<p className="text-sm text-verde">
  Secondary or descriptive text
</p>
```

**Font**: Montserrat Regular 14px, text-verde

### Labels and Hints

```tsx
<label className="text-sm font-medium text-preto">
  Field Label
</label>
<span className="text-xs text-verde/60">
  Hint or help
</span>
```

**Font**: Montserrat Medium/Regular, text-xs or text-sm

## Text Styles

### Decoration

```tsx
// Underlined (links)
<a className="underline underline-offset-4">Link</a>

// Strikethrough
<span className="line-through">Strikethrough text</span>

// No decoration
<span className="no-underline">No decoration text</span>
```

### Transformation

```tsx
// Uppercase
<span className="uppercase">UPPERCASE TEXT</span>

// Lowercase
<span className="lowercase">lowercase text</span>

// Capitalize
<span className="capitalize">capitalized text</span>
```

### Alignment

```tsx
// Left (default)
<p className="text-left">...</p>

// Center
<p className="text-center">...</p>

// Right
<p className="text-right">...</p>

// Justified
<p className="text-justify">...</p>
```

## Truncation and Overflow

```tsx
// Truncate with ellipsis
<p className="truncate">Very long text that will be truncated...</p>

// Break words
<p className="break-words">Text that breaks long words</p>

// Break all
<p className="break-all">Text that breaks anywhere</p>
```

## Antialiasing

The application uses antialiasing to improve font rendering:

```css
body {
  font-smoothing: antialiased;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

## Font Features

Advanced typographic features are enabled:

```css
body {
  font-feature-settings: "rlig" 1, "calt" 1;
}
```

- `rlig`: Required ligatures
- `calt`: Contextual alternates

## Text Colors

### Primary Colors

```tsx
// Primary text (Shema Black)
<p className="text-preto">Primary text</p>

// Secondary text (Shema Dark Green)
<p className="text-verde">Secondary text</p>

// Muted text
<p className="text-verde/60">Muted text</p>

// Text on primary button
<button className="text-white">Button</button>
```

### Semantic Colors

```tsx
// Success
<p className="text-verde-claro">Success text</p>

// Error
<p className="text-red-600">Error text</p>

// Warning
<p className="text-yellow-600">Warning text</p>

// Info
<p className="text-azul">Informative text</p>
```

## Component Examples

### CardTitle (Montserrat)

```tsx
<CardTitle className="text-xl font-semibold leading-none tracking-tight text-preto">
  Card Title
</CardTitle>
```

### CardDescription (Montserrat)

```tsx
<CardDescription className="text-sm text-verde">
  Card description
</CardDescription>
```

### Page Header (Montserrat)

```tsx
<div className="text-2xl font-bold text-preto flex items-center gap-2">
  <Icon className="w-5 h-5 text-telha" />
  Page Title
</div>
<p className="text-verde mt-1">Subtitle or description</p>
```

### Reading Content (Merriweather)

```tsx
<div className="prose prose-lg">
  <p className="font-serif text-base leading-relaxed text-preto">
    This is an example of long text for continuous reading. 
    The Merriweather font is optimized for on-screen reading and 
    provides a comfortable experience even with extensive texts.
  </p>
</div>
```

## References

- Design tokens: [tokens/typography.json](./tokens/typography.json)
- Brand guidelines: [AGENTS.md](./AGENTS.md)
- Tailwind config: `frontend/tailwind.config.js`
- Global styles: `frontend/src/styles/main.css`
- UI components: `frontend/src/components/ui/`
