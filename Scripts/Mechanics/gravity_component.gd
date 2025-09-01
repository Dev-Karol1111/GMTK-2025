class_name GravityComponent
extends Node

@export_subgroup("Settings")
@export var gravity: float = 1000.0
@export var boost:bool = false

var is_falling: bool = false

func handle_gravity(body: CharacterBody2D, delta: float)-> void:
	if not body.is_on_floor():
		if boost:
			body.velocity.y += gravity * delta
		else:
			body.velocity.y += body.get_gravity().y * delta
	
	is_falling = body.velocity.y >0 and not body.is_on_floor()

func _process(_delta):
	pass
