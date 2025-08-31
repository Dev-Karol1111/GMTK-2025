extends PlayerState

@export var deceleration_speed:float = 600
@export var knockback_factor:float = 3
@export var fake_gravity:float = 1.5

func _enter(_previous_state_path: String, _data := {}):
	player.velocity = _data.get("knockback")*knockback_factor
	if abs(player.velocity.x)<100:
		player.velocity.x += sign(player.velocity.x)*100
	print(player.velocity)

func _state_physics_update(_delta: float) -> void:
	if player.velocity==Vector2.ZERO:
		finished.emit(IDLE)
	player.velocity=player.velocity.move_toward(Vector2.ZERO,_delta*deceleration_speed)
	player.velocity.y += player.gravity * _delta * fake_gravity
	
	player.move_and_slide()
