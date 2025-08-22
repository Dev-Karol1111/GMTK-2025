class_name HealthComponent
extends Node

@export var health:float = 100.0
@export var limit:Vector2 = Vector2(0.0,100.0)
@export var steps:float = 1.0
@export var damage_cooldown := 1

var can_damage := true

signal health_updated(prev: float, amt: float)

func heal(amt: float):
	var prev_health = health
	health = clamp(health+amt,limit.x,limit.y)
	health = round(health/steps) * steps
	health_updated.emit(prev_health, health)

func dmg(amt:float, direction: float):
	#print("direction: ")
	#print(direction)
	heal(-amt)
	if health == 0:
		return
	var tween = get_parent().get_tree().create_tween()
	tween.tween_property(get_parent(), "position", get_parent().position + Vector2((32 * (-direction if direction else 1)), -32), 0.2)
	can_damage = false
	await get_tree().create_timer(damage_cooldown).timeout
	can_damage = true
