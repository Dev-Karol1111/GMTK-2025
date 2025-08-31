@icon("res://assets/icon.svg")
extends Node
class_name State

signal finished(_to:String, _data:Dictionary)

func _enter(_previous_state_path: String, _data := {})->void :
	pass

func _exit()-> void:
	pass

func _state_update(_delta: float) -> void:
	pass

func _state_physics_update(_delta: float) -> void:
	pass

func _state_handle_input(_event: InputEvent) -> void:
	pass
