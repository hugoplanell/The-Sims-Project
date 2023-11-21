extends Node3D

var mouse_speed : Vector2

var camera_panning = false

func _process(delta):
	if Global.camera_target != null:
		self.transform.origin = Global.camera_target.transform.origin
	
	if camera_panning == true:
		Global.camera_target = null

func _physics_process(delta):
	#Update mouse speed
	mouse_speed = Input.get_last_mouse_velocity()
	
	mouse_raycast()
	camera_pan()

func camera_pan():
	var angle = (self.global_rotation.y + $DefaultCamera/Camera3D.global_rotation.y)
	
	if Input.is_action_pressed("middle_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		self.transform.origin += Vector3(mouse_speed.x / 1000, 0, mouse_speed.y / 1000).rotated(Vector3(0,1,0), angle)
		camera_panning = true
	
	elif Input.get_vector("camera_pan_forwards", "camera_pan_backwards", "camera_pan_left", "camera_pan_right"):
		var input_dir = Input.get_vector("camera_pan_forwards", "camera_pan_backwards", "camera_pan_left", "camera_pan_right")
		var direction = (transform.basis * Vector3(input_dir.y, 0, input_dir.x)).normalized()
		self.transform.origin += direction.rotated(Vector3(0,1,0), angle)
		camera_panning = true
	
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camera_panning = false
		
func mouse_raycast():
	var space_state = get_world_3d().direct_space_state
	
	var from = $DefaultCamera/Camera3D.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + $DefaultCamera/Camera3D.project_ray_normal(get_viewport().get_mouse_position()) * 1000
	
	var raycast = PhysicsRayQueryParameters3D.create(from, to)
	
	var intersection = space_state.intersect_ray(raycast)
	
	if not intersection.is_empty():
		if !Global.player_node.is_picked:
			Global.player_target_pos = intersection.position
