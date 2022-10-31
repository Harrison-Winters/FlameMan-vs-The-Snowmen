extends Node

export (PackedScene) var snowman_scene = preload("res://Enemy.tscn")
var pause = false

var instruction_visible

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$BGM.play()
	randomize()
	

func _unhandled_input(event):
	if event.is_action_pressed("retry") and $Player/CameraPivot/Camera/UserInterface/Retry.visible:
		if !$Player.nux_mode:
			Global.lives = Global.max_lives
		else:
			Global.lives = 10000
		$Player/CameraPivot/Camera/UserInterface.load_lives()
		$BGM.play()
		get_tree().reload_current_scene()
		

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause = !pause
		
		
	if Input.is_action_just_pressed("mouse_escape"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("continue") and instruction_visible:
		get_tree().reload_current_scene()

#Spawns enemies randomly in the environment
func _on_SnowmenTimer_timeout():
	var snowman = snowman_scene.instance()
	
	var snowman_spawn_location = $SnowmenSpawnPath/SnowmenSpawnLocation
	snowman_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	
	if not pause:
		add_child(snowman)
		snowman.initialize(snowman_spawn_location.translation, player_position)

func _on_Player_hit():
	$SnowmenTimer.stop()
	$BGM.stop()
	die_sound()
	
func die_sound():
	$die.play()


func _on_StartButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$SnowmenTimer.start()
	$GUI/Menu.visible = false
	$Player.game_started = true
	$GUI/ViewportContainer.visible = true


func _on_InstructionButton_pressed():
	$GUI/Menu/InstructionMenu.visible = true
	instruction_visible = true
	


func _on_NuxButton_pressed():
	$Player.nux_mode = !$Player.nux_mode
	if $Player.nux_mode:
		Global.lives = 10000
		$GUI/Menu/NuxButton.text = "NUX: ON"
	else:
		Global.lives = Global.max_lives
		$GUI/Menu/NuxButton.text = "NUX: OFF"
	$Player/CameraPivot/Camera/UserInterface.load_lives()

func _on_MobDetector_body_entered(body):
	if body != $Player:
		if $Player.nux_mode:
			body.queue_free()
			$Player/enemy_hit.play()
