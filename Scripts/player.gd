extends Node3D

enum {CHARACTER_MODE, BUILDING_MODE}

var state = CHARACTER_MODE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug_player_states"):
		if state == CHARACTER_MODE:
			$StateManager.on_state_transition(BUILDING_MODE)
		else:
			$StateManager.on_state_transition(CHARACTER_MODE)
			
	if state == BUILDING_MODE:
		if Input.is_action_just_pressed("debug_building_1"):
			$StateManager/BuildingManager._on_child_transition("WallBuilding")
		elif Input.is_action_just_pressed("debug_building_2"):
			$StateManager/BuildingManager._on_child_transition("GroundBuilding")
		elif Input.is_action_just_pressed("debug_building_3"):
			$StateManager/BuildingManager._on_child_transition("WcBuilding")

func _physics_process(delta):
	pass
