// Expected failure: `h1-pagebreak` must be a boolean.
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "digital", h1-pagebreak: "yes")

Lorem ipsum dolor sit amet.
