// Theme colors: the document palette (`document-palette`) and the admonition
// palette (`admonition-palette`).

#let document-palette = (
  badge-bg: luma(92%),
  badge-text: rgb("#272727"),
  badge-print-bg: rgb("#272727"),
  badge-print-text: white,
  body-text: rgb("#272727"),
  link-text: rgb("#0000ff"),
  muted-text: rgb("#333333"),
  table-border: rgb("#666675"),
  table-header-bg: rgb("#d5d8db"),
  quote-bar: rgb("#c9ccd1"),
  quote-text: rgb("#5a5a5a"),
  code-bg: rgb("#f0f1f2"),
)

// Admonition palette per color mode. With "color" each type gets a distinct
// brand color; with "bw" they collapse to black/gray, for booklets produced
// without color printing. `tint` is the background used by the "tint" and
// "severity" admonition styles.
//
// The `caution`, `warning`, and `danger` colors follow the ISO 3864-2 safety
// palette; the other types are editorial and use the theme's own colors.
#let admonition-palette = (
  color: (
    note:        (text: rgb("#004F9D"), border: rgb("#0969da"), tint: rgb("#0969da").lighten(92%)),
    tip:         (text: rgb("#1B622F"), border: rgb("#2DA44E"), tint: rgb("#2DA44E").lighten(92%)),
    important:   (text: rgb("#673A98"), border: rgb("#8250df"), tint: rgb("#8250df").lighten(92%)),
    restriction: (text: rgb("#3C4653"), border: rgb("#64748B"), tint: rgb("#64748B").lighten(92%)),
    caution:     (text: rgb("#755000"), border: rgb("#F9A900"), tint: rgb("#F9A900").lighten(88%)),
    warning:     (text: rgb("#7D3819"), border: rgb("#D05D29"), tint: rgb("#D05D29").lighten(92%)),
    danger:      (text: rgb("#9B2423"), border: rgb("#9B2423"), tint: rgb("#9B2423").lighten(92%)),
  ),
  bw: (
    note:        (text: document-palette.body-text, border: luma(84%), tint: luma(96%)),
    tip:         (text: document-palette.body-text, border: luma(72%), tint: luma(96%)),
    important:   (text: document-palette.body-text, border: luma(60%), tint: luma(96%)),
    restriction: (text: document-palette.body-text, border: luma(48%), tint: luma(96%)),
    caution:     (text: document-palette.body-text, border: luma(36%), tint: luma(96%)),
    warning:     (text: document-palette.body-text, border: luma(24%), tint: luma(96%)),
    danger:      (text: document-palette.body-text, border: luma(12%), tint: luma(96%)),
  ),
)
