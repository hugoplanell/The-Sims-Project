extends Node3D

"""
TODO:
	-Hability to change the grid size
	-Code cleaning
	-Improve code to display the wall building
"""

const WALL_HEIGHT = 3
const WALL_THICKNESS = 0.2

@onready var wall_material = preload("res://Assets/Materials/Debug/debug_level.tres")

var arr = [null, null]
var build_ready = false

var temp_reference_cube : CSGBox3D

var mouse_position : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	
	temp_reference_cube = CSGBox3D.new()
	temp_reference_cube.position = mouse_position
	temp_reference_cube.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,WALL_THICKNESS)
	add_child(temp_reference_cube)
	
	"""
	var wall = CSGBox3D.new()
	wall.position = Vector3(0,3,0)
	wall.size = Vector3(5,WALL_HEIGHT,WALL_THICKNESS)
	add_child(wall)
	"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	temp_reference_cube.position = mouse_position
	
	if(build_ready):
		var wall = CSGBox3D.new()
		wall.material = wall_material
		
		#comprobar si el primer punto es mayor que el otro y si es asi cambiar el signo de la posicion a positivo o a negativo
		#creo que quitando el abs y comproba
		
		var size_x = (arr[1].x - arr[0].x)
		var size_z = (arr[1].z - arr[0].z)
		
		if abs(size_x) > abs(size_z):
			wall.position = Vector3(arr[0].x + size_x / 2,arr[0].y,arr[0].z)
			wall.size = Vector3(abs(size_x),WALL_HEIGHT,WALL_THICKNESS)
		else:
			wall.position = Vector3(arr[0].x,arr[0].y,arr[0].z + size_z / 2)
			wall.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,abs(size_z))
		add_child(wall)
		
		arr.clear()
		arr.resize(2)
		print("reset")
		build_ready = false


func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		if arr[0] == null:
			arr[0] = mouse_position
			print("first-stage")
		elif arr[1] == null:
			arr[1] = mouse_position
			print("second-stage")
			build_ready = true
	
	$CSGMesh3D.position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = floor(position + Vector3(0.5,2,0.5))
