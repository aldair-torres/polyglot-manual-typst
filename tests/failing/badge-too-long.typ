// Expected failure: custom badge text is limited to 5 characters.
#import "../../lib.typ": polyglot-manual

#show: polyglot-manual.with(media: "digital", badge: "LoremI")

Lorem ipsum dolor sit amet.
