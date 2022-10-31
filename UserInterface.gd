extends Control

func _ready():
	Global.hud = self
	load_lives()

func load_lives():
	if Global.lives != 0:
		if Global.lives == 10000:
			$HPSystem/HeartsEmpty.rect_size.x = 53
			$HPSystem/HeartsFull.rect_size.x = 53
			$HPSystem/Infinite.visible = true
		else:
			$HPSystem/HeartsEmpty.rect_size.x = Global.max_lives * 53
			$HPSystem/HeartsFull.rect_size.x = Global.lives * 53
			$HPSystem/Infinite.visible = false
	else:
		$HPSystem/HeartsFull.visible = false
