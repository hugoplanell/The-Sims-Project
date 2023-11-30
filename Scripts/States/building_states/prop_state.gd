class_name PropBuildingState
extends State

@onready var current_scene = get_tree().get_current_scene() #mirar mejores formas de hacer esto(valorar un global)
@export var prop_library_resource : PropLibrary

var current_prop = null

var mouse_position : Vector3 = Vector3.ZERO

var active: bool = false

signal nav_mesh_changed

func enter():
	active = true
	current_prop = prop_library_resource.scenes[0].instantiate()
	add_child.call_deferred(current_prop)

func exit():
	active = false

func update(_delta: float):
	current_prop.position = mouse_position

func physics_update(_delta: float):
	#print("building_physics_update")
	pass

func _on_player_camera_mouse_position_3d(position):
	if active:
		if Input.is_action_just_pressed("left_click"):
			current_prop = prop_library_resource.scenes[0].instantiate()
			current_scene.get_node("NavigationRegion3D").add_child(current_prop)
			nav_mesh_changed.emit()
		
		#mouse_position = floor(position + Vector3(0.5,1,0.5))
		mouse_position = Vector3(floor(position.x + 0.5), position.y, floor(position.z + 0.5))
