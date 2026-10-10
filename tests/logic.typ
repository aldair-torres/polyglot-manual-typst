// Compile-time assertions for the pure logic: CJK detection, badge names, the
// font map, the palettes, and the build-option fallbacks. The runner also
// compiles this with `--input` flags to check the fallbacks against the flags.
//
//   typst compile --root . tests/logic.typ
#import "../lib.typ": (
  badge-texts,
  cjk-fonts,
  is-cjk,
  menuCascade,
  document-palette,
  admonition-palette,
  admonition-kinds,
  admonition-labels,
  admonition-label,
  build-options,
)

// CJK detection (Hiragana/Katakana, Hangul syllables, Han).
#assert(is-cjk("日本語"))
#assert(is-cjk("한국어"))
#assert(is-cjk("简体中文"))
#assert(not is-cjk("Lorem ipsum"))
#assert(not is-cjk(""))

// Built-in badge text per language.
#assert(badge-texts.at("ja") == "日本語")
#assert(badge-texts.at("ko") == "한국어")
#assert(badge-texts.at("zh-cn") == "简体中文")
#assert(badge-texts.at("zh-tw") == "繁體中文")
#assert(badge-texts.at("zh-hk") == "繁體中文")

// CJK fallback font per language.
#assert(cjk-fonts.at("ja") == "Noto Sans JP")
#assert(cjk-fonts.at("ko") == "Noto Sans KR")
#assert(cjk-fonts.at("zh") == "Noto Sans SC")
#assert(cjk-fonts.at("zh-tw") == "Noto Sans TC")
#assert(cjk-fonts.at("zh-hk") == "Noto Sans HK")

// Menu paths: bold labels separated by a non-breaking space and ">".
#assert(menuCascade("A, B") == strong("A") + "\u{00A0}> " + strong("B"))
#assert(menuCascade(" A , B ") == menuCascade("A, B"))

// Admonition kinds: per-kind policy, and key coverage across the three
// kind-keyed tables (policy, colors, labels).
#assert(admonition-kinds.len() == 7)
#assert(admonition-kinds.note.severe == false)
#assert(admonition-kinds.caution.severe == true)
#assert(admonition-kinds.warning.stroke-size == 3.5pt)
#assert(admonition-kinds.danger.stroke-size == 3.5pt)
#for (kind, preset) in admonition-kinds {
  assert("icon" in preset and "severe" in preset and "stroke-size" in preset)
  assert(kind in admonition-palette.color)
  assert(kind in admonition-palette.bw)
  assert(kind in admonition-labels.en)
}

// Palettes.
#assert(admonition-palette.color.len() == 7)
#assert(admonition-palette.bw.len() == 7)
#for kind in admonition-palette.color.keys() {
  assert(kind in admonition-palette.bw)
  for mode in (admonition-palette.color, admonition-palette.bw) {
    let entry = mode.at(kind)
    assert("text" in entry and "border" in entry and "tint" in entry)
  }
}
#assert(document-palette.link-text == rgb("#0000ff"))

// Localized callout labels: exact locale, then base language, then English.
// The Chinese locales are special-cased (zh-tw/zh-hk -> traditional, the rest
// -> simplified).
#assert(admonition-label("en", "note") == "Note")
#assert(admonition-label("de", "caution") == "VORSICHT")
#assert(admonition-label("de-AT", "tip") == "Tipp")
#assert(admonition-label("es-MX", "important") == "Importante")
#assert(admonition-label("es-419", "warning") == "ADVERTENCIA")
#assert(admonition-label("fr-CA", "restriction") == "Restriction")
#assert(admonition-label("zh", "note") == "备注")
#assert(admonition-label("zh-cn", "danger") == "危险")
#assert(admonition-label("zh-hk", "note") == "備註")
#assert(admonition-label("zh-tw", "danger") == "危險")
#assert(admonition-label("ZH-TW", "note") == "備註")
#assert(admonition-label("zh-hant", "note") == "備註")
#assert(admonition-label("zh-hant-tw", "danger") == "危險")
#assert(admonition-label("zh-Hant", "note") == "備註")
#assert(admonition-label("zh-hans", "note") == "备注")
#assert(admonition-label("ja", "tip") == "ヒント")
#assert(admonition-label("ko", "important") == "중요")
#assert(admonition-label("sv", "restriction") == "Begränsning")
#assert(admonition-label("xx", "note") == "Note")
#assert(admonition-label("", "danger") == "DANGER")
#for (language, labels) in admonition-labels {
  assert(("note", "tip", "important", "restriction", "caution", "warning", "danger").all(kind => kind in labels))
}

// Build options fall back to the CLI inputs when no `polyglot-manual()` wraps the
// document.
#context {
  let media = sys.inputs.at("media", default: "digital")
  let options = build-options.get()
  assert(options.media == media)
  assert(options.color == (if media == "digital" or sys.inputs.at("color", default: "bw") == "color" { "color" } else { "bw" }))
  assert(options.admonition-style == sys.inputs.at("admonition-style", default: auto))
}
