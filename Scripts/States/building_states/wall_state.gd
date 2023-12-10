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
		
		transform_wall(wall, arr[0], arr[1])
		wall.use_collision = true
		
		current_scene.get_node("NavigationRegion3D").add_child(wall)
		
		#current_scene.get_node("NavigationRegion3D").bake_navigation_mesh()
		nav_mesh_changed.emit()
		
		reset_building()
	
	if arr[0]:
		transform_wall(temp_reference_cube, arr[0], mouse_position)
		
		if Input.is_action_just_pressed("right_click"):
			reset_building()

func transform_wall(wall, first_pos, last_pos):
	
	var wall_size : Vector3 = Vector3(last_pos.x - arr[0].x, 1, last_pos.z - arr[0].z)
	
	var first_pos_v2 = Vector2(first_pos.x, first_pos.z)
	var last_pos_v2 = Vector2(last_pos.x, last_pos.z)

	var angle = Vector2.LEFT.angle_to(first_pos_v2 - last_pos_v2)
	
	wall.rotation.y = (-angle)
	wall.position = Vector3(first_pos.x + (last_pos.x -first_pos.x) / 2,first_pos.y,first_pos.z + (last_pos.z -first_pos.z) / 2)
	wall.size = Vector3(first_pos.distance_to(last_pos),WALL_HEIGHT,WALL_THICKNESS)

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
