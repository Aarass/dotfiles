if find ~/.local/share/applications /usr/share/applications -name "ftwa-youtube.desktop" | grep -q .; then
  exit 0
fi

set -e

tmpdir="$(mktemp -d)"
tmp_desktop_file="$tmpdir/ftwa-youtube.desktop"

cat >"$tmp_desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=YouTube
Exec=/usr/bin/google-chrome-stable --app='https://www.youtube.com/'
Icon=ftwa-youtube
Terminal=false
StartupNotify=true
StartupWMClass=ftwa-youtube

# This file was generated using FTWA (https://ftwa.mathix.dev)
EOF

icon_path="$tmpdir/ftwa-youtube.png"
curl -fsSLo "$icon_path" 'https://ftwa.mathix.dev/icons/youtube/regular.png'

xdg-desktop-menu install "$tmp_desktop_file"
xdg-icon-resource install --size 512 "${tmpdir}/ftwa-youtube.png" 'ftwa-youtube'
