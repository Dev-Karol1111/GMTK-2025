extends PlayerState

var held_time:float

func _enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.animation_player.play("jump")
	held_time=0

func _state_physics_update(_delta: float) -> void:
	#if !Input.is_action_just_released("jump"):
		#held_time=held_time+1
	#if player.animation_player.frame<3:
		#return
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * _delta
	if player.velocity.x<0:
		player.animation_player.flip_h=true
	elif player.velocity.x>0:
		player.animation_player.flip_h=false
	player.move_and_slide()
	if Input.is_action_just_released("jump"):
		player.velocity.y *=.5

	if player.velocity.y >= 0:
		finished.emit(FALLING)
