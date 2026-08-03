if find ~/.local/share/applications /usr/share/applications -name "ftwa-gmail.desktop" | grep -q .; then
  exit 0
fi

set -e

tmpdir="$(mktemp -d)"
tmp_desktop_file="$tmpdir/ftwa-gmail.desktop"

cat >"$tmp_desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=Gmail
Exec=/usr/bin/google-chrome-stable --app='https://mail.google.com'
Icon=ftwa-gmail
Terminal=false
StartupNotify=true
StartupWMClass=ftwa-gmail

# This file was generated using FTWA (https://ftwa.mathix.dev)
EOF

icon_path="$tmpdir/ftwa-gmail.png"
curl -fsSLo "$icon_path" 'https://ftwa.mathix.dev/icons/gmail/regular.png'

xdg-desktop-menu install "$tmp_desktop_file"
xdg-icon-resource install --size 512 "${tmpdir}/ftwa-gmail.png" 'ftwa-gmail'
