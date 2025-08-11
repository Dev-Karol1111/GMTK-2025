extends Area2D



func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("player"):
		body.damage(1)
