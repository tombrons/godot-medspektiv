extends CharacterBody2D

@onready var player = get_node("/root/game/player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 400
	move_and_slide()
