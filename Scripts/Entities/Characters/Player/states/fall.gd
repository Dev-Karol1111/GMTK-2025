extends PlayerState

var fake_gravity:float = 1.5

func _enter(_previous_state_path: String, _data := {}) -> void:
	player.animation_player.play("fall")

func _state_physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * _delta * fake_gravity
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(MOVING)
