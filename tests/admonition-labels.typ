// Localized callout labels: every title follows `polyglot-manual(document-language-code:)`, so
// the runner compiles this document once per language in the loop below.
//   typst compile --root . --input language=de tests/admonition-labels.typ
#import "../lib.typ": polyglot-manual, note, tip, important, restriction, caution, warning, danger

#let language = sys.inputs.at("language", default: "en")

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: language,
  document-title: "Lorem Ipsum — Callout Labels",
  badge: none,
)

= Callouts

#note([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#tip([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#important([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#restriction([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#caution([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#warning([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#danger([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
