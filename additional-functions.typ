// A breadcrumb-style path through a menu system.
//
// `items` is a comma-separated string of steps, e.g.
// `menuCascade("Settings, Network, Wi-Fi")`. Each step is trimmed and set in
// bold; the steps are joined by `sep` (a `>` preceded by a non-breaking space
// by default, so it stays with the step before it).
#let menuCascade(items, sep: "\u{00A0}> ") = {
  items.split(",").map(s => strong(s.trim())).join(sep)
}

// A small icon aligned with the text baseline.
//
// `icon` is the image to show: pass it as content, e.g.
// `inlineIcon(image("icons/note.svg"))`, as a path value on Typst 0.15+, e.g.
// `inlineIcon(path("icons/note.svg"))`, or as bytes. All sources resolve
// relative to your document; `inlineIcon(none)` shows the built-in "don't"
// icon. Plain strings are rejected because they would resolve relative to this
// package, not your document.
//
// `size` is the icon height and defaults to `1em`, so the icon follows the
// surrounding text size; pass any length to fix another height. `baseline` is
// how far the icon hangs below the text baseline, as a fraction of its height
// (default `25%`); change it to optically fine-tune one icon.
//
// Paths, bytes, and the built-in icon are scaled to exactly `size`, up or down.
// An image already built as content cannot be resized through its source, so it
// is only constrained: it shrinks to `size` but never grows past its intrinsic
// size. Pass a path or bytes instead when you need exact sizing.
#let inlineIcon(icon, size: 1em, baseline: 25%) = {
  assert(
    icon == none or str(type(icon)) in ("content", "path", "bytes"),
    message: "inlineIcon() expects an image, a path value, or bytes. A plain string would resolve relative to the package, not your document. Pass image(\"your/file.svg\") or, on Typst 0.15+, path(\"your/file.svg\").",
  )
  if type(icon) == content {
    // An already-built image can only be constrained by a box, which shrinks
    // it to fit but never enlarges it.
    box(height: size, baseline: baseline, icon)
  } else {
    // Scale the source to exactly `size`; the box only carries the baseline.
    box(
      baseline: baseline,
      image(
        if icon == none { "./images/dont-icon.svg" } else { icon },
        height: size,
      ),
    )
  }
}

// The active build options. `polyglot-manual()` sets these from its parameters;
// `admonitions.typ` reads them so the visual style follows whatever the call
// site asked for. The fallbacks below keep standalone documents (not wrapped in
// `polyglot-manual()`) working from the build flags.
#let fallback-media = sys.inputs.at("media", default: "digital")
#let fallback-color = if fallback-media == "digital" or sys.inputs.at("color", default: "bw") == "color" { "color" } else { "bw" }

#let build-options = state("build-options", (
  media: fallback-media,
  color: fallback-color,
  admonition-style: sys.inputs.at("admonition-style", default: auto),
  language-code: "",
))
