// A custom badge wider than the language box: the box falls back to hugging
// its text instead of overflowing. "MMMMM" is exactly the 5-character limit.
//   typst compile --root . tests/badge-wide.typ
#import "../lib.typ": polyglot-manual

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Wide Badge",
  badge: "MMMMM",
)

#lorem(30)
