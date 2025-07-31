extends CharacterBody2D

@export var speed := 300.0
@export var jump_velocity := -400.0
@onready var pause_menu: Control = $"../CanvasLayer/pause_menu"

var is_pause_menu_opened

func _ready() -> void:
	pause_menu.visible = false

func _physics_process(delta: float) -> void:
	if is_pause_menu_opened:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause menu"):
		pause_menu.visible = not pause_menu.visible
		is_pause_menu_opened = pause_menu.visible


func _on_back__to_game_pressed() -> void:
	pause_menu.visible = false
	is_pause_menu_opened = false

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
