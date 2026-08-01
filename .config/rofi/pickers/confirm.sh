no=
yes=

theme="$HOME/.config/rofi/themes/confirm.rasi"
result=$(printf "%s\n%s" $no $yes | rofi -dmenu -p 'Confirmation' -mesg 'Are you Sure?' -no-click-to-exit -theme "${theme}")

case "$result" in
"$yes") exit 0 ;;
"$no") exit 1 ;;
*) exit 2 ;;
esac
