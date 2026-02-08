extends CharacterBody2D

const  STR_HEALTH = 3
var health = STR_HEALTH

@onready var player = get_node("/root/game/player")

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 400
	move_and_slide()

func dead():
	queue_free()

func take_damage():
	print("damaged")
	health -= 1
	if health <= 0:
		queue_free() 
