// Expected failure: `ref-form` must be "normal" or "page".
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "digital", ref-form: "section")

Lorem ipsum dolor sit amet.
