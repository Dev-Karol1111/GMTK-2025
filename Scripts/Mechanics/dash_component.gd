class_name DashComponent
extends Node

@export_subgroup("Nodes")
@export var timer:Timer
@export var cd_timer:Timer

@export_subgroup("Settings")
@export var speed: float = 600.0
@export var kills: bool = false

var prev_dir = 1
var isDashing = false
var b:CharacterBody2D

func handle_dash(body: CharacterBody2D, direction: float, want_to_dash: bool)-> void:
	if direction != 0:
		prev_dir = direction
	
	handle_dash_timer(body, want_to_dash)

#implement cd
func handle_dash_timer(body: CharacterBody2D, want_to_dash: bool)->void:
	if want_to_dash and (not isDashing or cd_timer.is_stopped()):
		timer.start()
		isDashing = true
	
	if not timer.is_stopped():
		body.velocity.x = prev_dir * speed
		

func _on_area_entered(body: Node2D):
	if not isDashing:
		return
	var destroy: bool = body.is_in_group("Destructible") or (body.is_in_group("Killable") and kills)
	if destroy:
		body.queue_free()
	print(body)

func _on_timer_timeout():
	isDashing = false
	cd_timer.start()
