extends Node

export (PackedScene) var snowman_scene = preload("res://Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	randomize()
	


func _on_SnowmenTimer_timeout():
	var snowman = snowman_scene.instance()
	
	var snowman_spawn_location = $SnowmenSpawnPath/SnowmenSpawnLocation
	snowman_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	
	add_child(snowman)
	snowman.initialize(snowman_spawn_location.translation, player_position)
