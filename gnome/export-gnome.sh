#!/usr/bin/env bash
set -e
OUT=${1:-$HOME/gnome-export}
mkdir -p "$OUT"

echo "Exporting GNOME keybindings and terminal settings to $OUT"

dconf dump /org/gnome/desktop/wm/keybindings/ \
  > "$OUT/wm-keybindings.dconf"

dconf dump /org/gnome/settings-daemon/plugins/media-keys/ \
  > "$OUT/media-keys.dconf"

dconf dump /org/gnome/shell/keybindings/ \
  > "$OUT/shell-keybindings.dconf"

dconf dump /org/gnome/terminal/ \
  > "$OUT/terminal.dconf"

echo "Done. Copy $OUT to your other machine and import with dconf load."
