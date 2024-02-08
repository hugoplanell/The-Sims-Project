class_name RoomBuilding
extends BuildingState

var walls : Array[WallBuilding]
var firstClick : bool = false

func _ready():
	for i in range(4):
		walls.push_back(WallBuilding.new())
		add_child(walls[i])

func _physics_process(delta):
	pass
	
func _on_player_camera_mouse_3d(position, body):
	mouse_position = floor(position + Vector3(0.5,2,0.5))
	
	if firstClick:
		#update reference mesh
		for i in range(4):
			walls[i].mouse_position = get_last_wall_pos(i)
			print(walls[i].mouse_position, mouse_position)
		
		if Input.is_action_just_pressed("left_click"):
			for i in range(4):
				walls[i].arr[1] = get_last_wall_pos(i)
				walls[i].build()
			firstClick = false
		
	else:
		#update reference mesh
		for i in range(4):
			walls[i].mouse_position = mouse_position
		
		if Input.is_action_just_pressed("left_click"):
			for i in range(4):
				walls[i].arr[0] = mouse_position
			firstClick = true

func get_last_wall_pos(idx):
	var last_pos
	match idx:
		0:
			last_pos = Vector3(mouse_position.x, mouse_position.y, walls[idx].arr[0].z)
		1:
			walls[idx].arr[0] = Vector3(mouse_position.x, mouse_position.y, walls[idx].arr[0].z)
			last_pos = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
		2:
			walls[idx].arr[0] = Vector3(walls[idx].arr[0].x, mouse_position.y, mouse_position.z)
			last_pos = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
		3:
			last_pos = Vector3(walls[idx].arr[0].x, mouse_position.y, mouse_position.z)
	
	return last_pos
