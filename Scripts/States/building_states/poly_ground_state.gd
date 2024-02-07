class_name PolyGroundBuilding
extends BuildingState

const GROUND_THICKNESS = 0.1

@onready var ground_material = preload("res://Assets/Materials/Debug/debug_ground.tres")
@onready var current_scene = get_tree().get_current_scene()

var points : Array[Vector2]

func _ready():
	reference_mesh = CSGPolygon3D.new()
	reference_mesh.rotation.x = deg_to_rad(90)
	reference_mesh.polygon = points
	reference_mesh.depth = GROUND_THICKNESS
	reference_mesh.position.y = mouse_position.y + 0.53
	reference_mesh.material = ground_material
	add_child(reference_mesh)

func _exit_tree():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		build()
	
func _physics_process(delta):
	pass

func _on_player_camera_mouse_3d(position, body):
	mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
	
	if Input.is_action_just_pressed("left_click"):
		points.append(Vector2(mouse_position.x, mouse_position.z))
		if points.size() > 2:
			reference_mesh.polygon = points

func build():
	var ground = CSGPolygon3D.new()
	ground.material = ground_material
	
	ground.rotation.x = deg_to_rad(90)
	ground.polygon = points
	ground.depth = GROUND_THICKNESS
	ground.position.y = mouse_position.y
	ground.use_collision = true
	
	current_scene.get_node("NavigationRegion3D").add_child(ground)
	nav_mesh_changed.emit()
	
	reset_building()

func transform_ground(ground, first_pos, last_pos):
	var size_x = (last_pos.x - first_pos.x)
	var size_z = (last_pos.z - first_pos.z)
	
	ground.position = Vector3(first_pos.x + size_x / 2,first_pos.y,first_pos.z + size_z / 2)
	ground.size = Vector3(abs(size_x),GROUND_THICKNESS,abs(size_z))

func reset_building():
	points.clear()
	#arr.resize(2)
	print("reset")
	
	if reference_mesh != null: reference_mesh.polygon = points
