local float = require("actions/float")

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "move",
})

hl.gesture({
	fingers = 3,
	direction = "up",
	action = float,
})
