// Expected failure: `color` must be auto, "bw", or "color".
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "printed", color: "grayscale")

Lorem ipsum dolor sit amet.
