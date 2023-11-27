extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

enum BuildingMode {BUILD, REMOVE}

var current_building_mode = BuildingMode.BUILD

var active: bool = false

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)

func enter():
	active = true
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func exit():
	active = false
	current_state.exit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta: float):
	if current_state:
		current_state.update(_delta)
	
	if Input.is_action_just_pressed("debug_switch_building_mode"):
		if current_building_mode == BuildingMode.BUILD:
			current_building_mode = BuildingMode.REMOVE
			_on_child_transition(null)
			print("Remove Mode")
		else:
			current_building_mode = BuildingMode.BUILD
			_on_child_transition("Wall")
			print("Build Mode")

func physics_update(_delta: float):
	if current_state:
		current_state.physics_update(_delta)

func _on_child_transition(new_state_name):
	if new_state_name == null:
		current_state.exit()
		current_state = null
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state


func _on_player_camera_object_hovered(object):
	if active:
		object._hovered(current_building_mode)
		"""
		match current_building_mode:
			BuildingMode.BUILD:
				pass
			BuildingMode.REMOVE:
				pass
		"""
