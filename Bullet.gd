extends RigidBody

var damage = 50
var shoot = false
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)

func _physics_process(delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z)


func _on_Area_body_entered(body):
	body.queue_free()
	queue_free()
