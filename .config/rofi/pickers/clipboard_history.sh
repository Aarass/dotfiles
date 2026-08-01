theme="$HOME/.config/rofi/themes/clipboard_history.rasi"
cliphist list | rofi -dmenu -i -theme "${theme}" | cliphist decode | wl-copy
