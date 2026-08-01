require("modules/env")
require("modules/hypr_fixes")
require("modules/monitors")
require("modules/layouts")
require("modules/autostart")
require("modules/input")
require("modules/gestures")
require("modules/media_keys")
require("modules/look")

local float = require("actions/float")

-- TODO remove - use script
local menu = "rofi -show drun"

local mainMonitor = "HDMI-A-1"
local laptopMonitor = "eDP-1"

local function print(text)
	hl.notification.create({ text = text, timeout = 5000 })
end

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SPACE", float)
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/rofi/pickers/clipboard_history.sh"))
hl.bind(mainMod .. " + D", hl.dsp.dpms({ monitor = laptopMonitor }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.move({ workspace = "+0", monitor = "+1" }))

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot --mode region --silent -z -o $HOME/Pictures/Screenshots/"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprpicker -and"))

-- TODO
-- hl.bind(mainMod .. " + W", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + semicolon", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + CONTROL + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + CONTROL + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.workspace_rule({ workspace = "r[1-10]", monitor = mainMonitor, default = true })

-- TODO
-- - [ ] disable all other monitors when window is in fullscreen on another (for watching youtube 4 example)
--

-- TODO
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/#directions
-- pinch in da ugasi monitor
-- pinch out da upali monitor
