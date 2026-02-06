extends CharacterBody2D

var plr_speed = 600
var move_type = "walk"
var dash_going = false


func _physics_process(delta: float) -> void:
	#movement
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * plr_speed
	move_and_slide()
	
	#sprint
	if Input.is_action_pressed("sprint"):
		move_type = "run"
	elif Input.is_action_pressed("dash"):
		if dash_going == false:
			dash_going = true
			move_type = "dash"
	else:
		move_type = "walk"
	
	if move_type == "walk":
		plr_speed = 600
	
	if move_type == "run":
		plr_speed = 800
		
	if move_type == "dash":
		plr_speed = 1200
		await get_tree().create_timer(0.25).timeout
		plr_speed = 600
		dash_going = false
		
		
		
	

		
		

	
	#collision with enemy
func _on_hitbox_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	
	
