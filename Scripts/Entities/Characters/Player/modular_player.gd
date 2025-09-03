extends CharacterBody2D
class_name Modular_Player

@export_group("Nodes")
@export_subgroup("Abilities")
@export var jump_component: AdvancedJumpComponent
@export var dash_component: DashComponent
@export var manipulate_component: ManipulateComponent
@export_subgroup("Components")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var rigidbody_component: RigidbodyComponent
@export var health_component: HealthComponent
@export var animation_component:AnimationComponent

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ability_label: Label = $"../CanvasLayer/ability"

func _ready() -> void:
	GameStateManager.player=self
	GameStateManager.level_start()
	set_ability(GameStateManager.iteration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float)-> void:
	if input_component.get_pause_input():
		GameStateManager.level_pause(!GameStateManager.is_paused())
		animation_component.pause(GameStateManager.is_paused())
	if GameStateManager.is_paused():
		return
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	dash_component.handle_dash(self,sign(velocity.x),input_component.get_dash_input())
	manipulate_component.manipulate_objects(self, input_component.get_manipulate_input())
	move_and_slide()
	rigidbody_component.handle_forces(self)

func damage(amt: float):
	if dash_component.isDashing:
		return
	if health_component.can_damage:
		health_component.dmg(amt, input_component.input_horizontal)

func _on_health_updated(_prev, _amt):
	if _amt == 0:
		get_tree().change_scene_to_file("res://Scenes/ui/game_over.tscn")

func set_ability(iteration: int):
	match iteration:
		0:
			ability_label.text = "Ability: Double Jump"
			jump_component.jumps = 2
			dash_component.enable = false
			manipulate_component.enable = false
		1:
			ability_label.text = "Ability: Block Manipulation"
			jump_component.jumps = 1
			dash_component.enable = false
			manipulate_component.enable = true
		2:
			ability_label.text = "Ability: Dash"
			jump_component.jumps = 1
			dash_component.enable = true
			manipulate_component.enable = false
