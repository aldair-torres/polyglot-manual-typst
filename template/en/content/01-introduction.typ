// Introduction chapter for the English master. This file lives in `content/`,
// so relative paths to sibling folders start with `../` (snippets, images).
#import "@preview/polyglot-manual:0.1.0": (
  menuCascade, inlineIcon, admonition, note, tip, important, restriction, caution, warning, danger,
)
#import "../snippets/product.typ": product-name, product-version

= Introduction <intro>

This document was created with the `polyglot-manual` template and covers the
#product-name (version #product-version). The same source file produces a
digital PDF for screens and a perfect-bound manual for print, in full color or
black & white. See @methods for the details, and the
#link("https://typst.app/universe/package/polyglot-manual")[package README]
for the full documentation.

== Text styles

*Bold*, _emphasized_, `monospace`, #smallcaps[small caps], H#sub[2]O,
E = mc#super[2], #underline[underlined], #strike[struck],
#overline[overlined], #highlight[highlighted], and a
footnote#footnote[Footnotes are styled automatically.].

A menu path: #menuCascade("Settings, Network, Wi-Fi"). Inline images:
#inlineIcon(image("../images/check.svg")) comes from this language's `images/`
folder, and #inlineIcon(none) uses the built-in icon.

=== Deeper headings

==== Level four heading

===== Level five heading

Levels three to five are styled automatically.

== Lists

- Bullet lists
- With a nested level
  - Like this

+ Numbered lists
+ Use 1.a.i. numbering

/ Term: A definition for the term.

== Tables

#table(
  columns: (auto, 1fr),
  [Part], [Description],
  [Power button], [Turns the product on and off.],
  [Status light], [Shows the current state of the product.],
)

#figure(
  table(
    columns: 2,
    table.header([Part], [State]),
    [Power button], [On],
    [Status light], [Blinking],
  ),
  caption: [Table figures keep their caption on top.],
)

== Figures

#figure(
  rect(width: 100%, height: 2.5cm, fill: luma(92%)),
  caption: [Captioned figures use the standard layout.],
)

A caption-less figure gets an automatic number:
#figure(rect(width: 60%, height: 1.5cm, fill: luma(85%)))

== Mathematics

The identity $x^2 + y^2 = z^2$, and a display equation:

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $

== Callouts

All seven callout types are available:

#note([Additional information for the reader.])
#tip([A helpful suggestion that makes the task easier.])
#important([Essential information about the product or task.])
#restriction([A limitation or condition the reader must respect.])
#caution([Possible damage to the product or the environment.])
#warning([Risk of injury or death. Follow these instructions.])
#danger([Immediate hazard. Avoid the situation entirely.])

#admonition(kind: "tip", title: "Remember")[A one-off title override.]

== Quotes and code

#quote(block: true)[
  A block quote, styled by the theme.
]

```java
// A code block, styled by the theme.
public class HelloWorld {
    public static void main(String[] args)
    {
        System.out.println("Hello, World");
    }
}
```
