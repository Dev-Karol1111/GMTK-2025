extends Node

@export var to:PackedScene = preload("res://Scenes/Main.tscn")

#Todo write the transition code
func transition():
	print("Transition starting....")
	get_tree().change_scene_to_packed(to)
	pass
