class_name WallBuilding
extends BuildingState

const WALL_HEIGHT = 3
const WALL_THICKNESS = 0.2

@onready var wall_material = preload("res://Assets/Materials/Debug/debug_wall.tres")
@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)

var arr = [null, null]
var build_ready = false

var temp_reference_cube : CSGBox3D

var mouse_position : Vector3 = Vector3.ZERO

signal nav_mesh_changed

func _ready():
	temp_reference_cube = CSGBox3D.new()
	temp_reference_cube.position = mouse_position
	temp_reference_cube.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,WALL_THICKNESS)
	add_child(temp_reference_cube)

func _exit_tree():
	temp_reference_cube.queue_free()

func _process(delta):
	temp_reference_cube.position = mouse_position
	#current_scene.get_node("Lighting").get_node("VoxelGI").bake()
	
	if(build_ready):
		var wall = Wall3D.new()
		wall.material = wall_material
		#wall.material = wall_material.duplicate()
		#wall.material.albedo_color = Color.from_hsv((randi() % 12) / 12.0, 1, 1)
		
		var size_x = (arr[1].x - arr[0].x)
		var size_z = (arr[1].z - arr[0].z)
		
		if abs(size_x) > abs(size_z):
			wall.position = Vector3(arr[0].x + size_x / 2,arr[0].y,arr[0].z)
			wall.size = Vector3(abs(size_x),WALL_HEIGHT,WALL_THICKNESS)
		else:
			wall.position = Vector3(arr[0].x,arr[0].y,arr[0].z + size_z / 2)
			wall.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,abs(size_z))
		wall.use_collision = true
		
		current_scene.get_node("NavigationRegion3D").add_child(wall)
		
		#current_scene.get_node("NavigationRegion3D").bake_navigation_mesh()
		
		nav_mesh_changed.emit()
		
		reset_building()
	
	if arr[0]:
		var size_x = (mouse_position.x - arr[0].x)
		var size_z = (mouse_position.z - arr[0].z)
		
		if abs(size_x) > abs(size_z):
			temp_reference_cube.position = Vector3(arr[0].x + size_x / 2,arr[0].y,arr[0].z)
			temp_reference_cube.size = Vector3(abs(size_x),WALL_HEIGHT,WALL_THICKNESS)
		else:
			temp_reference_cube.position = Vector3(arr[0].x,arr[0].y,arr[0].z + size_z / 2)
			temp_reference_cube.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,abs(size_z))
		
		if Input.is_action_just_pressed("right_click"):
			reset_building()

func _physics_process(delta):
	#print("building_physics_update")
	pass

func _on_player_camera_mouse_3d(position, body):
	if Input.is_action_just_pressed("left_click"):
		if arr[0] == null:
			arr[0] = mouse_position
			print("first-stage")
		elif arr[1] == null:
			arr[1] = mouse_position
			print("second-stage")
			build_ready = true
	
	#$CSGMesh3D.position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = floor(position + Vector3(0.5,2,0.5))

func reset_building():
	arr.clear()
	arr.resize(2)
	print("reset")
	build_ready = false
	
	temp_reference_cube.position = mouse_position
	temp_reference_cube.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,WALL_THICKNESS)
