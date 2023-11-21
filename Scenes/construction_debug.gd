extends Node3D

const WALL_HEIGHT = 3
const WALL_THICKNESS = 0.2

var arr = [null, null]
var build_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var wall = CSGBox3D.new()
	wall.position = Vector3(0,3,0)
	wall.size = Vector3(5,WALL_HEIGHT,WALL_THICKNESS)
	add_child(wall)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(build_ready):
		var wall = CSGBox3D.new()
		wall.position = Vector3(arr[0].x,3,arr[0].z)
		if (arr[1].x - arr[0].x) > (arr[1].z - arr[0].z):
			wall.size = Vector3(arr[1].x,WALL_HEIGHT,WALL_THICKNESS)
		else:
			wall.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,arr[1].z)
		add_child(wall)


func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		if arr[0] == null:
			arr[0] = position
		elif arr[1] == null:
			arr[1] = position
			build_ready = true
		else:
			arr.clear()
			arr.resize(2)
			build_ready = false
