# polyglot-manual

Multilingual product manuals for print and screen.

`polyglot-manual` is a Typst template for product manuals that are published
both as a digital PDF and as a printed, perfect-bound book — from one source
document, in as many languages as you need.

## Features

- **Digital and print profiles** — a digital A4 PDF, or a perfect-bound manual
  in A5 or A4.
- **Full color or black & white print** — the same source can produce a
  color-accented screen PDF or a monochrome booklet.
- **Isolated language folders** — the starter project keeps each language in
  its own folder (`main.typ` plus `content/`, `snippets/`, and `images/`), so
  translations never mix with the master or the theme.
- **Chapter page breaks** — level-1 headings start on a new page by default;
  pass `h1-pagebreak: false` to keep the text flowing instead.
- **Chapter numbering** — optional chapter and section numbers (`1`, `1.1`, …)
  in the headings and the outline.
- **Perfect-binding aware** — a wider inside (gutter) margin, running heads
  that alternate between the document title (recto) and the chapter (verso),
  page numbers on the outer edge, and a small bleed on the language box so it
  reaches the trim edge.
- **Front matter** — legal pages and the outline hide the running header, the
  footer title, and the language badge.
- **Language badge** — an optional badge in the page corner with built-in CJK
  names (日本語, 한국어, 简体中文, 繁體中文) and arbitrary custom text.
- **Styled admonitions** — `note`, `tip`, `important`, `restriction`,
  `caution`, `warning`, and `danger` callouts in three visual styles (`bar`,
  `tint`, `severity`), with labels translated from the document language.
- **Helper functions** — `menuCascade`, `inlineIcon`, and automatic CJK font
  fallback.

## Requirements

- Typst 0.13 or newer. (`inlineIcon(path(...))` needs 0.15+.)
- [Source Sans 3](https://github.com/adobe-fonts/source-sans) for the intended
  look, and the matching Noto Sans families for CJK languages — see
  [Fonts](#fonts). Without them, Typst substitutes another available font and
  emits a warning.

## Quick start

Create a project from the template:

```sh
typst init @preview/polyglot-manual:0.1.0 my-manual
cd my-manual
```

The initialized project is organized as one folder per language, starting with
the English master in `en/` — see
[Multilingual projects](#multilingual-projects). The starter document
(`en/main.typ`) demonstrates every option and styled element. It builds a
**digital A4** PDF by default:

```sh
typst compile en/main.typ
```

Select another output form with `--input` flags:

```sh
typst compile --input media=printed en/main.typ                                       # printed A5, black & white
typst compile --input media=printed --input paper=a4 en/main.typ                      # printed A4, black & white
typst compile --input media=printed --input paper=a4 --input color=color en/main.typ  # printed A4, full color
typst compile --input admonition-style=severity en/main.typ                           # severity callouts
typst compile --input columns=1 en/main.typ                                           # single column
```

Watch the document while you write:

```sh
typst watch en/main.typ
```

## Build flags

The initialized project reads its options from `--input` flags, so a build
pipeline can select the output form without editing the source:

| Flag | Values | Effect |
|---|---|---|
| `--input media=` | `digital` (default) / `printed` | Output form. Digital is always A4, single-sided, full color. |
| `--input paper=` | `a5` (default) / `a4` | Printed page size. Ignored for digital. |
| `--input color=` | `bw` (default) / `color` | Printed palette. Ignored for digital. |
| `--input admonition-style=` | `auto` (default) / `bar` / `tint` / `severity` | Callout background style. |
| `--input columns=` | `2` (default) / `1` | Column count. The single-column layout turns on chapter page breaks. |

Every option can also be set directly in the `#show: polyglot-manual.with(...)` rule in
`en/main.typ`.

## Multilingual projects

The project produced by `typst init` is organized as one isolated folder per
language, so authors never translate their own tooling:

```
my-manual/
├─ en/                 the master language (authors work here first)
│  ├─ main.typ         options + chapter includes (the entrypoint)
│  ├─ content/         the prose, one file per chapter
│  ├─ snippets/        re-usable values (product name, version, …)
│  └─ images/          images
├─ es/                 a translation, same layout
└─ …
```

- Each language has its own `main.typ` that calls the theme with its
  `document-language-code` and `badge`; the translated callout labels,
  hyphenation, and CJK font fallback follow from those options.
- Chapters keep the same file names across languages (`01-introduction.typ`,
  `02-methods.typ`, …), so a translation can be diffed against the master and
  checked for missing chapters. The starter ships
  `check-translations.sh` to do exactly that.
- Images referenced from `content/` use paths relative to the calling file, so
  a chapter refers to `../images/name.svg`.
- Build each language independently — `typst compile en/main.typ`,
  `typst compile es/main.typ`, … Use `--root .` from the project root when a
  language should reach a shared folder (e.g. language-neutral diagrams in
  `common/`).

The workflow: author in the master folder, export it to your preferred
translation tool, import the result as a new sibling folder, set that folder's
`document-language-code` and `badge`, and build it like any other language.

## Using the package

If you prefer to start from your own document instead of the template:

```typst
#import "@preview/polyglot-manual:0.1.0": (
  polyglot-manual, note, tip, important, restriction, caution, warning, danger,
)

#show: polyglot-manual.with(
  media: "digital",       // "digital" or "printed"
  document-language-code: "en",
  document-title: "My Product — User Manual",
  badge: auto,            // none / auto / up to 5 characters
)

= Introduction

The show rule styles the rest of the document — headings, tables, figures,
callouts, page headers and footers.
```

### `polyglot-manual()` arguments

| Argument | Values | Effect |
|---|---|---|
| `media` | `"digital"` (default) / `"printed"` | Output form. Digital is always A4, single-sided, full color. |
| `paper` | `auto` (default) → `"a5"`, or `"a5"` / `"a4"` | Printed page size. Ignored for digital. |
| `color` | `auto` (default) → `"bw"`, or `"bw"` / `"color"` | Printed palette. Ignored for digital. |
| `admonition-style` | `auto` (default) / `"bar"` / `"tint"` / `"severity"` | Callout background style. `auto` gives `tint` on digital and `bar` on print. |
| `h1-pagebreak` | `true` (default) / `false` | When `true`, every H1 starts on a new page, like a chapter. `false` lets chapters continue on the same page (e.g. to economize paper). Cannot be used inside a multi-column layout. |
| `heading-numbering` | `none` (default) / a numbering pattern | Numbers chapters and sections in the headings and the outline, e.g. `"1.1"` renders `1`, `1.1`, `1.1.1`. |
| `ref-form` | `"page"` (default) / `"normal"` | How `@label` references render. `"page"` gives `(page 5)`; `"normal"` gives Typst's standard `Section 2` / `Figure 3` (which needs numbered headings). |
| `font` | family name or list, default `"Source Sans 3"` | Document font. Pass a list for fallback, e.g. `("Source Sans 3", "Libertinus Serif")`. |
| `cjk-font` | `auto` (default) / `none` / family name or list | Fallback font for CJK text. `auto` picks Noto Sans JP/KR/SC/TC/HK from `document-language-code`; `none` disables that mapping; any font (or list) overrides it. |
| `document-language-code` | string | Text language, also used to translate the callout labels. Regional codes such as `"zh-cn"` are supported. |
| `document-title` | content | Shown in the footer on digital, and in the running header of recto (odd) printed pages; the chapter title runs on verso (even) pages. |
| `badge` | `none` (default) / `auto` / string | Language corner badge. `auto` uses the language's CJK name or the uppercased code; a custom string is limited to 5 characters and is shown even when it does not fit the fixed tab (the box then hugs the text). |
| `in-front-matter` | `state` | While `true`, the running header, the footer title, and the language badge are hidden (used for legal pages and the table of contents). |

## Writing content

### Headings and chapters

Headings from H1 to H5 are styled automatically. Level-1 headings are chapters:
with the default `h1-pagebreak: true`, each one starts on a new page; pass
`false` to continue on the same page. Page breaks cannot be placed inside a
multi-column layout, so turn the option off when you use `columns()` — the
starter does this automatically.

Number the chapters and sections with `polyglot-manual(heading-numbering: "1.1")`:
headings and the outline then read `1`, `1.1`, `1.1.1`, …. The value is any
Typst [numbering pattern](https://typst.app/docs/reference/model/numbering/);
`"1.1."` adds a trailing dot after every number.

Label a heading to cross-reference it, and use `<hide-from-toc>` to keep one out
of the outline:

```typst
#outline()

= Methods <methods>

See @methods for the details.

== Internal notes <hide-from-toc>
```

By default, `@methods` renders as a page reference — `See @methods` reads
"See (page 5)". Pass `ref-form: "normal"` to `polyglot-manual()` to keep
Typst's standard references (`Section 2`, `Figure 3`) instead; standard
references to headings need `heading-numbering` to be set.

### Front matter

While `in-front-matter` is true, the running header, the footer title, and the
language badge are hidden; the page number stays:

```typst
#let in-front-matter = state("in-front-matter", false)

#show: polyglot-manual.with(
  in-front-matter: in-front-matter,
  // ...
)

#in-front-matter.update(true)
#pagebreak(weak: true)   // let the header see the change on this page

= Legal notice

#pagebreak()
#outline()

#pagebreak()
#in-front-matter.update(false)
#pagebreak(weak: true)
```

Page headers resolve the state at the start of the page, so follow each update
with a weak break; it does nothing on a page that is already fresh.

### Admonitions

```typst
#note([Additional information for the reader.])
#tip([A helpful suggestion that makes the task easier.])
#important([Essential information about the product or task.])
#restriction([A limitation or condition the reader must respect.])
#caution([Possible damage to the product or the environment.])
#warning([Risk of injury or death. Follow these instructions.])
#danger([Immediate hazard. Avoid the situation entirely.])
```

The title of each callout is translated from `polyglot-manual(document-language-code:)`:
`document-language-code: "es"` renders *Nota*, *Consejo*, *PRECAUCIÓN*, and so on. A
locale falls back to its base language (`es-MX` → Spanish) and an unknown
language to English. The Chinese locales are special-cased: `zh-tw`, `zh-hk`,
and the `zh-hant` script codes use the traditional labels, every other `zh`
locale the simplified ones. Translations are bundled for Bulgarian, Croatian, Czech, Danish, Dutch,
English, Estonian, Finnish, French, German, Greek, Hungarian, Irish, Italian,
Japanese, Korean, Latvian, Lithuanian, Maltese, Polish, Portuguese, Romanian,
Slovak, Slovenian, Spanish, Swedish, and Simplified/Traditional Chinese.

The visual style is chosen with `polyglot-manual(admonition-style:)` or the
`--input admonition-style=` flag. For a custom callout — including a one-off
title override — import `admonition` and use the generic constructor with one
of the seven `kind`s:

```typst
#admonition(kind: "tip", title: "Remember")[Lorem ipsum.]
```

The generic constructor and the seven helpers all take the content as a
trailing block and accept `title:` (defaulting to the translated label) and
`breakable:`. Callouts can split across pages by default; pass
`breakable: false` to keep one atomic — it must then fit on a single page, or
the overflow is clipped. The per-kind policy (icon, severity, bar width) is
exported as `admonition-kinds`.

The callouts come in two families:

| Callouts | Semantics | Colors |
|---|---|---|
| `caution`, `warning`, `danger` | Safety and compliance signal words, with ASD-STE100-style wording | ISO 3864-2 safety palette |
| `note`, `tip`, `important`, `restriction` | Editorial guidance, based on style guides and systems such as the Google developer documentation style guide and DITA | Theme palette |

Keep the safety wording intact when your manual must follow a compliance
standard; the editorial callouts are free to adapt.

### Tables, figures, and more

Tables, figures (captioned, or auto-numbered when caption-less), block quotes,
code blocks, footnotes, links, and math are styled automatically — see the
starter document for examples. Table captions are placed on top, and block
quotes get a muted left bar with italic text.

### Helpers

- `menuCascade("Settings, Network, Wi-Fi")` — breadcrumb-style menu paths.
- `inlineIcon(image("icons/note.svg"))` — a small icon aligned with the text
  baseline. Pass an image, bytes, or a path value on Typst 0.15+
  (`inlineIcon(path("icons/note.svg"))`); `inlineIcon(none)` uses the
  built-in "don't" icon. A plain string is rejected: it would resolve against
  the package instead of your document. The icon is `1em` tall by default, so
  it follows the surrounding text size; pass `size:` for another height, and
  `baseline:` (default `25%`) to adjust how far the icon hangs below the text
  baseline. Paths and bytes are scaled exactly (up or down); an image passed
  as content is never enlarged past its intrinsic size.
- `badge-texts` / `cjk-fonts` — the built-in language maps behind `badge: auto`
  and `cjk-font: auto`; `is-cjk(text)` tests whether text contains CJK
  characters.
- `admonition-labels` / `admonition-label(language, kind)` — the localized
  callout label table and its lookup.
- `document-palette` / `admonition-palette` — the color palettes.
- `build-options` — the active output options (advanced).

## Fonts

The design uses **Source Sans 3**, which is the default of the `font`
argument. Install it for the intended look; without it, Typst falls back to its
default font and emits a warning. To use another family — or to give the
compiler a fallback list — pass `font`:

```typst
#show: polyglot-manual.with(
  font: ("Source Sans 3", "Libertinus Serif"),
  // ...
)
```

For CJK documents, `polyglot-manual()` automatically appends the matching Noto Sans
family to the font list based on `document-language-code`, so Latin text keeps the
designed font while CJK text uses its own glyphs:

| `document-language-code` | Fallback |
|---|---|
| `ja` | Noto Sans JP |
| `ko` | Noto Sans KR |
| `zh`, `zh-cn` | Noto Sans SC |
| `zh-tw` | Noto Sans TC |
| `zh-hk` | Noto Sans HK |

Override this with `cjk-font:` — e.g. `cjk-font: "Noto Serif CJK SC"` for a
serif CJK font, a list to try several, or `cjk-font: none` to disable the
automatic mapping. The built-in mapping is available as `cjk-fonts`. Note that
the referenced Noto families need to be installed on the build machine (or
provided via `--font-path`); otherwise Typst warns and picks another available
font.

## Project structure

| Path | Purpose |
|---|---|
| `lib.typ` | Package entry point; re-exports the public API. |
| `polyglot-manual.typ` | The `polyglot-manual()` show rule and the output profiles. |
| `admonitions.typ` | The seven callouts and the generic `admonition()` constructor. |
| `admonition-labels.typ` | Localized callout labels and the language lookup. |
| `additional-functions.typ` | Helper functions (`menuCascade`, `inlineIcon`). |
| `theme-colors.typ` | The document and admonition color palettes. |
| `images/` | Admonition icons from Material Symbols (Apache 2.0 — see [Credits](#credits)). |
| `template/` | The multi-language project skeleton copied by `typst init`: one folder per language, each with `main.typ`, `content/`, `snippets/`, and `images/`. |
| `tests/` | Feature tests and a runner (`bash tests/run-tests.sh`). |

## Development

Run the test suite with `typst` on your `PATH`:

```sh
bash tests/run-tests.sh
```

It compiles every feature document in the supported profiles and build-flag
combinations, and verifies the expected-failure fixtures. CI additionally
initializes the template, builds every language folder in every output form,
smoke-tests a copied translation, and runs the suite on Typst 0.13 and 0.15.

## Credits

The admonition icons in `images/` are from
[Material Symbols](https://fonts.google.com/icons) by Google LLC and are used
under the [Apache License 2.0](LICENSES/Apache-2.0.txt).

## License

The template code is MIT-licensed — see [LICENSE](LICENSE). The third-party
icons keep their own license (Apache 2.0), as described in
[Credits](#credits).
