// Translated titles for the seven admonition kinds, keyed by language code.
// The English entry is the fallback for languages that aren't listed.
#let admonition-labels = (
  en: (note: "Note", tip: "Tip", important: "Important", restriction: "Restriction", caution: "CAUTION", warning: "WARNING", danger: "DANGER"),
  bg: (note: "Забележка", tip: "Съвет", important: "Важно", restriction: "Ограничение", caution: "ВНИМАНИЕ", warning: "ПРЕДУПРЕЖДЕНИЕ", danger: "ОПАСНОСТ"),
  cs: (note: "Poznámka", tip: "Tip", important: "Důležité", restriction: "Omezení", caution: "UPOZORNĚNÍ", warning: "VAROVÁNÍ", danger: "NEBEZPEČÍ"),
  da: (note: "Bemærk", tip: "Tip", important: "Vigtigt", restriction: "Begrænsning", caution: "FORSIGTIG", warning: "ADVARSEL", danger: "FARE"),
  de: (note: "Hinweis", tip: "Tipp", important: "Wichtig", restriction: "Einschränkung", caution: "VORSICHT", warning: "WARNUNG", danger: "GEFAHR"),
  el: (note: "Σημείωση", tip: "Συμβουλή", important: "Σημαντικό", restriction: "Περιορισμός", caution: "ΠΡΟΣΟΧΗ", warning: "ΠΡΟΕΙΔΟΠΟΙΗΣΗ", danger: "ΚΙΝΔΥΝΟΣ"),
  es: (note: "Nota", tip: "Consejo", important: "Importante", restriction: "Restricción", caution: "PRECAUCIÓN", warning: "ADVERTENCIA", danger: "PELIGRO"),
  et: (note: "Märkus", tip: "Nõuanne", important: "Tähtis", restriction: "Piirang", caution: "ETTEVAATUST", warning: "HOIATUS", danger: "OHT"),
  fi: (note: "Huomautus", tip: "Vinkki", important: "Tärkeää", restriction: "Rajoitus", caution: "HUOMIO", warning: "VAROITUS", danger: "VAARA"),
  fr: (note: "Remarque", tip: "Conseil", important: "Important", restriction: "Restriction", caution: "ATTENTION", warning: "AVERTISSEMENT", danger: "DANGER"),
  ga: (note: "Nóta", tip: "Kol", important: "Tábhachtach", restriction: "Srian", caution: "AIRE", warning: "RABHADH", danger: "DÁINSEAR"),
  hr: (note: "Napomena", tip: "Savjet", important: "Važno", restriction: "Ograničenje", caution: "OPREZ", warning: "UPOZORENJE", danger: "OPASNOST"),
  hu: (note: "Megjegyzés", tip: "Tipp", important: "Fontos", restriction: "Korlátozás", caution: "VIGYÁZAT", warning: "FIGYELMEZTETÉS", danger: "VESZÉLY"),
  it: (note: "Nota", tip: "Suggerimento", important: "Importante", restriction: "Restrizione", caution: "ATTENZIONE", warning: "AVVERTENZA", danger: "PERICOLO"),
  ja: (note: "注記", tip: "ヒント", important: "重要", restriction: "制限", caution: "注意", warning: "警告", danger: "危険"),
  ko: (note: "참고", tip: "팁", important: "중요", restriction: "제한", caution: "주의", warning: "경고", danger: "위험"),
  lt: (note: "Pastaba", tip: "Patarimas", important: "Svarbu", restriction: "Apribojimas", caution: "ATSARGIAI", warning: "ĮSPĖJIMAS", danger: "PAVOJUS"),
  lv: (note: "Piezīme", tip: "Padoms", important: "Svarīgi", restriction: "Ierobežojums", caution: "UZMANĪBU", warning: "BRĪDINĀJUMS", danger: "BĪSTAMI"),
  mt: (note: "Nota", tip: "Suġġeriment", important: "Importanti", restriction: "Restrizzjoni", caution: "ATTENZJONI", warning: "TWISSIJA", danger: "PERIKLU"),
  nl: (note: "Opmerking", tip: "Tip", important: "Belangrijk", restriction: "Beperking", caution: "VOORZICHTIG", warning: "WAARSCHUWING", danger: "GEVAAR"),
  pl: (note: "Uwaga", tip: "Wskazówka", important: "Ważne", restriction: "Ograniczenie", caution: "PRZESTROGA", warning: "OSTRZEŻENIE", danger: "NIEBEZPIECZEŃSTWO"),
  pt: (note: "Nota", tip: "Dica", important: "Importante", restriction: "Restrição", caution: "ATENÇÃO", warning: "AVISO", danger: "PERIGO"),
  ro: (note: "Notă", tip: "Sfat", important: "Important", restriction: "Restricție", caution: "ATENȚIE", warning: "AVERTISMENT", danger: "PERICOL"),
  sk: (note: "Poznámka", tip: "Tip", important: "Dôležité", restriction: "Obmedzenie", caution: "UPOZORNENIE", warning: "VÝSTRAHA", danger: "NEBEZPEČENSTVO"),
  sl: (note: "Opomba", tip: "Nasvet", important: "Pomembno", restriction: "Omejitev", caution: "PREVIDNO", warning: "OPOZORILO", danger: "NEVARNOST"),
  sv: (note: "Obs!", tip: "Tips", important: "Viktigt", restriction: "Begränsning", caution: "FÖRSIKTIGHET", warning: "VARNING", danger: "FARA"),
  zh: (note: "备注", tip: "提示", important: "重要", restriction: "限制", caution: "注意", warning: "警告", danger: "危险"),
  zh-tw: (note: "備註", tip: "提示", important: "重要", restriction: "限制", caution: "注意", warning: "警告", danger: "危險"),
)

// The label for `kind` in `language`: the exact locale first ("es-mx" would
// match a hypothetical entry), then the base language ("es-ES" → "es"), then
// English. The Chinese locales are special-cased: "zh-tw", "zh-hk", and the
// "zh-hant" script codes use the traditional labels; every other "zh" locale
// uses the simplified ones.
#let admonition-label(language, kind) = {
  let lang = lower(language)
  let base = lang.split("-").at(0)
  let traditional = lang in ("zh-tw", "zh-hk") or lang == "zh-hant" or lang.starts-with("zh-hant-")
  let labels = if traditional {
    admonition-labels.at("zh-tw")
  } else if base == "zh" {
    admonition-labels.at("zh")
  } else if lang in admonition-labels {
    admonition-labels.at(lang)
  } else if base in admonition-labels {
    admonition-labels.at(base)
  } else {
    admonition-labels.at("en")
  }
  labels.at(kind, default: admonition-labels.en.at(kind, default: kind))
}
