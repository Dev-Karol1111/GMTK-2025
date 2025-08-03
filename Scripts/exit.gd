extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.loop += 1
		body.position.x = 32
		body.position.y = 3
		body.set_ability()
		
