class_name HealthComponent
extends Node

@export var health:float = 100.0
@export var limit:Vector2 = Vector2(0.0,100.0)
@export var steps:float = 1.0

func heal(amt: float):
	health += clamp(health+amt,limit.x,limit.y)
	health = round(health/steps) * steps

func dmg(amt:float):
	heal(-amt)
