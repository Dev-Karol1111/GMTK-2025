extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var brain_component: BasicAIComponent
@export var movement_component: MovementComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float)-> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self, brain_component.input_horizontal)
	move_and_slide()
