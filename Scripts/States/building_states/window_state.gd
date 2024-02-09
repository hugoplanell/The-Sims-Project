class_name WindowBuilding
extends BuildingState

@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)
var prop_scene : PackedScene

var prop : CSGBox3D = null
var prop_reference : CSGBox3D = null

func _ready():
	prop_scene = preload("res://Assets/Models/Props/window_1/window_1.tscn")
	prop_reference = prop_scene.instantiate()
	#current_scene.get_node("NavigationRegion3D").add_child.call_deferred(current_prop)
	add_child.call_deferred(prop_reference)

func _exit_tree():
	prop_reference.queue_free()

func _process(delta):
	if prop_reference != null and prop_reference.is_hovered == false:
		prop_reference.global_position = mouse_position

func _physics_process(delta):
	pass

func _on_player_camera_mouse_3d(position, body, normal):
	if Input.is_action_just_pressed("left_click"):
		prop = prop_reference.duplicate()
		prop.is_placed = true
		
		body.add_child(prop)
		
		prop.global_position = mouse_position
		prop.position.z = 0 # temporal
		
		nav_mesh_changed.emit()
	
	#mouse_position = floor(position + Vector3(0.5,1,0.5))
	mouse_position = position
	#mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
