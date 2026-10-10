// Expected failure: `paper` must be auto, "a5", or "a4".
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "printed", paper: "letter")

Lorem ipsum dolor sit amet.
