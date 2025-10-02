#!/usr/bin/env bash
set -e
IN=${1:-$HOME/gnome-export}

echo "Importing GNOME keybindings and terminal settings from $IN"

dconf load /org/gnome/desktop/wm/keybindings/ < "$IN/wm-keybindings.dconf"
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < "$IN/media-keys.dconf"
dconf load /org/gnome/shell/keybindings/ < "$IN/shell-keybindings.dconf"
dconf load /org/gnome/terminal/ < "$IN/terminal.dconf"

echo "Done."
