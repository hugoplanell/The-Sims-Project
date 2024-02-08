class_name RoomBuilding
extends BuildingState

var walls : Array[WallBuilding]
var ground : GroundBuilding
var firstClick : bool = false

func _ready():
	for i in range(4):
		walls.push_back(WallBuilding.new())
		add_child(walls[i])
	
	ground = GroundBuilding.new()
	add_child(ground)

func _physics_process(delta):
	pass
	
func _on_player_camera_mouse_3d(position, body):
	mouse_position = floor(position + Vector3(0.5,2,0.5))
	
	if firstClick:
		#update reference mesh
		#wall
		for i in range(4):
			walls[i].mouse_position = get_last_wall_pos(i)
			print(walls[i].mouse_position, mouse_position)
		
		#ground
		ground.mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
		
		if Input.is_action_just_pressed("left_click"):
			#wall
			for i in range(4):
				walls[i].arr[1] = get_last_wall_pos(i)
				walls[i].build()
			#ground
			mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
			ground.arr[1] = mouse_position
			ground.build()
			firstClick = false
		
	else:
		#update reference mesh
		for i in range(4):
			walls[i].mouse_position = mouse_position
		
		if Input.is_action_just_pressed("left_click"):
			#walls
			for i in range(4):
				walls[i].arr[0] = mouse_position
			#ground
			mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
			ground.arr[0] = mouse_position
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
