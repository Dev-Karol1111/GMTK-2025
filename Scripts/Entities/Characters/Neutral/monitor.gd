extends Area2D

enum {appearing,m_visible,disappearing,invisible }

@export var body_animator: AnimationComponent
@export var face_animator: AnimationComponent
@export var body_sprite:AnimatedSprite2D
@export var face_sprite:AnimatedSprite2D
@export var text:String
@export var dialog_box:RichTextLabel
@export var dialog_speed:float = 3
var talking = false

var currentState;

func _ready() -> void:
	currentState = invisible;
	dialog_box.text = text

func _process(delta):
	if !talking:
		return
	dialog_box.visible_ratio += delta * dialog_speed
	if dialog_box.visible_ratio >= 1:
		talking = false
		face_animator.play("not_talking")
	#print(currentState);

func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player"):
		return
	if currentState == invisible:
		currentState = appearing
		body_animator.play("teleportIn")
		await body_sprite.animation_finished
		currentState = m_visible
		body_animator.play("default")
		dialog_box.visible_ratio =0
		dialog_box.visible = true
		face_sprite.visible = true
		face_animator.play("talking")
		talking = true

func _on_body_exited(body: Node2D) -> void:
	if !body.is_in_group("Player"):
		return
	if currentState == m_visible:
		dialog_box.visible = false
		currentState = disappearing
		face_sprite.visible = false
		body_animator.play("teleportOut")
		await body_sprite.animation_finished
		currentState = invisible


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
