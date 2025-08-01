extends StaticBody2D

func _ready():
	GameStateManager.core_timer.timeout.connect(test)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func test():
	print("Timer timed out...")
