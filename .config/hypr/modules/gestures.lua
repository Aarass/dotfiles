hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "move",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = function()
		hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	end,
})
