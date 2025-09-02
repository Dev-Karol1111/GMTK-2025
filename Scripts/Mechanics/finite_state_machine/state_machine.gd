@icon("res://assets/icon.svg")
extends Node
class_name  StateMachine

@export var default_state:State = null
@onready var state:State = (func get_initial_state() -> State:
	return default_state if default_state != null else get_child(0)
).call()

@export var label: Label

var states:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state_node : State in find_children("*","State"):
		state_node.finished.connect(change_state)
	await owner.ready
	state._enter("")
	label.text = state.name

func change_state(target_state_path: String, data: Dictionary = {}):
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	var prev_state_path = state.name
	state._exit()
	state = get_node(target_state_path)
	state._enter(prev_state_path,data)
	label.text=state.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state._state_update(delta)

func _physics_process(delta: float) -> void:
	state._state_physics_update(delta)

func _input(event: InputEvent) -> void:
	state._state_handle_input(event)
