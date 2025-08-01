extends Node
class_name Ability
# When adding new abilities you must create an enum, a corresponding function and a corresponding input event
# All of them must have the same name, enum should be uppercase, while function and input event names must be lowercase
enum Abilities {
	DASH,
	DOUBLE_JUMP,
	OBJECT_MANIPULATION,
}
var ability_debounce: bool = false
var debounce = false
@export var current_ability: Abilities = Abilities.DOUBLE_JUMP
@export var player: Player = self.get_parent()
signal ability_changed
var prev_ability: Abilities = current_ability
func double_jump():
	if not ability_debounce and not player.jump_debounce:
		print("called")
		ability_debounce = true
		player.velocity.y = player.jump_velocity
		await player.touched_ground
		ability_debounce = false

func _physics_process(delta: float) -> void:
	var ability_name: String = Abilities.find_key(current_ability).to_lower()
	if Input.is_action_just_pressed(ability_name):
		self.call(ability_name)

func on_ability_changed(c):
	ability_debounce = false

func _process(delta: float) -> void:
	if prev_ability != current_ability:
		ability_changed.emit(current_ability)
	prev_ability = current_ability
	
func _ready() -> void:
	ability_changed.connect(on_ability_changed)
	
