extends KinematicBody

signal hit
export var jump_impulse = 20.0
export var fall_acceleration = 75
var bounce_impulse = 16.0
export var gravity_multiplier = 3.0
export var speed = 10
export var acceleration = 8
export var deceleration = 10
var direction = Vector3()
var input_axis = Vector2()
var velocity = Vector3()
var snap = Vector3()
var up_direction = Vector3.UP
onready var bullet = preload("res://Bullet.tscn")
var game_started = false

func _physics_process(_delta):
	if game_started:
		if Input.is_action_just_pressed("shoot") and Global.lives > 0:
			var b = bullet.instance()
			$CameraPivot/Camera/rightHand.add_child(b)
			b.shoot = true
			$AudioStreamPlayer3D.play()
		input_axis = Input.get_vector("move_back", "move_forward",
				"move_left", "move_right")
		
		direction = Vector3.ZERO 
		var aim: Basis = get_global_transform().basis

		if input_axis.x >= 0.5:
			direction -= aim.z
		if input_axis.x <= -0.5:
			direction += aim.z
		if input_axis.y <= -0.5:
			direction -= aim.x
		if input_axis.y >= 0.5:
			direction += aim.x
		direction.y = 0
		direction = direction.normalized()
		
		# makes the speed constatnt
		if direction != Vector3.ZERO:
			direction = direction.normalized()
		
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y = 0
		velocity = move_and_slide(velocity)
	
func die():
	emit_signal("hit")
	$CameraPivot/Camera/UserInterface/Retry.visible = true

func _on_MobDetector_body_entered(_body):
	Global.lose_life()
	_body.queue_free()
	$enemy_hit.play()
	if Global.lives == 0:
		die()
