extends Node

class_name Ability
# When adding new abilities you must create an enum, a corresponding function and a corresponding input event
# All of them must have the same name, enum should be uppercase, while function and input event names must be lowercase

signal ability_changed

enum Abilities {
	DASH,
	DOUBLE_JUMP,
	OBJECT_MANIPULATION,
}

@export var current_ability: Abilities = Abilities.DOUBLE_JUMP
@export var player: Player = self.get_parent()

var ability_debounce: bool = false
var debounce = false
var prev_ability: Abilities = current_ability

var can_dash = true

func _ready() -> void:
	ability_changed.connect(on_ability_changed)

func _physics_process(delta: float) -> void:
	var ability_name: String = Abilities.find_key(current_ability).to_lower()
	if Input.is_action_just_pressed(ability_name):
		self.call(ability_name)

func _process(delta: float) -> void:
	if prev_ability != current_ability:
		ability_changed.emit(current_ability)
	prev_ability = current_ability


func double_jump():
	if not ability_debounce and not player.jump_debounce:
		ability_debounce = true
		player.velocity.y = player.jump_velocity
		await player.touched_ground
		ability_debounce = false

func dash():
	if can_dash:
		can_dash = false
		
		var dash_vector = Vector2(player.dash_distance * player.direction, 0)
		
		var dash_box := RectangleShape2D.new()
		dash_box.extents = Vector2(abs(dash_vector.x), 200)
		
		var transform := Transform2D.IDENTITY
		transform.origin = player.global_position + dash_vector / 2.0
		
		var space_state = player.get_world_2d().direct_space_state
		var query := PhysicsShapeQueryParameters2D.new()
		query.shape = dash_box
		query.transform = player.transform
		query.exclude = [player]
		query.collide_with_bodies = true
		
		var result = space_state.intersect_shape(query)
		
		var blocked := false
		
		for block in result:
			var collider = block.collider
			if collider.is_in_group("Destructible"):
				collider.queue_free()
			else:
				blocked = true
		
		if blocked:
			player.global_position += dash_vector.normalized() * (player.dash_distance * 0.5)
		else:
			player.global_position += dash_vector
		
		await get_tree().create_timer(player.dash_cooldown).timeout
		can_dash = true


func on_ability_changed(c):
	ability_debounce = false
