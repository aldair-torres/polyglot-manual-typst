// Printed A4, full color, explicit severity callouts, custom text badge.
//   typst compile --root . tests/printed-a4.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#show: polyglot-manual.with(
  media: "printed",
  paper: "a4",
  color: "color",
  admonition-style: "severity",
  document-language-code: "en",
  document-title: "Lorem Ipsum — Printed A4, Full Color",
  badge: "EN",
)

#body
