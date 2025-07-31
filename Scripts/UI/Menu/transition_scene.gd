extends Node

@export var level: PackedScene = preload("res://Scenes/level.tscn")

#Todo write the transition code
func transition():
	print("Transition starting....")
	get_tree().change_scene_to_packed(level)
