#!/usr/bin/env bash
# Set VLC as the default macOS player for common video/audio formats.
# Requires `duti` (installed via nix).

set -euo pipefail

VLC_BUNDLE_ID="org.videolan.vlc"

EXTS=(
  # Video
  mp4 mkv webm avi mov m4v flv wmv mpeg mpg ts m2ts vob 3gp ogv
  # Audio
  mp3 flac ogg opus wav aac m4a wma aiff
)

if ! command -v duti >/dev/null; then
  echo "duti not found — run darwin-rebuild switch --flake . first" >&2
  exit 1
fi

if [[ ! -d "/Applications/VLC.app" ]]; then
  echo "VLC.app not found in /Applications — install via brew first" >&2
  exit 1
fi

for ext in "${EXTS[@]}"; do
  duti -s "$VLC_BUNDLE_ID" ".$ext" all
  echo "  .$ext -> VLC"
done

echo "Done. VLC is now the default for ${#EXTS[@]} extensions."
