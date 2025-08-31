extends PlayerState

func _enter(_previous_state_path: String, _data := {}) -> void:
	player.animation_player.play("run")
	pass

func _state_physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * _delta
	if player.velocity.x<0:
		player.animation_player.flip_h=true
	elif player.velocity.x>0:
		player.animation_player.flip_h=false
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
