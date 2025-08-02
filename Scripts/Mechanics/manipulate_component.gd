class_name ManipulateComponent
extends Node

var objs = []

func manipulate_object(body: CharacterBody2D, want_to_manipulate: bool):
	if want_to_manipulate:
		for i in objs:
			i.manipulate()

func _on_area_entered(body):
	if body.is_in_group("Manipulatable"):
		objs.append(body)

func _on_area_exited(body):
	if body.has_method("Manipulatable"):
		objs.erase(body)
