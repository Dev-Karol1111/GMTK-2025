extends Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	collision_shape.disabled = false
	loop()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.damage(1)

# Musi być async, bo używasz await
func loop() -> void:
	while true:
		sprite.play("on")
		collision_shape.disabled = false
		await get_tree().create_timer(5.0).timeout
		sprite.play("off")
		collision_shape.disabled = true
		await get_tree().create_timer(5.0).timeout
