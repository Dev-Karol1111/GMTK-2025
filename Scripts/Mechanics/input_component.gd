class_name InputComponent
extends Node

var input_horizontal: float = 0.0

func _process(_delta):
	input_horizontal = Input.get_axis("move_left","move_right")

func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

func get_jump_input_released() -> bool:
	return Input.is_action_just_released("jump")

func get_dash_input() -> bool:
	return Input.is_action_just_pressed("dash")

func get_manipulate_input() -> bool:
	return Input.is_action_just_pressed("object_manipulation")

func get_pause_input() -> bool:
	return Input.is_action_just_pressed("pause menu")
