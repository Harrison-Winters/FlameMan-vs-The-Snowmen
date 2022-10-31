extends CanvasLayer



func _ready():
	if Input.is_action_just_pressed("pause"):
		print("Player has hit the pause button.")
		get_tree().paused = !get_tree().paused



