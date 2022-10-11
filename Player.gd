extends KinematicBody

signal hit
export var speed  = 14
export var jump_impulse = 20.0
export var fall_acceleration = 75
var bounce_impulse = 16.0

var velocity = Vector3.ZERO

func _physics_process(delta):
#	$pivot.look_at(get_viewport().get_mouse_position(),Vector3.UP)
	
	var direction = Vector3.ZERO # direction starts out at 0
	# these are functions for controling the characters walking movements
	if Input.is_action_pressed("move_right"):
		direction.x +=1
	if Input.is_action_pressed("move_left"):
		direction.x -=1
	if Input.is_action_pressed("move_forward"):
		direction.z -=1
	if Input.is_action_pressed("move_back"):
		direction.z +=1
	
	if Input.is_action_pressed("mouse_escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# makes the speed constatnt
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity = move_and_slide(velocity,Vector3.UP)
	
	
	
	
	
	
	
