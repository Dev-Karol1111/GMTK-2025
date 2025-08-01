class_name DashComponent
extends Node

@export_subgroup("Settings")
@export var speed: float = 600.0
@export var timer:Timer

var prev_dir = 1
var isDashing = false

func handle_dash(body: CharacterBody2D, direction: float, want_to_dash: bool)-> void:
	if direction != 0:
		prev_dir = direction
	
	handle_dash_timer(body, want_to_dash)

func handle_dash_timer(body: CharacterBody2D, want_to_dash: bool)->void:
	if want_to_dash:
		timer.start()
	
	if not timer.is_stopped():
		body.velocity.x = prev_dir * speed
