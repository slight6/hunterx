extends Node2D

var state = "seed" # empty area at start, player will need to plant seed
var player_in_area = false # player will not be in area at start of the game
var flower = preload("res://scenes/flower_collectable.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "seed":
		$growth_time.start()
	
func _process(_delta):
	if state == "seed":
		$AnimatedSprite2D.play("seed")
	if state == "planted":
		$AnimatedSprite2D.play("planted")
		if player_in_area:
			if $AnimatedSprite2D.animation_finished:
				if Input.is_action_just_pressed("pick"):
					state = "seed"
					flower_ready()

				

func _on_pickable_flower_body_entered(body):
	if body.has_method("player"):
		player_in_area = true


func _on_pickable_flower_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_time_timeout():
	if state == "seed":
		state = "planted"

func flower_ready():
	var flower_instance = flower.instantiate()
	flower_instance.global_position = $Marker2D.global_position
	get_parent().add_child(flower_instance)
	
	await get_tree().create_timer(1).timeout
	$growth_time.start()
