#!/usr/bin/env bash
# install.sh — install the `play` music player into ~/.local/bin
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/bin/play"
DEST_DIR="${PREFIX:-$HOME/.local/bin}"
DEST="$DEST_DIR/play"

[ -f "$SRC" ] || { echo "install: $SRC not found" >&2; exit 1; }

mkdir -p "$DEST_DIR"
install -m 0755 "$SRC" "$DEST"
echo "Installed: $DEST"

case ":$PATH:" in
    *":$DEST_DIR:"*) ;;
    *) echo "Note: $DEST_DIR is not on your PATH. Add this to your shell rc:"
       echo "    export PATH=\"$DEST_DIR:\$PATH\"" ;;
esac

echo
echo "Dependencies:"
echo "  - yt-dlp   (pip install yt-dlp)"
echo "  - mpv      (Linux: apt install mpv / brew install mpv;  WSL: install mpv.exe on Windows)"
echo "  - tmux     (optional, enables the split-pane UI)"
echo "  - python3  (native-audio IPC bridge + Spotify search)"
echo
echo "Run:  play <search terms>"
