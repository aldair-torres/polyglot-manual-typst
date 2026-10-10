// Font options: a fallback list and a CJK override selected from `--input cjk=`
// ("auto", "none", or "custom"), so the runner compiles this three times.
//   typst compile --root . --input cjk=none tests/fonts.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#let cjk = sys.inputs.at("cjk", default: "auto")

#show: polyglot-manual.with(
  media: "digital",
  font: ("Source Sans 3", "Libertinus Serif"),
  cjk-font: if cjk == "none" { none } else if cjk == "custom" { "Noto Serif CJK SC" } else { auto },
  document-language-code: "ja",
  document-title: "Lorem Ipsum — Fonts",
  badge: auto,
)

#body

日本語のテキスト。
