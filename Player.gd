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



func _physics_process(delta):
	input_axis = Input.get_vector("move_back", "move_forward",
			"move_left", "move_right")
	
	var direction = Vector3.ZERO 
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
	
	if Input.is_action_pressed("mouse_escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# makes the speed constatnt
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity = move_and_slide(velocity,Vector3.UP)
	
	
	
	
	
	
	
