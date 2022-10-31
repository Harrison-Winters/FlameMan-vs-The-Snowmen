extends TextureProgress

var bar_red = preload("res://art/barHorizontal_red_mid 200.png")
var bar_green = preload("res://art/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://art/barHorizontal_yellow_mid 200.png")

func update_bar(amount, full):
	if amount == full:
		texture_progress = bar_green
	elif amount == 100:
		texture_progress = bar_yellow
	elif amount == 50:
		texture_progress = bar_red
	value = amount
