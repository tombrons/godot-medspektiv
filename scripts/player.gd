extends CharacterBody2D

var plr_speed = 600
var move_type = "walk"
var dash_going = false
var health = 4
var weapon_mode = "sword"
var attacking = false

func _physics_process(delta: float) -> void:
	
	#weapons modes 
	
	if Input.is_action_just_pressed("sword"):
		weapon_mode = "sword"
		print(weapon_mode)
	if Input.is_action_just_pressed("bow"):
		weapon_mode = "bow"
		print(weapon_mode)
		
	if weapon_mode == "sword":
		%Bow.visible = false
	elif weapon_mode == "bow":
		%Bow.visible = true
	
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
	
	#dash
	if move_type == "dash":
		plr_speed = 1200
		await get_tree().create_timer(0.25).timeout
		plr_speed = 600
		dash_going = false
	
	#you can attack when you press attack
	if Input.is_action_pressed("attack"):
		if attacking == false:
			if weapon_mode == "sword":
				%weapon_slota.monitoring = true
				attacking = true
				await get_tree().create_timer(0.5).timeout
				%weapon_slota.monitoring = false
				attacking = false
			if weapon_mode == "bow":
				attacking = true 
				const BULLET = preload("res://scenes/bullet.tscn")
				var new_bullet = BULLET.instantiate()
				get_node("/root/game").add_child(new_bullet)
				new_bullet.global_position = %"shooting point".global_position
				new_bullet.global_rotation = %"shooting point".global_rotation
				await get_tree().create_timer(1).timeout
				attacking = false
			
			
	else:
		%weapon_slota.monitoring = false
	
	%weapon_slota.look_at(get_global_mouse_position())
	%Bow.look_at(get_global_mouse_position())
	%TextureProgressBar.value = health
	
	
	#collision with enemys
func _on_hitbox_body_entered(body: Node2D) -> void:
	hit()
	await  get_tree().create_timer(1).timeout
	

func hit():
	print(health)
	health -= 1 
	if health <= 0 :
		get_tree().paused = true

#Attacks
func _on_weapon_slota_body_entered(body: Node2D) -> void:
	if body.has_method("dead"):
		body.dead()
		await get_tree().create_timer(0.5).timeout
