class_name RoomBuilding
extends BuildingState


# Called when the node enters the scene tree for the first time.

var walls : Array[WallBuilding]
var firstClick : bool = false

func _ready():
	for i in range(4):
		walls.push_back(WallBuilding.new())
		add_child(walls[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_camera_mouse_3d(position, body):
	mouse_position = floor(position + Vector3(0.5,2,0.5))
	
	for i in range(4):
		transform_wall(walls[i].reference_mesh, i)
	
	if Input.is_action_just_pressed("left_click"):
		if !firstClick:
			for i in range(4):
				walls[i].arr[0] = mouse_position
			firstClick = true
		else:
			for i in range(4):
				transform_wall(walls[i], i)
				walls[i].build()
			
			#walls[0].arr[1] = Vector3(mouse_position.x, mouse_position.y, walls[0].arr[0].z)
			#walls[0].build()
			
			#walls[1].arr[0] = Vector3(mouse_position.x, mouse_position.y, walls[1].arr[0].z)
			#walls[1].arr[1] = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
			#walls[1].build()
			
			#walls[2].arr[0] = Vector3(walls[2].arr[0].x, mouse_position.y, mouse_position.z)
			#walls[2].arr[1] = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
			#walls[2].build()
			
			#walls[3].arr[1] = Vector3(walls[3].arr[0].x, mouse_position.y, mouse_position.z)
			#walls[3].build()
			
			firstClick = false

func transform_wall(wall, wall_idx):
	match wall_idx:
		0:
			wall.arr[1] = Vector3(mouse_position.x, mouse_position.y, walls[wall_idx].arr[0].z)
		1:
			wall.arr[0] = Vector3(mouse_position.x, mouse_position.y, walls[wall_idx].arr[0].z)
			wall.arr[1] = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
		2:
			wall.arr[0] = Vector3(walls[wall_idx].arr[0].x, mouse_position.y, mouse_position.z)
			wall.arr[1] = Vector3(mouse_position.x, mouse_position.y, mouse_position.z)
		3:
			wall.arr[1] = Vector3(walls[wall_idx].arr[0].x, mouse_position.y, mouse_position.z)
