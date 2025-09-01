extends HBoxContainer

@export var h1:ColorRect
@export var h2:ColorRect
@export var h3:ColorRect

func _on_health_updated(_prev, curr):
	#print("health gui updated:",curr)
	h1.visible = curr/1>0
	h2.visible = floor(curr/2)>0
	h3.visible = floor(curr/3)>0
