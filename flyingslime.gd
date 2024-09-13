extends Node2D

const SPEED = 60

@onready var player = %Player
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	position = position.move_toward(player.position,delta * SPEED)


