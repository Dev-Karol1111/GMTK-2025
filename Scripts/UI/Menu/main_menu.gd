extends Control

var level_scene = preload("res://Scenes/levelBryanTest.tscn")
var settings_scene = preload("res://ui/settings/settings.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)


func _on_settings_btn_pressed() -> void:
	get_tree().change_scene_to_packed(settings_scene)


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
