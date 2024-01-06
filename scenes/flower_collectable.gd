extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	flower_is_ready()


func flower_is_ready():
	$AnimationPlayer.play("being_picked")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade")
	print("+1 flowers")
	await get_tree().create_timer(2).timeout
	queue_free()
