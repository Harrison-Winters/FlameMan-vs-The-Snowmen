extends Node

var max_lives = 4
var nux_mode = true;
var lives
var hud

func _ready():
	if nux_mode:
		lives = 10000
	else:
		lives = max_lives
	
# Taking damage.
func lose_life():
	lives -= 1
	hud.load_lives()
