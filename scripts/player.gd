extends CharacterBody2D

var plr_speed = 600
var move_type = "walk"
var dash_going = false
var health = 4
var weapon_mode = "sword"


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
	
	#dash
	if move_type == "dash":
		plr_speed = 1200
		await get_tree().create_timer(0.25).timeout
		plr_speed = 600
		dash_going = false
	
	#you can attack when you press attack
	if Input.is_action_pressed("attack"):
		%weapon_slota.monitoring = true
		await get_tree().create_timer(0.5).timeout
		%weapon_slota.monitoring = false
	else:
		%weapon_slota.monitoring = false
	
	%weapon_slota.look_at(get_global_mouse_position())
	
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
