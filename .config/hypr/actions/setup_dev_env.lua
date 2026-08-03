local function setup_dev_env()
	local windows = {
		zen = false,
		dev = false,
		serve = false,
		chrome = false,
		obsidian = false,
		slack = false,
		music = false,
	}

	local function openWindows()
		hl.dispatch(hl.dsp.exec_cmd("zen-browser"))
		hl.dispatch(hl.dsp.exec_cmd("kitty sh -c '$HOME/.config/hypr/actions/dev_env/dev.sh'"))
		os.execute("sleep 0.1")
		hl.dispatch(hl.dsp.exec_cmd("kitty sh -c '$HOME/.config/hypr/actions/dev_env/serve.sh'"))
		hl.dispatch(hl.dsp.exec_cmd("google-chrome-stable"))
		hl.dispatch(hl.dsp.exec_cmd("obsidian"))
		hl.dispatch(hl.dsp.exec_cmd("slack"))
		hl.dispatch(hl.dsp.exec_cmd("gtk-launch ftwa-youtube-music.desktop"))
	end

	local function onAllWindowsOpened()
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["zen"], workspace = 1 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["dev"], workspace = 2 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["serve"], workspace = "special:magic" }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["chrome"], workspace = 3 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["obsidian"], workspace = 4 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["slack"], workspace = 7 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["music"], workspace = 8 }))

		if #hl.get_monitors() == 2 then
			for _, i in ipairs({ 1, 2, 3, 5 }) do
				hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(i), monitor = "HDMI-A-1" }))
			end
			for _, i in ipairs({ 4, 7, 8 }) do
				hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(i), monitor = "eDP-1" }))
			end
		end

		hl.dispatch(hl.dsp.focus({ workspace = "1" }))
	end

	local function areAllWindowsOpened()
		for _, address in pairs(windows) do
			if not address then
				return false
			end
		end
		return true
	end

	local subscription = nil
	subscription = hl.on("window.open", function(win)
		if win.class == "zen" then
			windows["zen"] = win.address
		elseif win.class == "slack" then
			windows["slack"] = win.address
		elseif win.class == "kitty" then
			if not windows["dev"] then
				windows["dev"] = win.address
			else
				windows["serve"] = win.address
			end
		elseif win.class == "google-chrome" then
			windows["chrome"] = win.address
		elseif win.class == "obsidian" then
			windows["obsidian"] = win.address
		elseif string.find(win.class, "music.youtube") then
			windows["music"] = win.address
		else
			hl.notification.create({ text = "Unexpected window: " .. win.title .. " - " .. win.class, timeout = 5000 })
		end

		if areAllWindowsOpened() then
			if subscription then
				subscription:remove()
			end

			onAllWindowsOpened()
		end
	end)

	openWindows()
end

return setup_dev_env
