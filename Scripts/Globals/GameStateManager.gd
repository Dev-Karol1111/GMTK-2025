extends Node

@onready var core_timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	core_timer.wait_time = 3.0

func level_start()-> void:
	add_child(core_timer)
	core_timer.start()

func level_pause(is_paused)->void:
	core_timer.paused = is_paused

func level_stop()->void:
	core_timer.stop()
	remove_child(core_timer)
