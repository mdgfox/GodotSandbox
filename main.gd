extends Node2D

@export var Drop: PackedScene

var score = 0
var lives = 5

func _ready():
	randomize()
	$UI/Score.text = "Score: " + str(score)
	$UI/Lives.text = "Lives: " + str(lives)
	$UI/Message.hide()

func _on_timer_timeout():
	var drop = Drop.instantiate()
	add_child(drop)
	drop.add_to_group("drops")
	drop.position.y = -400
	drop.position.x = randi_range(-512, 512)
	

func _on_dash_obj_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	score += 1
	$Catch.play()
	body.queue_free()
	$UI/Score.text = "Score: " + str(score)

func _on_catcher_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	lives -= 1
	$Miss.play()
	body.queue_free()
	$UI/Lives.text = "Lives: " + str(lives)
	if lives < 1:
		$UI/Message.show()
		$GameOver.play()
		$Timer.stop()
		var drops = get_tree().get_nodes_in_group("drops")
		for child in drops:
			child.queue_free()
		$DashObj.queue_free()
