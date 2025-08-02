extends Control

@onready var bck_t_mnu: Button = $BckTMnu
@onready var volume: HSlider = $VBoxContainer2/Voulme/Volume
@onready var full_screen: CheckButton = $VBoxContainer/Fullscreen/FullScreen

var is_from_game := false

# SETTINGS
var settings_dir = "user://settings.cfg"
var config = ConfigFile.new()

var fullscreen := false
var volume_value := 0.8

func _ready() -> void:
	if is_from_game:
		bck_t_mnu.text = "Back to game"
	load_settings()

func _on_bck_t_mnu_pressed() -> void:
	if is_from_game:
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
	else:
		get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")

func save_settings():
	config.set_value("audio", "music_volume", volume_value)
	config.set_value("video", "fullscreen", fullscreen)
	
	var err = config.save(settings_dir)
	if err != OK:
		print(err)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err != OK:
		save_settings()
	
	var volume_value = config.get_value("audio", "music_volume", volume_value)
	var fullscreen = config.get_value("video", "fullscreen", fullscreen)
	
	volume.value = volume_value
	full_screen.button_pressed = fullscreen
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume_value))
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_check_button_toggled(toggled_on: bool) -> void:
	fullscreen = toggled_on
	save_settings()
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_h_slider_value_changed(value: float) -> void:
	volume_value = value
	save_settings()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume_value))
