// Typst 0.15+ only: a `path` value resolves in this file and is then handed to
// the package. The runner skips this document on older compilers.
//   typst compile --root . tests/inlineIcon-path.typ
#import "../lib.typ": inlineIcon

Lorem ipsum #inlineIcon(path("assets/check.svg")) dolor sit amet,
consectetur adipiscing elit #inlineIcon(path("assets/check.svg"), size: 14pt).
A scaled icon: #inlineIcon(path("assets/check.svg"), size: 2em, baseline: 40%).
