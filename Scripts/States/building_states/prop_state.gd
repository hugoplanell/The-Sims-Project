class_name PropBuildingState
extends State

@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)
@export var prop_library_resource : PropLibrary

var current_prop = null
var current_prop_idx : int = 0

var current_prop_reference = null

var mouse_position : Vector3 = Vector3.ZERO

var active: bool = false

signal nav_mesh_changed

func enter():
	active = true
	current_prop_reference = prop_library_resource.scenes[current_prop_idx].instantiate()
	#current_scene.get_node("NavigationRegion3D").add_child.call_deferred(current_prop)
	add_child.call_deferred(current_prop_reference)

func exit():
	current_prop.queue_free()
	active = false

func update(_delta: float):
	if current_prop_reference != null and current_prop_reference.is_hovered == false:
		current_prop_reference.position = mouse_position
	
	if Input.is_action_just_pressed("debug_prop_rotate_left"):
		current_prop_reference.rotate_y(PI/4)
	
	if Input.is_action_just_pressed("debug_prop_rotate_right"):
		current_prop_reference.rotate_y(-PI/4)
	
	if Input.is_action_just_pressed("debug_change_prop_up"):
		if current_prop_idx + 1 < prop_library_resource.scenes.size():
			current_prop_idx += 1
			current_prop_reference.queue_free()
			current_prop_reference = prop_library_resource.scenes[current_prop_idx].instantiate()
			add_child(current_prop_reference)
	elif Input.is_action_just_pressed("debug_change_prop_down"):
		if current_prop_idx - 1 >= 0:
			current_prop_idx -= 1
			current_prop_reference.queue_free()
			current_prop_reference = prop_library_resource.scenes[current_prop_idx].instantiate()
			add_child(current_prop_reference)
		

func physics_update(_delta: float):
	#print("building_physics_update")
	pass

func _on_player_camera_mouse_position_3d(position):
	if active:
		if Input.is_action_just_pressed("left_click"):
			current_prop = current_prop_reference.duplicate()
			#current_prop_reference.queue_free()
			current_scene.get_node("NavigationRegion3D").add_child(current_prop)
			nav_mesh_changed.emit()
			
			#current_prop_reference = prop_library_resource.scenes[current_prop_idx].instantiate()
			#add_child(current_prop_reference)
		
		#mouse_position = floor(position + Vector3(0.5,1,0.5))
		mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))

