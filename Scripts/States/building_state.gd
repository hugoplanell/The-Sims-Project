class_name BuildingState
extends State

var arr = [null, null]

var reference_mesh : CSGBox3D

var mouse_position : Vector3 = Vector3.ZERO

signal nav_mesh_changed

func _ready():
	pass
	
func _exit_tree():
	pass
	
func _process(delta):
	pass

func _physics_process(delta):
	pass

func create_box3d_reference(size: Vector3):
	reference_mesh = CSGBox3D.new()
	reference_mesh.size = size
	add_child(reference_mesh)
