extends Control

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui/main_menu.tscn")
