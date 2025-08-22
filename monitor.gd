extends Area2D

enum {appearing,m_visible,disappearing,invisible }

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var currentState;

func _ready() -> void:
	currentState = invisible;

func _process(delta):
	pass
	#print(currentState);

func _on_body_entered(body: Node2D) -> void:
	if currentState == invisible:
		currentState = appearing
		anim.play("teleportIn")
		await anim.animation_finished
		currentState = m_visible
		anim.play("default")
		
		$face.visible = true;

func _on_body_exited(body: Node2D) -> void:
	if currentState == m_visible:
		currentState = disappearing
		$face.visible = false;
		anim.play("teleportOut")
		await anim.animation_finished
		currentState = invisible


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
