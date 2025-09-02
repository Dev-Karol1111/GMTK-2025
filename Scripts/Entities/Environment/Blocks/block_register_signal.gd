extends AnimatableBody2D

@export var block:ManipulatableBlock

func register(manipulate_signal):
	block.manipulate()
	pass 

func unregister(manipulate_signal):
	pass
