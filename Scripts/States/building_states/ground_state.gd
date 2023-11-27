class_name GroundBuildingState
extends State

const GROUND_THICKNESS = 0.2

#@onready var wall_material = preload("res://Assets/Materials/Debug/debug_level.tres")
@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)

var arr = [null, null]
var build_ready = false

var temp_reference_cube : CSGBox3D

var mouse_position : Vector3 = Vector3.ZERO

var active: bool = false

signal nav_mesh_changed

func enter():
	active = true
	temp_reference_cube = CSGBox3D.new()
	temp_reference_cube.position = mouse_position
	temp_reference_cube.size = Vector3(1,GROUND_THICKNESS,1)
	add_child(temp_reference_cube)

func exit():
	active = false
	temp_reference_cube.queue_free()

func update(_delta: float):
	temp_reference_cube.position = Vector3(floor(mouse_position.x + 0.5), mouse_position.y, floor(mouse_position.z + 0.5))
	#current_scene.get_node("Lighting").get_node("VoxelGI").bake()
	
	if(build_ready):
		var ground = CSGBox3D.new()
		#ground.material = wall_material
		
		var size_x = (arr[1].x - arr[0].x)
		var size_z = (arr[1].z - arr[0].z)
		
		ground.position = Vector3(arr[0].x + size_x / 2,arr[0].y,arr[0].z + size_z / 2)
		ground.size = Vector3(abs(size_x),GROUND_THICKNESS,abs(size_z))
		
		ground.use_collision = true
		
		current_scene.get_node("NavigationRegion3D").add_child(ground)
		
		#current_scene.get_node("NavigationRegion3D").bake_navigation_mesh()
		
		nav_mesh_changed.emit()
		
		arr.clear()
		arr.resize(2)
		print("reset")
		build_ready = false
		
		temp_reference_cube.position = mouse_position
		temp_reference_cube.size = Vector3(1,GROUND_THICKNESS,1)
	
	if arr[0]:
		var size_x = (mouse_position.x - arr[0].x)
		var size_z = (mouse_position.z - arr[0].z)
		
		temp_reference_cube.position = Vector3(arr[0].x + size_x / 2,arr[0].y,arr[0].z + size_z / 2)
		temp_reference_cube.size = Vector3(abs(size_x),GROUND_THICKNESS,abs(size_z))
	
	
func physics_update(_delta: float):
	#print("building_physics_update")
	pass


func _on_player_camera_mouse_position_3d(position):
	if active:
		if Input.is_action_just_pressed("left_click"):
			if arr[0] == null:
				arr[0] = mouse_position
				print("first-stage")
			elif arr[1] == null:
				arr[1] = mouse_position
				print("second-stage")
				build_ready = true
		
		#$CSGMesh3D.position = floor(position + Vector3(0.5,1,0.5))
		#mouse_position = floor(position + Vector3(0.5,1,0.5))
		mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
