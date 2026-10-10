// Digital A4 profile, single column, English badge, default (tint) callouts.
//   typst compile --root . tests/digital.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Digital A4",
  badge: auto,
)

#body
