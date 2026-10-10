// Expected failure: `heading-numbering` must be none or a numbering pattern.
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "digital", heading-numbering: 1.5)

Lorem ipsum dolor sit amet.
