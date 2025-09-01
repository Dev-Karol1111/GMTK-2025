class_name ManipulateComponent
extends Node

signal manipulate

var enable := true

func manipulate_objects(_body: CharacterBody2D, want_to_manipulate: bool):
	if want_to_manipulate and enable:
		manipulate.emit()

func _on_area_entered(body):
	if body.is_in_group("Manipulatable"):
		manipulate.connect(body.get_parent().manipulate)

func _on_area_exited(body):
	if body.is_in_group("Manipulatable"):
		manipulate.disconnect(body.get_parent().manipulate)
