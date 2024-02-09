class_name GroundBuilding
extends BuildingState

const GROUND_THICKNESS = 0.1

@onready var ground_material = preload("res://Assets/Materials/Debug/debug_ground.tres")
@onready var current_scene = get_tree().get_current_scene()

func _ready():
	create_box3d_reference(Vector3(1,GROUND_THICKNESS,1))
	reference_mesh.material = ground_material

func _exit_tree():
	reference_mesh.queue_free()

func _process(delta):
	pass
	
func _physics_process(delta):
	reference_mesh.position = Vector3((mouse_position.x + 0.5), mouse_position.y + GROUND_THICKNESS / 2, (mouse_position.z + 0.5))
	
	if arr[0]:
		transform_ground(reference_mesh, arr[0], mouse_position)


func _on_player_camera_mouse_3d(position, body, normal):
	if Input.is_action_just_pressed("left_click"):
		if arr[0] == null:
			arr[0] = mouse_position
			print("first-stage")
		elif arr[1] == null:
			arr[1] = mouse_position
			print("second-stage")
			build()
	
	#$CSGMesh3D.position = floor(position + Vector3(0.5,1,0.5))
	#mouse_position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))

func build():
	var ground = Ground3D.new()
	ground.material = ground_material
	
	transform_ground(ground, arr[0], arr[1])
	ground.use_collision = true
	
	current_scene.get_node("NavigationRegion3D").add_child(ground)
	nav_mesh_changed.emit()
	
	reset_building()

func transform_ground(ground, first_pos, last_pos):
	var size_x = (last_pos.x - first_pos.x)
	var size_z = (last_pos.z - first_pos.z)
	
	ground.position = Vector3(first_pos.x + size_x / 2,first_pos.y + GROUND_THICKNESS / 2,first_pos.z + size_z / 2)
	ground.size = Vector3(abs(size_x),GROUND_THICKNESS,abs(size_z))

func reset_building():
	arr.clear()
	arr.resize(2)
	print("reset")
	
	reference_mesh.size = Vector3(1,GROUND_THICKNESS,1)
