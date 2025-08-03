class_name ManipulatableBlock
extends Path2D

@export var path: PathFollow2D
@export var speed:float = 300.0
@export_enum("Once", "Ping-Pong", "Loop") var mode:String = "Once"

var is_moving := false
var curr_ind := 0
var going_forward := true
var stop_distances : Array[float] =  []

func _ready():
	
	for i in range(curve.point_count):
		var p = curve.get_point_position(i)
		var d = curve.get_closest_offset(p)
		stop_distances.append(d)
	
	if mode == "Loop":
		path.loop = true
	
	path.progress = stop_distances[0]
	

func manipulate():
	if is_moving:
		return
	print(mode, " Manipulate")
	is_moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_moving or curr_ind >= stop_distances.size() or curr_ind<0: 
		return
	
	var t = stop_distances[curr_ind]
	var dist = t - path.progress
	
	if mode == "Loop" and curr_ind ==0 and path.progress> t:
		path.progress = t
	
	var dir = sign(dist)
	
	if dir == 0:
		advance_index()
		if not is_moving:
			return
		t = stop_distances[curr_ind]
		dist = t - path.progress
		dir = sign(dist)
		
	path.progress += delta * speed * dir
	
	if (dir >0 and path.progress >= t) or (dir <0 and path.progress <= t):
		path.progress = t
		is_moving = false
		advance_index()

func advance_index():
	match mode:
		"Once":
			curr_ind += 1
		"Loop":
			curr_ind = (curr_ind + 1) % stop_distances.size()
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
	print(curr_ind," ", mode)
	
