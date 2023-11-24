extends Node3D

@onready var mouse_target = $"../MouseTarget"

var mouse_speed : Vector2

var camera_panning = false
@export var panning_speed:float = 1.0

func _process(delta):
	if Global.character_node != null:
		if Global.character_node.is_picked:
			self.transform.origin = Global.character_node.transform.origin
		
		if camera_panning == true:
			Global.character_node.is_picked = false
	
	#reset mouse_speed when mouse is not moving
	mouse_speed = Vector2.ZERO
	
func _physics_process(delta):

	mouse_raycast(delta)
	camera_pan(delta)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_speed = event.relative

func camera_pan(delta: float):
	var angle = (self.global_rotation.y + $CameraTracker/Camera3D.global_rotation.y)
	
	if Input.is_action_pressed("middle_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		self.transform.origin += Vector3(mouse_speed.x * delta * panning_speed, 0, mouse_speed.y * delta * panning_speed).rotated(Vector3(0,1,0), angle)
		camera_panning = true
	
	elif Input.get_vector("camera_pan_forwards", "camera_pan_backwards", "camera_pan_left", "camera_pan_right"):
		var input_dir = Input.get_vector("camera_pan_forwards", "camera_pan_backwards", "camera_pan_left", "camera_pan_right")
		var direction = (transform.basis * Vector3(input_dir.y, 0, input_dir.x)).normalized()
		self.transform.origin += direction.rotated(Vector3(0,1,0), angle) * delta * 10
		camera_panning = true
	
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camera_panning = false
		
func mouse_raycast(delta: float):
	var space_state = get_world_3d().direct_space_state
	
	var from = $CameraTracker/Camera3D.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + $CameraTracker/Camera3D.project_ray_normal(get_viewport().get_mouse_position()) * 1000
	
	var raycast = PhysicsRayQueryParameters3D.create(from, to)
	
	var intersection = space_state.intersect_ray(raycast)
	
	if !intersection.is_empty():
		if Global.character_node != null:
			if !Global.character_node.is_hovered:
				mouse_target.position = intersection.position
				
				if Input.is_action_just_pressed("left_click"):
					Global.character_node.nav.target_position = intersection.position


