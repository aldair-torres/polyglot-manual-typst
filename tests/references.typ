// Reference forms: `ref-form: "page"` renders `@label` as `(page N)`;
// `ref-form: "normal"` keeps Typst's standard "Section 2" / "Figure 3" forms.
// The runner compiles this document with both values.
//   typst compile --root . --input ref-form=normal tests/references.typ
#import "../lib.typ": polyglot-manual
#import "shared/content.typ": body

#let ref-form = sys.inputs.at("ref-form", default: "page")

#show: polyglot-manual.with(
  media: "digital",
  document-language-code: "en",
  document-title: "Lorem Ipsum — References",
  badge: none,
  // Standard references need numbered headings; page references do not.
  heading-numbering: "1.1",
  ref-form: ref-form,
)

#body

See @captioned-figure and @table-figure too.
