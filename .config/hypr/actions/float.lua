local function float()
	hl.dispatch(hl.dsp.window.float())
	hl.dispatch(hl.dsp.window.center())
	hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600 }))
end

return float
