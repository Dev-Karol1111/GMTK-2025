extends AnimatableBody2D

@export var positions:Array[Node2D]
@export var speed:float = 300.0

var is_moving
var target:int = 0

func manipulate():
	target = (target+1) % len(positions)
	is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_moving:
		return
