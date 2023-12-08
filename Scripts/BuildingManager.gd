extends Node

@export var initial_state_idx : int

var current_state : State
var states : Array[State]

enum BuildingMode {BUILD, REMOVE}

var current_building_mode = BuildingMode.BUILD

var hovering_object : BuildingObject3D = null

var active: bool = false

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.transitioned.connect(_on_child_transition_by_name)

func enter():
	active = true

	if initial_state_idx != null:
		states[initial_state_idx].enter()
		current_state = states[initial_state_idx]

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
			_on_child_transition_by_name(null)
			print("Remove Mode")
		else:
			current_building_mode = BuildingMode.BUILD
			_on_child_transition_by_name("WallBuilding")
			print("Build Mode")

func physics_update(_delta: float):
	if current_state:
		current_state.physics_update(_delta)

func _on_child_transition_by_name(new_state_name):
	if new_state_name == null:
		current_state.exit()
		current_state = null
		return
	
	var new_state = get_state_by_name(new_state_name)
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state

func _on_child_transition_by_idx(new_state_idx):
	if new_state_idx == null:
		current_state.exit()
		current_state = null
		return
	
	var new_state = states[new_state_idx]
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state

func get_state_by_name(name: String):
	for state in states:
		if state.name.to_lower() == name.to_lower():
			return state

func _on_player_camera_object_hovered(object):
	if active:
		if current_building_mode == BuildingMode.REMOVE:
			if hovering_object and object:
				if hovering_object != object:
					hovering_object.is_hovered = false
					hovering_object = object
					hovering_object.is_hovered = true
			elif !hovering_object and object:
					hovering_object = object
					hovering_object.is_hovered = true
			elif hovering_object and !object:
				if hovering_object != null: hovering_object.is_hovered = false
				hovering_object = null
