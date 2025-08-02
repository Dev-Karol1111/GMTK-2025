class_name ManipulateComponent
extends Node

var empty_hand: bool = true
var want_to_hold: bool = false
var obj: Node2D

func manipulate_object(body: CharacterBody2D, want_to_manipulate: bool):
	if empty_hand:
		want_to_hold = want_to_manipulate
	else:
		want_to_hold = false
	pass # Replace with function body.
	

func _on_area_entered(body):
	if empty_hand and want_to_hold:
		obj = body
	pass # Replace with function body.
