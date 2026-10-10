// Printed A5, black & white, Japanese badge (CJK stacked) and CJK font
// fallback. Callouts default to the bar style in print.
//   typst compile --root . tests/printed-a5.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#show: polyglot-manual.with(
  media: "printed",
  paper: "a5",
  color: "bw",
  document-language-code: "ja",
  document-title: "Lorem Ipsum — Printed A5",
  badge: auto,
)

#body

日本語のテキスト。
