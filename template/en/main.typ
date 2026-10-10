// Starter document for the polyglot-manual template — English master.
//
// This file only wires things together: it sets the output options, applies
// the `polyglot-manual()` theme, lays out the front matter, and includes the
// chapters from `content/`. The prose lives in `content/`, re-usable values in
// `snippets/`, and images in `images/` (see README.md).
//
// Build examples (every option can also be changed in the `#show` rule):
//   typst compile en/main.typ                                           // digital A4 (default)
//   typst compile --input media=printed en/main.typ                     // printed A5, black & white
//   typst compile --input media=printed --input paper=a4 en/main.typ    // printed A4
//   typst compile --input media=printed --input color=color en/main.typ // printed, full color
//   typst compile --input admonition-style=severity en/main.typ         // severity callouts
//   typst compile --input columns=1 en/main.typ                         // single-column layout

#import "@preview/polyglot-manual:0.1.0": polyglot-manual
#import "snippets/product.typ": product-name

// ─── Options ──────────────────────────────────────────────────────────────────
// Every `polyglot-manual()` option and its possible values:
//
//   media             "digital" (A4, single-sided, always full color) or
//                     "printed" (perfect-bound, duplex)
//   paper             printed only: "a5" or "a4"
//   color             printed only: "bw" or "color"
//   admonition-style  auto (tint on digital, bar on print), "bar", "tint", or
//                     "severity"
//   font              a family name, or a list of names for fallback, e.g.
//                     ("Source Sans 3", "Libertinus Serif")
//   cjk-font          auto (Noto Sans from `document-language-code`), none to disable,
//                     or a family name or list
//   document-language-code     this folder's language, e.g. "en", "ja", "ko",
//                     "zh-cn", "zh-tw"; also selects the callout labels
//   document-title    content shown in the footer (digital) or in the recto
//                     header (printed); the chapter runs on verso pages
//   badge             none, auto (CJK name, or the uppercased code), or a
//                     custom string of up to 5 characters
//   h1-pagebreak      true (default) starts every H1 on a new page, like a
//                     chapter; false lets chapters continue on the same page
//                     (e.g. to economize paper). Not usable inside a
//                     multi-column layout.
//   heading-numbering none (default), or a numbering pattern such as "1.1";
//                     numbers chapters and sections in the headings and the
//                     outline (1, 1.1, 1.1.1)
//   ref-form          "page" (default, renders @refs as "(page N)") or
//                     "normal" (Typst's standard "Section 2" / "Figure 3")
//   in-front-matter   state; while true, the running header, the footer
//                     title, and the language badge are hidden (used for
//                     legal pages and the outline)

// Output options, read from --input flags (with these defaults):
#let media = sys.inputs.at("media", default: "digital")   // "digital" or "printed"
#let paper = if media == "printed" { sys.inputs.at("paper", default: "a5") } else { auto }
#let color = if media == "printed" { sys.inputs.at("color", default: "bw") } else { auto }
#let admonition-style = sys.inputs.at("admonition-style", default: auto)
#let column-count = int(sys.inputs.at("columns", default: "2"))  // 1 or 2
#let in-front-matter = state("in-front-matter", false)

// H1 (chapter) page breaks cannot be used inside a multi-column container, so
// this document enables them for the single-column layout.
#let h1-pagebreak = column-count == 1

#show: polyglot-manual.with(
  media: media,
  paper: paper,
  color: color,
  admonition-style: admonition-style,
  // font: ("Source Sans 3", "Libertinus Serif"),   // family or fallback list
  // cjk-font: "Noto Serif CJK SC",                 // or `none` to disable
  document-language-code: "en",
  document-title: product-name + " — User Manual",
  badge: auto,
  h1-pagebreak: h1-pagebreak,
  // heading-numbering: "1.1",  // number chapters and sections (headings + outline)
  // ref-form: "normal",        // or "page" (default): "(page N)" references
  in-front-matter: in-front-matter,
)

// ─── Front matter ─────────────────────────────────────────────────────────────
// While `in-front-matter` is true, the running header, the footer title, and
// the language badge are hidden; the page number stays. The outline below is
// styled by the theme too.
//
// Page headers resolve the state at the start of the page, before updates that
// occur on it. Each update is therefore followed by a weak break (a no-op on
// a fresh page) so the header sees it immediately.
#in-front-matter.update(true)
#pagebreak(weak: true)

#include "content/00-legal-notice.typ"

#pagebreak()

#outline()

#pagebreak()
#in-front-matter.update(false)
#pagebreak(weak: true)

// ─── Chapters ─────────────────────────────────────────────────────────────────
// The chapters are included in reading order. Keep the same file names in
// every language folder so translations can be diffed against the master (see
// check-translations.sh in the project root).
//
// The content is wrapped in a multi-column container only when there is more
// than one column: chapter page breaks cannot sit inside such a container, so
// the single-column layout uses the page directly.
#let chapters = [
  #include "content/01-introduction.typ"
  #include "content/02-methods.typ"
  #include "content/03-going-further.typ"
]

#if column-count > 1 { columns(column-count, chapters) } else { chapters }
