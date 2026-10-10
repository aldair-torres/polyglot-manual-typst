// Public API of the polyglot-manual template package. Every name imported
// below is re-exported, so callers can import the whole API from this file.
//
// Main (from "polyglot-manual.typ"):
//   polyglot-manual       the document show rule
//   badge-texts           default badge text per language code (for `badge: auto`)
//   cjk-fonts             default CJK fallback font per language code
//   is-cjk                whether a string contains CJK script characters
//
// Admonitions (from "admonitions.typ"):
//   note, tip, important, restriction, caution, warning, danger
//   admonition            generic constructor (kind:, title:, breakable:)
//   admonition-kinds      per-kind policy (icon, severity, bar width)
//
// Localized callout labels (from "admonition-labels.typ"):
//   admonition-labels     label table keyed by language code
//   admonition-label      label lookup for a language code and kind
//
// Helpers (from "additional-functions.typ"):
//   menuCascade           breadcrumb-style menu paths
//   inlineIcon            small icons aligned with the text baseline
//   build-options         the active build options state (advanced)
//
// Colors (from "theme-colors.typ"):
//   document-palette      theme colors (text, badges, tables, quotes, code)
//   admonition-palette    per-kind colors for the "color" and "bw" modes
//
// Typical use:
//   #import "@preview/polyglot-manual:0.1.0": polyglot-manual, note, tip, important, restriction, caution, warning, danger

#import "polyglot-manual.typ": polyglot-manual, badge-texts, cjk-fonts, is-cjk
#import "admonitions.typ": admonition, admonition-kinds, note, tip, important, restriction, caution, warning, danger
#import "admonition-labels.typ": admonition-labels, admonition-label
#import "additional-functions.typ": (
  build-options,
  menuCascade,
  inlineIcon,
)
#import "theme-colors.typ": document-palette, admonition-palette
