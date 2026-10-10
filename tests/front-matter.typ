// Front matter: while `in-front-matter` is true the running header and the
// footer title are hidden; the page number stays. Regional language code
// (zh-tw) exercises the locale split and the CJK font mapping.
//   typst compile --root . tests/front-matter.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#let in-front-matter = state("in-front-matter", false)

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "zh-tw",
  document-title: "Lorem Ipsum — Front Matter",
  badge: auto,
  in-front-matter: in-front-matter,
)

#in-front-matter.update(true)

= Legal notice

#lorem(40)

The running header, the footer title, and the language badge are hidden on
this page; the page number stays.

#pagebreak()

#in-front-matter.update(false)

= Main content

#lorem(60)

#pagebreak()

#body

繁體中文文字。
