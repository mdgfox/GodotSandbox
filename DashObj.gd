extends Area2D

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += 10
	if Input.is_action_pressed("ui_left"):
		position.x -= 10
