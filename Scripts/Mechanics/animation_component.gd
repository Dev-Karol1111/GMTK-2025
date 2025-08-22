extends Node
class_name AnimationComponent

@export_category("Nodes")
@export var sprite:AnimatedSprite2D

func _ready():
	GameStateManager.paused.connect(pause)

func play(animation:String):
	sprite.play(animation)

func pause(val:bool):
	if val:
		sprite.pause()
	else:
		sprite.play()

func flip(val:bool):
	sprite.flip_h = val
