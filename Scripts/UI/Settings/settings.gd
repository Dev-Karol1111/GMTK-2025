extends Control

func _on_bck_t_mnu_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
