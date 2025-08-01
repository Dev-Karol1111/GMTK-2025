extends CharacterBody2D
class_name Player
@export var speed := 300.0
@export var jump_velocity := -400.0
@export var jump_cooldown: float = 0.1
@export var jump_debounce: bool = false # Changing to true will disable jumping
signal touched_ground
var is_pause_menu_opened

func _ready() -> void:
	GameStateManager.level_start()
	is_pause_menu_opened = false

func _physics_process(delta: float) -> void:
	if is_pause_menu_opened:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		touched_ground.emit()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_debounce = true
		await get_tree().create_timer(jump_cooldown).timeout
		jump_debounce = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func pause():
	GameStateManager.level_pause(true)
	is_pause_menu_opened = true

func unpause():
	GameStateManager.level_pause(false)
	is_pause_menu_opened = false
