// Expected failure: `media` must be "digital" or "printed".
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "screen")

Lorem ipsum dolor sit amet.
