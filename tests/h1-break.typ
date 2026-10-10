// Default `h1-pagebreak: true`: every H1 starts on a new page, like a chapter.
//   typst compile --root . tests/h1-break.typ
#import "../lib.typ": polyglot-manual

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Chapter Breaks",
)

= Chapter one
<chapter-one>

#lorem(20)

= Chapter two

#lorem(20)

// The forced break put chapter two on page 2.
#context assert(counter(page).at(here()).first() == 2)
