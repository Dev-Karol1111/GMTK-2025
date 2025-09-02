extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@export var animator: AnimationComponent

var wait_time = 3
@onready var is_on = true

func _ready() -> void:
	animator.play("on")
	collision_shape.disabled = false
	GameStateManager.core_timer.timeout.connect(stupid_function)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage(1)

func stupid_function():
	if wait_time>0:
		wait_time -= 1
	else:
		wait_time = 3
		if is_on:
			animator.play("off")
			collision_shape.disabled = true
		else:
			animator.play("on")
			collision_shape.disabled = false
		is_on = !is_on
			
