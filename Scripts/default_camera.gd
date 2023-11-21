extends Node3D

var mouse_speed : Vector2

func _physics_process(delta):
	
	var space_state = get_world_3d().direct_space_state
	
	var from = $DefaultCamera/Camera3D.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + $DefaultCamera/Camera3D.project_ray_normal(get_viewport().get_mouse_position()) * 1000
	
	var raycast = PhysicsRayQueryParameters3D.create(from, to)
	
	var intersection = space_state.intersect_ray(raycast)
	
	if not intersection.is_empty():
		Global.player_target_pos = intersection.position
	
	#Update mouse speed
	mouse_speed = Input.get_last_mouse_velocity()
	
	if Input.is_action_pressed("middle_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		#hacer el producto escalar con la rotacion de la camara para sacar la direccion de movimiento
		self.transform.origin += Vector3(mouse_speed.x / 1000, 0, mouse_speed.y / 1000)
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
