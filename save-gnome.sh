mkdir -p ~/gnome-export

dconf dump /org/gnome/desktop/wm/keybindings/ \
  > ~/gnome-export/wm-keybindings.dconf

dconf dump /org/gnome/settings-daemon/plugins/media-keys/ \
  > ~/gnome-export/media-keys.dconf

dconf dump /org/gnome/shell/keybindings/ \
  > ~/gnome-export/shell-keybindings.dconf
