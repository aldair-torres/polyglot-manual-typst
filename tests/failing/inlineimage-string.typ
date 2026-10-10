// Expected failure: a plain string path is rejected because it would resolve
// relative to the package, not the caller's document.
#import "../../lib.typ": inlineIcon

#inlineIcon("lorem.svg")
