if find ~/.local/share/applications /usr/share/applications -name "ftwa-youtube-music.desktop" | grep -q .; then
  exit 0
fi

set -e

tmpdir="$(mktemp -d)"
tmp_desktop_file="$tmpdir/ftwa-youtube-music.desktop"

cat >"$tmp_desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=YouTube Music
Exec=/usr/bin/google-chrome-stable --app='https://music.youtube.com'
Icon=ftwa-youtube-music
Terminal=false
StartupNotify=true
StartupWMClass=ftwa-youtube-music

# This file was generated using FTWA (https://ftwa.mathix.dev)
EOF

icon_path="$tmpdir/ftwa-youtube-music.png"
curl -fsSLo "$icon_path" 'https://ftwa.mathix.dev/icons/yt-music/regular.png'

xdg-desktop-menu install "$tmp_desktop_file"
xdg-icon-resource install --size 512 "${tmpdir}/ftwa-youtube-music.png" 'ftwa-youtube-music'
