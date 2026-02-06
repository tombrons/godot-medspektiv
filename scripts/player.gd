extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 700
	move_and_slide()



func _on_hitbox_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	
