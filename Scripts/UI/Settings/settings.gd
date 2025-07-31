extends Control

@onready var bck_t_mnu: Button = $BckTMnu

var is_from_game := false

func _ready() -> void:
	if is_from_game:
		bck_t_mnu.text = "Back to game"

func _on_bck_t_mnu_pressed() -> void:
	if is_from_game:
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
	else:
		get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
