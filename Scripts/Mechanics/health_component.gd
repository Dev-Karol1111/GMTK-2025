class_name HealthComponent
extends Node

@export var health:float = 100.0
@export var limit:Vector2 = Vector2(0.0,100.0)
@export var steps:float = 1.0

signal health_updated(prev: float, amt: float)

func heal(amt: float):
	var prev_health = health
	health = clamp(health+amt,limit.x,limit.y)
	health = round(health/steps) * steps
	health_updated.emit(prev_health, health)

func dmg(amt:float):
	heal(-amt)
