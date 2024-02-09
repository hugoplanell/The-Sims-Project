class_name WindowBuilding
extends PropState

func _ready():
	prop_scene = preload("res://Assets/Models/Props/window_1/window_1.tscn")
	super()

func _exit_tree():
	super()

func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)

func _on_player_camera_mouse_3d(position, body, normal):
	if Input.is_action_just_pressed("left_click"):
		prop = prop_reference.duplicate()
		prop.is_placed = true
		
		body.add_child(prop)
		
		prop.global_position = mouse_position
		prop.position.z = 0 # temporal
		
		#nav_mesh_changed.emit()
	
	#mouse_position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = position
	#mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
