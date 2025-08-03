class_name ManipulatableBlock
extends Path2D

@export var path: PathFollow2D
@export var speed:float = 300.0
@export_enum("Once", "Ping-Pong", "Loop") var mode:String = "Once"

var is_moving := false
var curr_ind := 0
var going_forward := true
var stop_distances : Array[float] =  []
var t_dist := 0.0

func _ready():
	for i in range(curve.point_count):
		var p = curve.get_point_position(i)
		var d = curve.get_closest_offset(p)
		stop_distances.append(d)
	
	if mode == "Loop":
		path.loop = true
	
	path.progress = stop_distances[0]
	t_dist = stop_distances[0]
	advance_index()

func manipulate():
	if is_moving:
		return
	print(mode, " Manipulate")
	is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if not is_moving or curr_ind >= stop_distances.size() or curr_ind<0: 
		#return
	#
	#var dist = t_dist - path.progress
	#var dir = 1 if going_forward else -1 
		#
	##Stop once reaching a point
	#if (dir > 0 and path.progress >= t_dist) or (dir < 0 and path.progress <= t_dist):
		#path.progress = t_dist
		#is_moving = false
		#advance_index()
		#return
	#
	#path.progress += delta * speed * dir

func _process(delta):
	if not is_moving or curr_ind >= stop_distances.size() or curr_ind < 0:
		return

	var total_length = curve.get_baked_length()
	var dir = 1 if going_forward else -1
	
	# Calculate distance accounting for wrap-around in Loop mode
	var dist = t_dist - path.progress
	if mode == "Loop":
		if dir > 0:
			dist = fmod(dist + total_length, total_length)
		else:
			dist = fmod(dist - total_length, total_length)

	# Stop once reaching a point
	if abs(dist) <= delta * speed:
		path.progress = t_dist
		is_moving = false
		advance_index()
		return

	path.progress += delta * speed * dir

	# Ensure progress wraps in Loop mode
	if mode == "Loop":
		path.progress = fmod(path.progress + total_length, total_length)


func advance_index():
	match mode:
		"Once":
			curr_ind += 1
			if curr_ind >= stop_distances.size():
				is_moving = false
				return
		"Loop":
			var next_ind = (curr_ind + 1) % stop_distances.size()
			var next_dist = stop_distances[next_ind]
			var current_dist = path.progress

			# Skip if next target equals current position
			if is_equal_approx(current_dist, next_dist):
				curr_ind = (next_ind + 1) % stop_distances.size()
			else:
				curr_ind = next_ind
		"Ping-Pong":
			if going_forward:
				if curr_ind >= stop_distances.size() - 1:
					going_forward = false
					curr_ind -= 1
				else:
					curr_ind += 1
			else:
				if curr_ind <= 0:
					going_forward = true
					curr_ind += 1
				else:
					curr_ind -= 1
	t_dist = stop_distances[curr_ind]
	print(curr_ind," ", mode)
