// The `polyglot-manual()` show rule and the output profiles it selects from:
// page geometry, type scale, header and footer layouts, and the styling of the
// shared elements (tables, quotes, code, references, the outline).
//
// The language maps defined here (`badge-texts`, `cjk-fonts`, `is-cjk`) are
// re-exported by `lib.typ` together with `polyglot-manual`.

#import "@preview/hydra:0.6.2": hydra
#import "./additional-functions.typ": build-options
#import "./theme-colors.typ": document-palette

// The default font for the document. Pass `font:` to `polyglot-manual()` to use another
// family, or a list of families for fallback (e.g. ("Source Sans 3",
// "Libertinus Serif")).
#let document-typeface = "Source Sans 3"

// Default CJK fallback font per language code, appended to the main font when
// the document language is CJK (see `polyglot-manual(cjk-font: auto)`). Override per
// document with `polyglot-manual(cjk-font: ...)`.
#let cjk-fonts = (
  "ja": "Noto Sans JP",
  "ko": "Noto Sans KR",
  "zh": "Noto Sans SC",
  "zh-cn": "Noto Sans SC",
  "zh-tw": "Noto Sans TC",
  "zh-hk": "Noto Sans HK",
)

// ─── Language badge ───────────────────────────────────────────────────────────
// Default badge text per language code, used when `polyglot-manual(badge: auto)`. Codes
// that aren't listed fall back to the uppercased code (e.g. "en" → "EN"). Users
// can pass any custom string as `badge` instead, for any language.
#let badge-texts = (
  "ja": "日本語",
  "ko": "한국어",
  "zh": "简体中文",
  "zh-cn": "简体中文",
  "zh-tw": "繁體中文",
  "zh-hk": "繁體中文",
)

// Detect CJK scripts (Hiragana, Katakana, CJK Unified Ideographs, Hangul
// syllables). CJK badge text is stacked in pairs of characters so that it fits
// inside the language box.
#let is-cjk(text) = text.clusters().any(c => {
  let cp = c.to-unicode()
  let kana = 0x3040 <= cp and cp <= 0x30FF
  let han = 0x4E00 <= cp and cp <= 0x9FFF
  let hangul = 0xAC00 <= cp and cp <= 0xD7AF
  kana or han or hangul
})

// ─── Style profiles ───────────────────────────────────────────────────────────
// All layout differences between the output forms live here, as pure data:
//
//   digital      A4, single-sided reading
//   printed.a5   A5 booklet, perfect-bound (duplex)
//   printed.a4   A4 perfect-bound manual (duplex) — same type scale as digital
//
// `polyglot-manual()` below only contains the structure the forms share, so a value can
// be tuned for one form without touching the others.

// Page geometry for one output form. The positional order is
// `paper, top, bottom, inner, outer, ascent, descent`: `inner`/`outer` are the
// horizontal margins on the binding and trim sides; with `binding: auto`
// (single-sided digital pages) they become plain left and right margins.
#let page-layout(paper, top, bottom, inner, outer, ascent, descent, binding: auto) = (
  paper: paper,
  margin: if binding == auto {
    (left: inner, right: outer, top: top, bottom: bottom)
  } else {
    (inside: inner, outside: outer, top: top, bottom: bottom)
  },
  binding: binding,
  header-ascent: ascent,
  footer-descent: descent,
)

#let profiles = (
  digital: (
    page: page-layout("a4", 1.53cm, 1.53cm, 1.25cm, 1.25cm, 0.8cm, 0.8cm),
    text-size: 11pt,
    par-leading: 0.70em,
    // Digital ink is near-black with blue links; the printed profiles use pure
    // black for text, running heads, footers, and links.
    text-color: document-palette.body-text,
    muted-color: document-palette.muted-text,
    link-color: document-palette.link-text,
    // Language box for the page corners. `width` is the visible width and
    // `bleed` the strip pushed past the trim edge (the page clips it, which
    // prevents a hairline of uncolored paper at the boundary). `fit-width` is
    // the widest a single-line label may be before the box hugs its text
    // instead; it is smaller than `width` because the box sits a little off the
    // page edge. `dx` is how far the box is pushed towards the outer edge.
    top-language-badge: (width: 4.2em, height: 2.8em, size: 12pt, cjk-size: 10pt, fit-width: 3.2em, dx: 3.7em, bleed: 0em, fill: document-palette.badge-bg, text: document-palette.badge-text),
    headings: (
      h1: (size: 26pt, weight: "semibold", below: 0.7em),
      h2: (size: 18pt, weight: "semibold"),
      h3: (size: 14pt, weight: "bold"),
      h4: (size: 12pt, weight: "bold", style: "italic"),
      h5: (size: 11pt, weight: "regular", style: "italic"),
    ),
    outline-entry: (above: 1.2em, size: 12pt),
    running-head-size: 9pt,
    footer-title-size: 9pt,
    page-number-size: 10pt,
  ),

  printed: (
    // ── A5 booklet, perfect-bound (duplex) ──────────────────────────────────
    a5: (
      page: page-layout("a5", 1.2cm, 1.2cm, 1.8cm, 1.0cm, 0.6cm, 0.6cm, binding: left),
      text-size: 8pt,
      par-leading: 0.65em,
      text-color: black,
      muted-color: black,
      link-color: black,
      // `fit-width` equals `width`: only the `bleed` strip goes past the trim.
      top-language-badge: (width: 3.5em, height: 2.4em, size: 10pt, cjk-size: 8pt, fit-width: 3.5em, dx: 1.0cm, bleed: 0.1cm, fill: document-palette.badge-print-bg, text: document-palette.badge-print-text),
      headings: (
        h1: (size: 17pt, weight: "bold", below: 0.6em),
        h2: (size: 12pt, weight: "semibold"),
        h3: (size: 10.5pt, weight: "bold"),
        h4: (size: 10pt, weight: "bold", style: "italic"),
        h5: (size: 9.5pt, weight: "regular", style: "italic"),
      ),
      outline-entry: (above: 1em, size: 10pt),
      running-head-size: 7pt,
      footer-title-size: 7pt,
      page-number-size: 8pt,
    ),

    // ── A4 perfect-bound manual (duplex) ────────────────────────────────────
    // Same type scale as the digital A4 profile, with two differences: a wider
    // inside (gutter) margin for the glued spine, and a language box that sits
    // flush with the outer trim edge (plus the small `bleed`).
    a4: (
      page: page-layout("a4", 1.53cm, 1.53cm, 2.0cm, 1.5cm, 0.8cm, 0.8cm, binding: left),
      text-size: 11pt,
      par-leading: 0.70em,
      text-color: black,
      muted-color: black,
      link-color: black,
      top-language-badge: (width: 4.2em, height: 2.8em, size: 12pt, cjk-size: 10pt, fit-width: 4.2em, dx: 1.5cm, bleed: 0.1cm, fill: document-palette.badge-print-bg, text: document-palette.badge-print-text),
      headings: (
        h1: (size: 26pt, weight: "semibold", below: 0.7em),
        h2: (size: 18pt, weight: "semibold"),
        h3: (size: 14pt, weight: "bold"),
        h4: (size: 12pt, weight: "bold", style: "italic"),
        h5: (size: 11pt, weight: "regular", style: "italic"),
      ),
      outline-entry: (above: 1.2em, size: 12pt),
      running-head-size: 9pt,
      footer-title-size: 9pt,
      page-number-size: 10pt,
    ),
  ),
)

// ─── Header and footer layouts ────────────────────────────────────────────────
// `p` is the active profile entry; its sizes and offsets are used below.
//
// Chapters keep the current chapter visible on every body page, including the
// page where that chapter starts (`skip-starting: false`), which hydra
// otherwise skips as redundant.
//
// Digital: the language box sits top right on body pages (it is hidden in front
// matter), the chapter runs centered in the header, and the document title and
// page number share the footer.
#let digital-header = (in-front-matter, top-language-badge, p) => context {
  if in-front-matter.get() { return [] }
  if top-language-badge != none {
    place(top + right, dx: p.top-language-badge.dx + p.top-language-badge.bleed, dy: 0em, top-language-badge)
  }
  align(center, text(hydra(1, skip-starting: false), size: p.running-head-size, fill: p.muted-color))
}

// One row of page furniture (running head or footer) with three slots. A slot
// passed as `none` becomes an empty cell, so the outer `1fr` columns keep the
// remaining items at the page edges.
#let furniture-row(left, center, right) = grid(
  columns: (1fr, auto, 1fr),
  ..(left, center, right).map(slot => if slot == none { [] } else { slot }),
)

#let digital-footer = (in-front-matter, document-title, p) => context {
  let page-num = counter(page).at(here()).first()
  furniture-row(
    if not in-front-matter.get() {
      align(left, text(size: p.footer-title-size, fill: p.muted-color)[#document-title])
    },
    none,
    align(right, text(size: p.page-number-size, str(page-num))),
  )
}

// Printed: the language box sits in the outer top corner of each body page (it
// is hidden in front matter). Recto (odd) pages carry the document title and
// verso (even) pages the chapter, on the side opposite the badge; the footer
// shows only the page number, on the outer edge.
#let printed-header = (in-front-matter, top-language-badge, document-title, p) => context {
  if in-front-matter.get() { return [] }
  let page-num = counter(page).at(here()).first()

  if top-language-badge != none {
    let outward = p.top-language-badge.dx + p.top-language-badge.bleed
    if calc.odd(page-num) {
      place(top + right, dx: outward, dy: 0em, top-language-badge)
    } else {
      place(top + left, dx: -outward, dy: 0em, top-language-badge)
    }
  }

  // Long running text must not reach the badge on the far side: reserve its
  // inner edge plus a small gap on that side.
  let badge-clearance = if top-language-badge == none {
    0pt
  } else {
    let intrusion = measure(top-language-badge).width - p.top-language-badge.dx - p.top-language-badge.bleed
    calc.max(0pt, intrusion) + 0.5em
  }

  if calc.odd(page-num) {
    // Recto: badge on the right, so the title starts on the left.
    block(width: 100%, inset: (right: badge-clearance), align(left, text(document-title, size: p.running-head-size, fill: p.muted-color)))
  } else {
    // Verso: badge on the left, so the chapter starts on the right.
    block(width: 100%, inset: (left: badge-clearance), align(right, text(hydra(1, skip-starting: false), size: p.running-head-size, fill: p.muted-color)))
  }
}

#let printed-footer = (p) => context {
  let page-num = counter(page).at(here()).first()
  furniture-row(
    if calc.even(page-num) {
      align(left, text(size: p.page-number-size, str(page-num))) // Page number on verso
    },
    none,
    if calc.odd(page-num) {
      align(right, text(size: p.page-number-size, str(page-num))) // Page number on recto
    },
  )
}

// ─── Content styling helpers ──────────────────────────────────────────────────
// Each helper takes the content to style and returns it with one group of
// rules in scope, so a rule set stays next to the palette values it consumes.
#let style-tables(border, header-bg, content) = {
  set table(
    stroke: 0.5pt + border,
    fill: (col, row) => if row == 0 { header-bg },
  )
  show table.cell.where(y: 0): it => {
    set text(weight: "semibold")
    it
  }
  content
}

// Block quotes: a muted left bar with italic, muted text. The default pads are
// cleared so the bar's inset controls the indentation instead.
#let style-block-quotes(bar, ink, content) = {
  show quote.where(block: true): set text(fill: ink, style: "italic")
  show quote.where(block: true): set pad(left: 0pt, right: 0pt)
  show quote.where(block: true): block.with(
    width: 100%,
    stroke: (left: 2.5pt + bar),
    inset: (x: 0.8em, y: 0.15em),
  )
  content
}

// Code blocks: a light rounded panel behind block-level raw text. Inline code
// keeps the default styling.
#let style-code(fill, content) = {
  show raw.where(block: true): block.with(
    fill: fill,
    inset: (x: 0.8em, y: 0.6em),
    radius: 3pt,
    width: 100%,
  )
  content
}

// Links take the profile's link color plus an underline. With `ref-form`
// "page" every `@label` is wrapped in parentheses around the resolved page
// number (e.g. "(page 5)"); "normal" keeps Typst's own reference rendering.
#let style-references(link-color, ref-form, content) = {
  show link: it => text(fill: link-color, underline(it))
  show ref: it => if ref-form == "page" { [(#it)] } else { it }
  content
}

// Outline: level-1 entries (chapters) are bold with a little air above them.
#let style-outline(p, content) = {
  show outline.entry.where(level: 1): it => {
    set block(above: p.outline-entry.above)
    set text(weight: "bold", size: p.outline-entry.size)
    it
  }
  content
}

// Numbered lists count "1.a.i."; a heading labeled `<hide-from-toc>` is kept
// out of the outline.
#let style-lists(content) = {
  set enum(numbering: "1.a.i.")
  show <hide-from-toc>: set heading(outlined: false)
  content
}

// The main function that formats the document.
//
// `media` picks the output form: "digital" (default) or "printed".
// `paper` and `color` apply to the printed form only (they are ignored for
// digital, which is always A4 in full color):
// - `paper`: `auto` (default) → "a5", or an explicit "a5"/"a4".
// - `color`: `auto` (default) → "bw", or an explicit "bw"/"color".
// `admonition-style` controls how much of each callout is colored (resolved in
// `admonitions.typ`): `auto` (default) gives "tint" for digital and "bar" for
// printed; pass "bar", "tint", or "severity" to force one.
// `font` is the document font: a family name, or a list of family names for
// fallback. Defaults to `document-typeface` ("Source Sans 3").
// `cjk-font` is the fallback font for CJK text: `auto` (default) picks the
// right Noto Sans family from the language code (JP/KR/SC/TC/HK), `none`
// disables that mapping, or pass a family name (or list) to use another font.
// `document-language-code` is the document language; it also selects the translated
// callout labels (see `admonition-labels.typ`).
// `document-title` is shown in the footer on digital profiles and in the
// running header of recto (odd) printed pages; the chapter runs in the header
// of verso (even) pages.
// `badge` controls the language box shown in the page header:
// - `none` (default): no badge,
// - `auto`: the default text for the language from `badge-texts`, falling back
//   to the uppercased language code,
// - a string: that custom text is shown instead. The badge is meant for
//   language codes, so it accepts at most 5 characters (e.g. "en", "fil", or
//   the locale code "zh-tw").
// `h1-pagebreak` (default `true`) starts every level-1 heading on a new page,
// like a chapter. Pass `false` to let chapters continue on the same page, for
// example to economize paper. It cannot be used inside a multi-column layout.
// `heading-numbering` (default `none`) numbers headings and outline entries.
// Pass a numbering pattern such as "1.1" to get chapter and section numbers
// (`1`, `1.1`, `1.1.1`, …).
// `ref-form` (default "page") controls how `@label` references render: "page"
// resolves them to the page number (`(page 5)` in the output), "normal" keeps
// Typst's standard form (`Section 2`, `Figure 3`).
// `in-front-matter` is a boolean state (default `false`) meant to be shared
// with the call site via `in-front-matter.update(...)`: while it is `true`,
// the running header, the footer title, and the language badge are hidden
// (used for legal pages and the outline); the page number stays. Headers
// resolve the state at the start of a page, so follow an update with a weak
// page break.
#let polyglot-manual(
  media: "digital",
  paper: auto,
  color: auto,
  admonition-style: auto,
  font: document-typeface,
  cjk-font: auto,
  document-language-code: "",
  document-title: "",
  badge: none,
  h1-pagebreak: true,
  heading-numbering: none,
  ref-form: "page",
  in-front-matter: state("in-front-matter", false),
  body,
) = {
  assert(
    media in ("digital", "printed"),
    message: "polyglot-manual(media:) expects \"digital\" or \"printed\", got " + repr(media) + ".",
  )
  assert(
    paper in (auto, "a5", "a4"),
    message: "polyglot-manual(paper:) expects auto, \"a5\", or \"a4\", got " + repr(paper) + ".",
  )
  assert(
    color in (auto, "bw", "color"),
    message: "polyglot-manual(color:) expects auto, \"bw\", or \"color\", got " + repr(color) + ".",
  )
  assert(
    admonition-style in (auto, "bar", "tint", "severity"),
    message: "polyglot-manual(admonition-style:) expects auto, \"bar\", \"tint\", or \"severity\", got " + repr(admonition-style) + ".",
  )
  assert(
    type(h1-pagebreak) == bool,
    message: "polyglot-manual(h1-pagebreak:) expects true or false, got " + repr(h1-pagebreak) + ".",
  )
  assert(
    heading-numbering == none or type(heading-numbering) in (str, function),
    message: "polyglot-manual(heading-numbering:) expects none or a numbering pattern such as \"1.1\", got " + repr(heading-numbering) + ".",
  )
  assert(
    ref-form in ("normal", "page"),
    message: "polyglot-manual(ref-form:) expects \"normal\" or \"page\", got " + repr(ref-form) + ".",
  )

  // Resolve the printed options (defaults: A5, black & white), then look up the
  // matching layout profile.
  let is-digital = media == "digital"
  let paper-size = if is-digital { "a4" } else if paper == auto { "a5" } else { paper }
  let color-mode = if is-digital { "color" } else if color == auto { "bw" } else { color }
  let p = if is-digital { profiles.digital } else { profiles.printed.at(paper-size) }

  // Let admonitions follow these choices.
  build-options.update((
    media: media,
    color: color-mode,
    admonition-style: admonition-style,
    language-code: document-language-code,
  ))

  // Resolve the badge text: `none` disables the badge entirely.
  let badge-text = if badge == none {
    none
  } else if badge == auto {
    badge-texts.at(document-language-code, default: upper(document-language-code))
  } else {
    badge
  }

  assert(
    badge-text == none or badge-text.clusters().len() <= 5,
    message: "The language badge accepts at most 5 characters. Use an ISO 639 code (e.g. \"en\" or \"fil\") or a locale code (e.g. \"zh-tw\") instead of a full word.",
  )

  let top-corner-language-badge = if badge-text == none {
    none
  } else {
    let clusters = badge-text.clusters()
    let label = if is-cjk(badge-text) and clusters.len() > 2 {
      stack(
        spacing: 3pt,
        ..clusters.chunks(2).map(chunk => text(fill: p.top-language-badge.text, size: p.top-language-badge.cjk-size, weight: "bold", chunk.join())),
      )
    } else {
      text(fill: p.top-language-badge.text, size: p.top-language-badge.size, weight: "bold", badge-text)
    }
    context {
      // Measuring in the same context resolves the `em` widths reliably.
      if measure(label).width <= measure(box(width: p.top-language-badge.fit-width)).width {
        box(
          fill: p.top-language-badge.fill,
          width: p.top-language-badge.width + p.top-language-badge.bleed,
          height: p.top-language-badge.height,
          stroke: none,
          align(center + horizon, label),
        )
      } else {
        box(
          fill: p.top-language-badge.fill,
          stroke: none,
          inset: (x: 0.5em, y: 0.6em),
          align(center + horizon, label),
        )
      }
    }
  }

  set ref(form: ref-form)

  let header = if is-digital {
    digital-header(in-front-matter, top-corner-language-badge, p)
  } else {
    printed-header(in-front-matter, top-corner-language-badge, document-title, p)
  }
  let footer = if is-digital {
    digital-footer(in-front-matter, document-title, p)
  } else {
    printed-footer(p)
  }

  set page(
    ..p.page,
    numbering: "1",
    header: header,
    footer: footer,
  )

  // Typst wants the language and region separately (e.g. "zh" + "cn" for
  // "zh-cn"), so split any regional code passed in.
  let text-args = if document-language-code == "" {
    (:)
  } else {
    let code-parts = document-language-code.split("-")
    (lang: code-parts.at(0), region: code-parts.at(1, default: none))
  }

  // Append the CJK fallback font (Noto Sans JP/KR/SC/TC/HK by default, picked
  // from the language code) so CJK text uses its own glyphs while Latin text
  // keeps the main font.
  let cjk-font-resolved = if cjk-font == auto {
    cjk-fonts.at(document-language-code, default: none)
  } else {
    cjk-font
  }
  let font-list = if cjk-font-resolved == none {
    font
  } else {
    let base = if type(font) == array { font } else { (font,) }
    let cjk = if type(cjk-font-resolved) == array { cjk-font-resolved } else { (cjk-font-resolved,) }
    base + cjk
  }

  set text(..text-args, font: font-list, size: p.text-size, hyphenate: true, fill: p.text-color)
  set par(leading: p.par-leading)

  show figure: it => {
    // Captioned figures: keep Typst's default layout
    // (centering, gap, placement, caption styling)
    if it.caption != none { return it }

    // Caption-less figures: auto-label "Figure N" under the body
    let numbering = if it.numbering == none { "1" } else { it.numbering }
    let out = align(center, block(breakable: false, {
      it.body
      v(it.gap)
      context [#it.supplement #it.counter.display(numbering)]
    }))
    if it.placement != none { place(it.placement, float: true, out) } else { out }
  }

  // Keep table captions on top.
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set block(breakable: true)

  // Headings. `heading-numbering` numbers chapters and sections; the outline
  // picks the numbers up automatically.
  set heading(numbering: heading-numbering)

  // Level 1 headings (e.g., # My Title). Each one starts on a new page like a
  // chapter unless `h1-pagebreak` is false; the break is weak, so a heading
  // that already starts a page does not add an empty one. This rule replaces
  // Typst's heading layout, so the number (when enabled) is printed here.
  show heading.where(level: 1): it => {
    set text(size: p.headings.h1.size, weight: p.headings.h1.weight)
    let heading-content = if it.numbering != none {
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.3em,
        counter(heading).display(it.numbering),
        it.body,
      )
    } else {
      it.body
    }
    let heading-block = block(below: p.headings.h1.below, heading-content)
    if h1-pagebreak { pagebreak(weak: true) + heading-block } else { heading-block }
  }

  show heading.where(level: 5): set text(..p.headings.h5)
  show heading.where(level: 4): set text(..p.headings.h4)
  show heading.where(level: 3): set text(..p.headings.h3)
  show heading.where(level: 2): set text(..p.headings.h2)

  // Rules that depend on the resolved profile or options are applied around
  // the body, in the order they should take effect.
  let content = style-tables(document-palette.table-border, document-palette.table-header-bg, body)
  content = style-block-quotes(document-palette.quote-bar, document-palette.quote-text, content)
  content = style-code(document-palette.code-bg, content)
  content = style-lists(content)
  content = style-references(p.link-color, ref-form, content)
  content = style-outline(p, content)
  content
}
