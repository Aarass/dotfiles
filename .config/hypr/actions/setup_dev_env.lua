local function setup_dev_env()
	local windows = {
		zen = false,
		dev = false,
		serve = false,
		chrome = false,
		obsidian = false,
		slack = false,
	}

	local function openWindows()
		hl.dispatch(hl.dsp.exec_cmd("zen-browser"))
		hl.dispatch(hl.dsp.exec_cmd("kitty sh -c '$HOME/.config/hypr/actions/dev_env/dev.sh'"))
		hl.dispatch(hl.dsp.exec_cmd("kitty sh -c '$HOME/.config/hypr/actions/dev_env/serve.sh'"))
		hl.dispatch(hl.dsp.exec_cmd("google-chrome-stable"))
		hl.dispatch(hl.dsp.exec_cmd("obsidian"))
		hl.dispatch(hl.dsp.exec_cmd("slack"))
	end

	local function onAllWindowsOpened()
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["zen"], workspace = 1 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["dev"], workspace = 2 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["serve"], workspace = "special:magic" }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["chrome"], workspace = 3 }))
		hl.dispatch(hl.dsp.window.move({ window = "address:" .. windows["obsidian"], workspace = 4 }))
		hl.dispatch(hl.dsp.window.move({ workspace = 7, window = "address:" .. windows["slack"] }))
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
		else
			hl.notification.create({ text = "Unexpected window", timeout = 5000 })
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
