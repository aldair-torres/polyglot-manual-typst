// `h1-pagebreak: false`: chapters continue on the same page (economizes paper).
//   typst compile --root . tests/h1-continuous.typ
#import "../lib.typ": polyglot-manual

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Continuous Chapters",
  h1-pagebreak: false,
)

= Chapter one

#lorem(20)

= Chapter two

#lorem(20)

// Without chapter breaks, both chapters share page 1.
#context assert(counter(page).at(here()).first() == 1)
