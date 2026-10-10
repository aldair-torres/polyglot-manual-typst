// Shared Lorem Ipsum content used by every feature test document. Each document
// wraps it in `polyglot-manual()` with a different profile and options.
//
// Tests are compiled from the repository root so that the relative import of
// `../lib.typ` stays inside the project sandbox:
//
//   typst compile --root . tests/digital.typ
//
// `bash tests/run-tests.sh` runs every document.
#import "../../lib.typ": menuCascade, inlineIcon, admonition, note, tip, important, restriction, caution, warning, danger

#let body = [
  #outline()

  = Introduction
  <intro>

  #lorem(60) See @methods for the details, and the
  #link("https://typst.app/docs/")[Typst documentation] for more.

  == Inline styles

  *Bold*, _emphasized_, `monospace`, #smallcaps[small caps], H#sub[2]O,
  E = mc#super[2], #underline[underlined], #strike[struck],
  #overline[overlined], #highlight[highlighted], and a
  footnote#footnote[Lorem ipsum dolor sit amet, consectetur adipiscing elit.].

  A menu path: #menuCascade("Settings, Network, Wi-Fi"). Inline images:
  #inlineIcon(image("../assets/check.svg")) and the built-in
  #inlineIcon(none).

  === Level three

  ==== Level four

  ===== Level five

  #lorem(20)

  == Lists

  - Lorem ipsum dolor sit amet.
  - Consectetur adipiscing elit.
    - Sed do eiusmod tempor incididunt.

  + Ut labore et dolore magna aliqua.
  + Ut enim ad minim veniam.

  / Term: Lorem ipsum dolor sit amet, consectetur adipiscing elit.

  == Tables

  #table(
    columns: (auto, 1fr, auto),
    [Part], [Description], [Quantity],
    [Power button], [Turns the product on and off.], [1],
    [Status light], [Shows the current state of the product.], [2],
  )

  #figure(
    table(
      columns: 2,
      table.header([Part], [State]),
      [Power button], [On],
      [Status light], [Blinking],
    ),
    caption: [A table figure keeps its caption on top.],
  ) <table-figure>

  == Figures

  #figure(
    rect(width: 4cm, height: 2.5cm, fill: luma(90%)),
    caption: [A captioned figure uses the default layout.],
  ) <captioned-figure>

  A caption-less figure gets an automatic number:
  #figure(rect(width: 3cm, height: 1.5cm, fill: luma(80%))) <bare-figure>

  == Quotes and code

  #quote(block: true, attribution: [Someone])[
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua.
  ]

  ```typst
  #let answer = 42
  ```

  == Mathematics

  The identity $x^2 + y^2 = z^2$ and a display equation:

  $ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $

  == Callouts

  #note([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #tip([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #important([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #restriction([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #caution([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #warning([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
  #danger([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])

  #admonition(kind: "tip", title: "Remember")[A one-off title override.]
  #note(breakable: false)[An atomic callout.]

  = Methods
  <methods>

  #lorem(120)

  == Excluded heading <hide-from-toc>

  This level-two heading is hidden from the outline by the `<hide-from-toc>`
  label.

  #lorem(40)
]
