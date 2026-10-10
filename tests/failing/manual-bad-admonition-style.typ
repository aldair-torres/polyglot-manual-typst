// Expected failure: `admonition-style` must be auto, "bar", "tint", or
// "severity".
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(admonition-style: "outline")

Lorem ipsum dolor sit amet.
