# My manual

Created from the
[`polyglot-manual`](https://typst.app/universe/package/polyglot-manual)
template.

## Structure

One folder per language, fully isolated:

```
my-manual/
├─ en/                 the master language (authors work here first)
│  ├─ main.typ         options + chapter includes (the entrypoint)
│  ├─ content/         the prose, one file per chapter
│  ├─ snippets/        re-usable values (product name, version, …)
│  └─ images/          images
├─ es/                 a translation, same layout
└─ …
```

`en/` is the master by default; rename the folder if your master is another
language. Every language folder has its own README with the authoring and
translation workflow.

## Build

Build any language folder on its own, from the project root:

```sh
typst compile en/main.typ                                     # digital A4 (default)
typst compile --input media=printed en/main.typ               # printed A5, black & white
typst compile --input media=printed --input paper=a4 en/main.typ          # printed A4
typst compile --input media=printed --input color=color en/main.typ       # printed, full color
typst compile --input admonition-style=severity en/main.typ               # severity callouts
typst compile --input columns=1 en/main.typ                               # single-column layout
```

Prepend `--root .` when a language needs to reach files outside its folder,
for example language-neutral assets in a shared `common/` folder:

```sh
typst compile --root . es/main.typ
```

Edit the options at the top of each `main.typ` to hard-code an output form
for that language.

## Translation checks

After a master edit, check that every translation still has the same chapter
files:

```sh
bash check-translations.sh          # master defaults to en/
bash check-translations.sh fr       # pass another master folder
```

Translations are produced with your preferred translation tool: export the
master, translate `content/` and `snippets/`, bring the result back as a new
sibling folder, then set that folder's `document-language-code` and `badge`
and build it like any other language.
