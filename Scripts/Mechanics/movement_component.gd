class_name MovementComponent
extends Node

@export_category("Nodes")
@export var animator:AnimationComponent

@export_subgroup("Settings")
@export var speed: float = 300.0
@export var ground_accel_speed: float = 6.0
@export var ground_decel_speed: float = 8.0
@export var air_accel_speed: float = 10.0
@export var air_decel_speed: float = 3.0

func handle_horizontal_movement(body: CharacterBody2D, direction: float)-> void:
	var velocity_change_speed: float = 0.0
	
	if direction:
		if body.is_on_floor():
			animator.play("walk")
		else:
			animator.play("jump")
		if direction > 0:
			animator.flip(false)
		else:
			animator.flip(true)
	else:
		if body.is_on_floor():
			animator.play("idle")
		else:
			animator.play("jump")
	
	if body.is_on_floor():
		velocity_change_speed = ground_accel_speed if direction != 0 else ground_decel_speed
	else:
		velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed
	body.velocity.x = move_toward(body.velocity.x,direction * speed, velocity_change_speed)
