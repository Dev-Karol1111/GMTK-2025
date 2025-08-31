extends State
class_name PlayerState

const IDLE = "idle"
const MOVING = "move"
const JUMPING = "jump"
const FALLING = "fall"
const KNOCKBACK = "knockback"

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
