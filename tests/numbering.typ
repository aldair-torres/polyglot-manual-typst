// Chapter and section numbering in the headings and the outline.
//   typst compile --root . tests/numbering.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#show: polyglot-manual.with(
  media: "digital",
  heading-numbering: "1.1",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Numbering",
  badge: "EN",
)

#body
