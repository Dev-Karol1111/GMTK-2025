extends Node

var is_pause_menu_opened
@onready var pause_menu:Control = $"."
signal paused
signal unpaused

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause menu"):
		pause_menu.visible = not pause_menu.visible
		is_pause_menu_opened = pause_menu.visible
		if pause_menu.visible:
			paused.emit()
		else:
			unpaused.emit()

func _on_back_to_game_pressed() -> void:
	pause_menu.visible = not pause_menu.visible
	is_pause_menu_opened = pause_menu.visible
	unpaused.emit()
	


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
