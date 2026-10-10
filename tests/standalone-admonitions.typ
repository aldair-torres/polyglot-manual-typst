// Standalone callouts, not wrapped in `polyglot-manual()`: the style and colors come
// from the build flags, so the runner compiles this document several times:
//
//   typst compile --root . --input media=digital \
//     tests/standalone-admonitions.typ
//   typst compile --root . --input media=printed --input color=color \
//     --input admonition-style=severity tests/standalone-admonitions.typ
#import "../lib.typ": note, tip, important, restriction, caution, warning, danger

#set page(paper: "a4")

= Standalone callouts

#note([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#tip([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#important([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#restriction([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#caution([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#warning([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
#danger([Lorem ipsum dolor sit amet, consectetur adipiscing elit.])
