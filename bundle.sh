#!/bin/bash
# Downloads soundfont-player + all 15 instrument soundfonts so the app
# works fully offline. Run once, then zip the folder to share.

set -e
cd "$(dirname "$0")"

mkdir -p vendor soundfonts/MusyngKite

if [ ! -f vendor/soundfont-player.min.js ]; then
  echo "Downloading soundfont-player…"
  curl -sfLo vendor/soundfont-player.min.js \
    https://cdn.jsdelivr.net/npm/soundfont-player@0.12.0/dist/soundfont-player.min.js
fi

INSTRUMENTS=(
  marimba xylophone vibraphone glockenspiel celesta music_box kalimba steel_drums
  pizzicato_strings orchestral_harp acoustic_guitar_nylon
  electric_piano_1 electric_piano_2 acoustic_grand_piano harpsichord
)

for inst in "${INSTRUMENTS[@]}"; do
  out="soundfonts/MusyngKite/${inst}-mp3.js"
  if [ -f "$out" ]; then continue; fi
  echo "Downloading ${inst}…"
  curl -sfLo "$out" \
    "https://gleitz.github.io/midi-js-soundfonts/MusyngKite/${inst}-mp3.js"
done

echo
echo "Done. Size:"
du -sh vendor soundfonts
echo
echo "To share: zip -r sounds.zip index.html vendor soundfonts"
