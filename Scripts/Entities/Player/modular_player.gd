extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var dash_component: DashComponent
@export var rigidbody_component: RigidbodyComponent
@export var manipulate_component: ManipulateComponent
@export var health_component: HealthComponent

var loop := 1

func _ready() -> void:
	set_ability()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float)-> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_input_released())
	dash_component.handle_dash(self,sign(velocity.x),input_component.get_dash_input())
	manipulate_component.manipulate_objects(self, input_component.get_manipulate_input())
	move_and_slide()
	
	rigidbody_component.handle_forces(self)

func damage(amt: float):
	health_component.dmg(amt)

func _on_health_updated(prev, amt):
	if amt == 0:
		get_tree().change_scene_to_file("res://ui/game_over.tscn")

func set_ability():
	if loop == 1:
		jump_component.jumps = 2
		dash_component.enable = false
		print(dash_component.enable)
		manipulate_component.enable = false
	elif loop == 2:
		jump_component.jumps = 1
		dash_component.enable = false
		manipulate_component.enable = true
	elif loop == 3:
		jump_component.jumps = 1
		dash_component.enable = true
		manipulate_component.enable = false
	elif loop == 4:
		pass

func player():
	pass
