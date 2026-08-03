if find ~/.local/share/applications /usr/share/applications -name "ftwa-excalidraw.desktop" | grep -q .; then
  exit 0
fi

set -e

tmpdir="$(mktemp -d)"
tmp_desktop_file="$tmpdir/ftwa-excalidraw.desktop"

cat >"$tmp_desktop_file" <<EOF
[Desktop Entry]
Type=Application
Name=Excalidraw
Exec=/usr/bin/google-chrome-stable --app='https://excalidraw.com'
Icon=ftwa-excalidraw
Terminal=false
StartupNotify=true
StartupWMClass=ftwa-excalidraw

# This file was generated using FTWA (https://ftwa.mathix.dev)
EOF

icon_path="$tmpdir/ftwa-excalidraw.png"
curl -fsSLo "$icon_path" 'https://ftwa.mathix.dev/icons/excalidraw/regular.png'

xdg-desktop-menu install "$tmp_desktop_file"
xdg-icon-resource install --size 192 "${tmpdir}/ftwa-excalidraw.png" 'ftwa-excalidraw'
