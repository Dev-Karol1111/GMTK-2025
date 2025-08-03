class_name ManipulatableBlock
extends Path2D

@export var path: PathFollow2D
@export var speed:float = 300.0
@export_enum("Once", "Ping-Pong", "Loop") var mode:String = "Once"

var is_moving
var target:int = 0

func _ready():
	if mode == "Loop":
		path.loop = true
	if mode == "Ping-Pong":
		pass

func manipulate():
	print("called manipulate")
	is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_moving: 
		return
	path.progress += delta * speed
