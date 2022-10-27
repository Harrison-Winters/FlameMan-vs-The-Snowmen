extends KinematicBody

signal shot
export var min_speed = 7.0
export var max_speed = 9.0
var health = 300
onready var player = get_node("/root/Main/Player")
onready var main = get_node("/root/Main")

var velocity = Vector3.ZERO

#automatically moves the snowman at random velocities
func _physics_process(_delta):
	velocity = (player.translation - translation).normalized()
	look_at(player.translation, Vector3.UP)
	rotate_y(2.3)
	move_and_slide(velocity)

#initializes enemy
func initialize(start_position, player_position):
	translation = start_position
	look_at(player.translation, Vector3.UP)
	rotate_y(2.3)
	
	var speed = rand_range(min_speed, max_speed)
	speed = 7
	velocity = Vector3.FORWARD * speed
	velocity.y = 0
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func shot():
	emit_signal("shot")
	queue_free()

func _on_VisibilityNotifier_screen_exited():
	pass
	#queue_free()


func _on_Area_body_entered(body):
	health -= 100
	$HealthBarSnowman.update(health, 300)
	if health <= 0:
		main.die_sound()
		body.queue_free()
		queue_free()
		
	else:
		$hit_sound.play()
