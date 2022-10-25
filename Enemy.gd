extends KinematicBody

signal shot
export var min_speed = 7.0
export var max_speed = 9.0
var health = 300

var velocity = Vector3.ZERO

#automatically moves the snowman at random velocities
func _physics_process(_delta):
	move_and_slide(velocity)

#initializes enemy
func initialize(start_position, player_position):
	translation = start_position
	look_at(player_position, Vector3.UP)
	#rotate_y(rand_range(-PI / 4.0, PI / 4.0))
	
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func shot():
	emit_signal("shot")
	queue_free()

func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_Area_body_entered(body):
	health -= 100
	$HealthBarSnowman.update(health, 300)
	if health <= 0:
		queue_free()
