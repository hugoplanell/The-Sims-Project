class_name PropState
extends State

@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)
var prop_scene : PackedScene

var prop = null

var prop_reference = null

var mouse_position : Vector3 = Vector3.ZERO

signal nav_mesh_changed

func _ready():
	prop_reference = prop_scene.instantiate()
	#current_scene.get_node("NavigationRegion3D").add_child.call_deferred(current_prop)
	add_child.call_deferred(prop_reference)

func _exit_tree():
	prop_reference.queue_free()

func _process(delta):
	if prop_reference != null and prop_reference.is_hovered == false:
		prop_reference.position = mouse_position
	
	if Input.is_action_just_pressed("debug_prop_rotate_left"):
		prop_reference.rotate_y(PI/4)
	
	if Input.is_action_just_pressed("debug_prop_rotate_right"):
		prop_reference.rotate_y(-PI/4)

func _physics_process(delta):
	pass

func _on_player_camera_mouse_position_3d(position):
	if Input.is_action_just_pressed("left_click"):
		prop = prop_reference.duplicate()
		#current_prop_reference.queue_free()
		prop.is_placed = true
		current_scene.get_node("NavigationRegion3D").add_child(prop)
		nav_mesh_changed.emit()
		
		#current_prop_reference = prop_library_resource.scenes[current_prop_idx].instantiate()
		#add_child(current_prop_reference)
	
	#mouse_position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))

