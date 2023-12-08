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
		var building_states : Array = $StateManager/BuildingManager.states
		var current_building_state : State = $StateManager/BuildingManager.current_state
		var current_state_idx = building_states.find(current_building_state)
		
		if Input.is_action_just_pressed("debug_change_prop_up"):
			if current_state_idx + 1 < building_states.size():
				$StateManager/BuildingManager._on_child_transition_by_idx(current_state_idx + 1)
		
		if Input.is_action_just_pressed("debug_change_prop_down"):
			if current_state_idx - 1 >= 0:
				$StateManager/BuildingManager._on_child_transition_by_idx(current_state_idx - 1)
		
		"""if Input.is_action_just_pressed("debug_building_1"):
			$StateManager/BuildingManager._on_child_transition_by_name("WallBuilding")
		elif Input.is_action_just_pressed("debug_building_2"):
			$StateManager/BuildingManager._on_child_transition_by_name("GroundBuilding")
		elif Input.is_action_just_pressed("debug_building_3"):
			$StateManager/BuildingManager._on_child_transition_by_name("WcBuilding")"""

func _physics_process(delta):
	pass
