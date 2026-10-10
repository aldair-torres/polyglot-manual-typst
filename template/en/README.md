# Language folder

One language of the manual. Language folders are fully isolated: they never
import from each other, so a translation can be produced, reviewed, and built
on its own. The project README explains how the folders form a manual.

| Path | What goes here |
|---|---|
| `main.typ` | The entrypoint: output options, the theme call (`polyglot-manual`), front matter, and the chapter includes. |
| `content/` | The prose, one file per chapter (`01-introduction.typ`, `02-methods.typ`, …). |
| `snippets/` | Re-usable values and fragments (product name, version, wording), imported where needed. |
| `images/` | Images, referenced from the file that uses them: from `content/`, write `../images/name.svg`. |

## Adding content

1. Create a chapter in `content/` (`NN-name.typ`) and write the prose there.
2. List it in `main.typ` under “Chapters”, in reading order.

Keep chapter file names identical in every language folder — the translation
checker compares them (see the project README).

## Translating

Copy the whole folder to a sibling named after the target locale (`es`, `de`,
`ja`, …), then in the copy:

1. Set `document-language-code` and `badge` in `main.typ`. The language code
   also selects the translated callout labels, hyphenation, and the CJK font
   fallback.
2. Translate `content/` and `snippets/`. Keep file names, chapter order, and
   labels (`<intro>`, `<methods>`, …) unchanged so cross-references and
   translation checks keep working.
3. Build it like any other language (see the project README).
