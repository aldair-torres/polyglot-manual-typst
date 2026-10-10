#import "./additional-functions.typ": build-options
#import "./theme-colors.typ": admonition-palette
#import "./admonition-labels.typ": admonition-label

// The seven callouts come in two families:
// - `caution`, `warning`, and `danger` are safety callouts for manuals that
//   must follow compliance standards: signal-word semantics with
//   ASD-STE100-style wording and the ISO 3864-2 safety palette.
// - `note`, `tip`, `important`, and `restriction` are editorial callouts,
//   based on style guides and systems such as the Google developer
//   documentation style guide and DITA.
//
// Per-kind policy: the SVG icon base name ("-bn" = black & white, used for
// print), whether the kind gets a background in the "severity" style, and its
// bar width. The colors live in `theme-colors.typ` and the labels in
// `admonition-labels.typ`, keyed by the same kind names. Each icon is
// pre-colored with its type's `text` color from `admonition-palette` (the `-bn`
// variant uses the bw text color), so keep them in sync.
#let admonition-kinds = (
  note:        (icon: "note", severe: false, stroke-size: 2.5pt),
  tip:         (icon: "tip-icon", severe: false, stroke-size: 2.5pt),
  important:   (icon: "important-icon", severe: false, stroke-size: 2.5pt),
  restriction: (icon: "restriction-icon", severe: false, stroke-size: 2.5pt),
  caution:     (icon: "caution-icon", severe: true, stroke-size: 2.5pt),
  warning:     (icon: "warning-icon", severe: true, stroke-size: 3.5pt),
  danger:      (icon: "danger-icon", severe: true, stroke-size: 3.5pt),
)

// Interior geometry shared by every callout: the icon is drawn at `icon-size`
// with its baseline pushed down by `icon-baseline` so it sits with the title;
// `lead` and `tail` tune the space above the body and below the block, and the
// `pad-*` values are the inset around the whole block.
#let callout-geometry = (
  icon-size: 2em,
  icon-baseline: 0.7em,
  lead: 0.01em,
  tail: 0.4em,
  pad-x: 0.8em,
  pad-y: 0.5em,
  pad-y-tinted: 0.6em,
)

// The icon + title line at the top of a callout.
#let callout-heading(icon-path, label, ink) = [
  #box(baseline: callout-geometry.icon-baseline, image(icon-path, width: callout-geometry.icon-size))
  #text(fill: ink, weight: "bold")[#label]
]

// Visual style of the blocks, chosen by `polyglot-manual(admonition-style: ...)` (which
// `--input admonition-style=<value>` sets at the call site):
//   "bar"      colored left bar only
//   "tint"     left bar + light background on all types
//   "severity" left bar; background only on the severe types (caution, warning,
//              danger)
// Default (`auto`): tint for digital, bar for print.
//
// `kind` (required) selects a callout from `admonition-kinds`. `title` is the
// title shown next to the icon: the default `auto` resolves the translated
// label for `kind` from the document language (see `admonition-labels.typ`),
// any content overrides it. `breakable` (default `true`) lets a long callout
// split across pages; pass `false` to keep it atomic — it must then fit on a
// single page, or the overflow is clipped. The content is passed as a trailing
// block:
//
//   #admonition(kind: "tip", title: "Remember")[Lorem ipsum.]
#let admonition(
  kind: auto,
  title: auto,
  breakable: true,
  body,
) = context {
  assert(
    kind != auto,
    message: "admonition(kind:) is required: pass one of " + admonition-kinds.keys().map(repr).join(", ") + ".",
  )
  assert(
    kind in admonition-kinds,
    message: "admonition(kind:) expects one of " + admonition-kinds.keys().map(repr).join(", ") + ", got " + repr(kind) + ".",
  )
  let preset = admonition-kinds.at(kind)
  let options = build-options.get()
  let style = if options.admonition-style == auto {
    if options.media == "digital" { "tint" } else { "bar" }
  } else {
    options.admonition-style
  }

  let colors = admonition-palette.at(options.color).at(kind)
  // Printed manuals set the title in the same black as the rest of the text.
  let title-color = if options.media == "printed" { black } else { colors.text }
  let icon-path = "images/" + preset.icon + if options.color == "color" { ".svg" } else { "-bn.svg" }
  let show-tint = style == "tint" or (style == "severity" and preset.severe)
  let resolved-title = if title == auto { admonition-label(options.language-code, kind) } else { title }

  block(
    width: 100%,
    breakable: breakable,
    stroke: (left: preset.stroke-size + colors.border),
    fill: if show-tint { colors.tint } else { none },
    inset: (
      x: callout-geometry.pad-x,
      y: if show-tint { callout-geometry.pad-y-tinted } else { callout-geometry.pad-y },
    ),
    [
      #callout-heading(icon-path, resolved-title, title-color)
      #v(callout-geometry.lead)
      #body
      #v(callout-geometry.tail)
    ]
  )
}

// The seven built-in callouts. The content is passed as a trailing block; the
// per-kind policy comes from `admonition-kinds`, and `title:` / `breakable:`
// are forwarded to `admonition()`.
#let note(body, ..args) = admonition(body, kind: "note", ..args)

#let tip(body, ..args) = admonition(body, kind: "tip", ..args)

#let important(body, ..args) = admonition(body, kind: "important", ..args)

#let restriction(body, ..args) = admonition(body, kind: "restriction", ..args)

#let caution(body, ..args) = admonition(body, kind: "caution", ..args)

#let warning(body, ..args) = admonition(body, kind: "warning", ..args)

#let danger(body, ..args) = admonition(body, kind: "danger", ..args)
