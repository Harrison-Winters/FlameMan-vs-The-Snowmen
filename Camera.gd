extends Camera

export (NodePath) var target
onready var player = get_node(target)


func _process(delta):
	translation = Vector3(player.translation.x, 35, player.translation.z) 
