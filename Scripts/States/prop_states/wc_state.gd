class_name WcBuilding
extends PropState

func enter():
	current_prop_idx = 0
	super()

func exit():
	super()

func update(_delta: float):
	super(_delta)

func physics_update(_delta: float):
	super(_delta)

#esto no se como gestinonarlo
func _on_player_camera_mouse_position_3d(position):
	super(position)
