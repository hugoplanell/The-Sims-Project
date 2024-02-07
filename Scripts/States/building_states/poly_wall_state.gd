class_name PolyWallBuilding
extends BuildingState

const WALL_HEIGHT = 3
const WALL_THICKNESS = 0.2

@onready var wall_material = preload("res://Assets/Materials/Debug/debug_wall.tres")
@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)


func _ready():
	create_box3d_reference(Vector3(WALL_THICKNESS,WALL_HEIGHT,WALL_THICKNESS))
	reference_mesh.material = wall_material

func _exit_tree():
	reference_mesh.queue_free()

func _process(delta):
	pass

func _physics_process(delta):
	reference_mesh.position = mouse_position
	if arr[0]:
		transform_wall(reference_mesh, arr[0], mouse_position)

func _on_player_camera_mouse_3d(position, body):
	mouse_position = floor(position + Vector3(0.5,2,0.5))
	
	if Input.is_action_just_pressed("left_click"):
		if !arr[0]:
			arr[0] = mouse_position
			print("first-stage")
		elif !arr[1]:
			arr[1] = mouse_position
			print("second-stage")
			build()
	
func transform_wall(wall, first_pos, last_pos):
	var wall_size : Vector3 = Vector3(last_pos.x - arr[0].x, 1, last_pos.z - arr[0].z)
	
	var first_pos_v2 = Vector2(first_pos.x, first_pos.z)
	var last_pos_v2 = Vector2(last_pos.x, last_pos.z)

	var angle = Vector2.LEFT.angle_to(first_pos_v2 - last_pos_v2)
	
	wall.rotation.y = (-angle)
	wall.position = Vector3(first_pos.x + (last_pos.x -first_pos.x) / 2,first_pos.y,first_pos.z + (last_pos.z -first_pos.z) / 2)
	wall.size = Vector3(first_pos.distance_to(last_pos),WALL_HEIGHT,WALL_THICKNESS)

func build():
	var wall = Wall3D.new()
	wall.material = wall_material
	#wall.material = wall_material.duplicate()
	#wall.material.albedo_color = Color.from_hsv((randi() % 12) / 12.0, 1, 1)
	
	transform_wall(wall, arr[0], arr[1])
	wall.use_collision = true
	
	current_scene.get_node("NavigationRegion3D").add_child(wall)
	nav_mesh_changed.emit()
	
	reset_building()

func reset_building():
	#arr.clear()
	#arr.resize(2)
	arr[0] = arr[1]
	arr[1] = null
	print("reset")
	reference_mesh.size = Vector3(WALL_THICKNESS,WALL_HEIGHT,WALL_THICKNESS)

