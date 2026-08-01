#!/usr/bin/env bash

theme="$HOME/.config/rofi/themes/powermenu.rasi"

uptime="$(uptime -p | sed -e 's/up //g')"

shutdown=''
reboot=''
lock=''
suspend=''
logout=''
hibernate=''

run_rofi() {
  echo -e "$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown" | rofi \
    -dmenu \
    -p "Uptime: $uptime" \
    -mesg "Uptime: $uptime" \
    -theme "${theme}"
}

confirm_exit() {
  "$HOME/.config/rofi/pickers/confirm.sh"
}

lock() {
  pidof hyprlock || hyprlock --immediate-render --no-fade-in &
}

case "$(run_rofi)" in
$shutdown)
  if confirm_exit; then
    systemctl poweroff
  fi
  ;;
$reboot)
  if confirm_exit; then
    systemctl reboot
  fi
  ;;
$lock)
  lock
  ;;
$suspend)
  if confirm_exit; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 &
    playerctl pause --all-players &
    lock && systemctl suspend
  fi
  ;;
$hibernate)
  if confirm_exit; then
    lock && systemctl hibernate
  fi
  ;;
$logout)
  if confirm_exit; then
    hyprctl dispatch exit
  fi
  ;;
esac
