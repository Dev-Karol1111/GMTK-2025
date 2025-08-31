class_name BasicAIComponent
extends Node

@export_subgroup("Nodes")
@export var timer: Timer

var input_horizontal: float = -1.0

func _process(delta):
	if timer.is_stopped():
		input_horizontal *=-1
		timer.start()
