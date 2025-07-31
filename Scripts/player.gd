extends CharacterBody2D

@export var speed := 300
@export var jump_velocity := -400.0
@onready var pause_menu: Control = $"../CanvasLayer/pause_menu"
@onready var  coyoteTimer: Timer= $coyoteTimer
#Variables
var coyoteTime:bool=false
var is_pause_menu_opened

func _ready() -> void:
	pause_menu.visible = false

	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause menu"):
		pause_menu.visible = not pause_menu.visible
		is_pause_menu_opened = pause_menu.visible

func _physics_process(delta: float) -> void:
	if is_pause_menu_opened:
		return
	updateCoyoteTime()
	jump(delta)
	movement()
	move_and_slide()

func movement():
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func jump(delta):
	if not is_on_floor() or coyoteTimer.time_left<=0:
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyoteTime==true) :
		velocity.y = jump_velocity
		coyoteTime=false

func updateCoyoteTime():
	if coyoteTimer.time_left<=0:
		coyoteTime=false
	if is_on_floor():
		coyoteTime=true
	elif (not is_on_floor() and coyoteTimer.time_left<=0):
		coyoteTimer.start()
	

func _on_back__to_game_pressed() -> void:
	pause_menu.visible = false
	is_pause_menu_opened = false
	


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
