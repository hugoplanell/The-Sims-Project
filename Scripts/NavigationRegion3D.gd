extends NavigationRegion3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#mejorar esta parte para no tener que conectar esto a cada nodo que necesite modificar el nav_mesh
	#$"..".get_node("Player/StateManager/BuildingManager/WallBuilding").connect("nav_mesh_changed", _on_nav_mesh_changed)
	#$"..".get_node("Player/StateManager/BuildingManager/GroundBuilding").connect("nav_mesh_changed", _on_nav_mesh_changed)
	#$"..".get_node("Player/StateManager/BuildingManager/WcBuilding").connect("nav_mesh_changed", _on_nav_mesh_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_nav_mesh_changed():
	await get_tree().create_timer(0.01).timeout #ajustar el tiempo
	bake_navigation_mesh()
