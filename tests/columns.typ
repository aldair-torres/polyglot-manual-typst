// Two-column digital layout (as used by the template), no badge.
//   typst compile --root . tests/columns.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Two Columns",
  badge: none,
  // H1 page breaks are not allowed inside a multi-column container.
  h1-pagebreak: false,
)

#columns(2, body)
