#!/usr/bin/env bash
# Runs the test suite: feature documents, build-flag combinations, font
# options, and expected failures. Requires `typst` on PATH and must be run from
# anywhere inside the repository.
#
#   bash tests/run-tests.sh
#
# Generated PDFs and logs go to tests/out/ (git ignored).
set -euo pipefail
cd "$(dirname "$0")/.."

OUT=tests/out
rm -rf "$OUT"
mkdir -p "$OUT"

compile() {
  echo "  typst compile $*"
  typst compile --root . "$@"
}

echo "== Feature documents =="
for file in tests/*.typ; do
  # Compiled separately below, only on compilers that support `path` values.
  [ "$file" = "tests/inlineIcon-path.typ" ] && continue
  compile "$file" "$OUT/$(basename "$file" .typ).pdf"
done

echo "== Standalone callouts across build flags =="
for combo in "digital a4 color auto" "printed a5 bw auto" "printed a4 color severity" "printed a5 bw tint"; do
  read -r media paper color style <<< "$combo"
  compile \
    --input "media=$media" --input "paper=$paper" --input "color=$color" --input "admonition-style=$style" \
    tests/standalone-admonitions.typ "$OUT/standalone-$media-$paper-$color-$style.pdf"
done

echo "== Build options across build flags =="
for combo in "digital a4 color auto" "printed a4 color severity" "printed a5 bw bar"; do
  read -r media paper color style <<< "$combo"
  compile \
    --input "media=$media" --input "paper=$paper" --input "color=$color" --input "admonition-style=$style" \
    tests/logic.typ "$OUT/logic-$media-$paper-$color-$style.pdf"
done

echo "== Font options =="
for cjk in auto none custom; do
  compile --input "cjk=$cjk" tests/fonts.typ "$OUT/fonts-$cjk.pdf"
done

echo "== Reference forms =="
for form in page normal; do
  compile --input "ref-form=$form" tests/references.typ "$OUT/references-$form.pdf"
done

echo "== Localized callout labels =="
for language in en de es zh zh-tw ja; do
  compile --input "language=$language" tests/admonition-labels.typ "$OUT/admonition-labels-$language.pdf"
done

echo "== Typst 0.15+ features =="
version=$(typst --version | awk '{print $2}')
major=${version%%.*}
rest=${version#*.}
minor=${rest%%.*}
if [ "$major" -gt 0 ] || { [ "$major" -eq 0 ] && [ "$minor" -ge 15 ]; }; then
  compile tests/inlineIcon-path.typ "$OUT/inlineIcon-path.pdf"
else
  echo "  skip tests/inlineIcon-path.typ (needs Typst 0.15+, found $version)"
fi

echo "== Expected failures =="
for file in tests/failing/*.typ; do
  log="$OUT/$(basename "$file" .typ).log"
  if typst compile --root . "$file" "$OUT/failing.pdf" > "$log" 2>&1; then
    echo "ERROR: $file compiled, but it should have failed" >&2
    exit 1
  fi
  if ! grep -q "assertion failed" "$log"; then
    echo "ERROR: $file failed for an unexpected reason:" >&2
    cat "$log" >&2
    exit 1
  fi
  echo "  failed as expected: $file"
done
rm -f "$OUT/failing.pdf"

echo
echo "All tests passed."
