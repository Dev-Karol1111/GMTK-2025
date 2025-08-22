extends Node

@onready var core_timer := Timer.new()
var iteration = 0
var player:Modular_Player
signal paused(val:bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	core_timer.wait_time = 1.0

func level_start()-> void:
	add_child(core_timer)
	core_timer.start()

func level_pause(is_paused)->void:
	core_timer.paused = is_paused
	paused.emit(is_paused)

func is_paused() -> bool:
	return core_timer.paused

func level_stop()->void:
	core_timer.stop()
	remove_child(core_timer)

func reload_level()->void:
	level_stop()
	iteration += 1
	if iteration<3:
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://ui/win.tscn")
	
