extends Node

@export var initial_state_idx : int

var current_state : State
var current_state_idx

@export var builders_list : Resource

@onready var states : Array = builders_list.builders

enum BuildingMode {BUILD, REMOVE}

var current_building_mode = BuildingMode.BUILD

var hovering_object : BuildingObject3D = null

var active: bool = false

func _ready():
	pass
	#child.transitioned.connect(_on_child_transition_by_name)

func enter():
	active = true

	if initial_state_idx != null:
		current_state_idx = initial_state_idx
		current_state = states[initial_state_idx].new()
		$"../../PlayerCamera".connect("mouse_position_3d", current_state._on_player_camera_mouse_position_3d)
		add_child(current_state)

func exit():
	active = false
	current_state.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta: float):
	
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
	pass

#Mucho mas lento que por indice!!!
func _on_child_transition_by_name(new_state_name):
	if new_state_name == null:
		current_state.queue_free()
		current_state = null
		return
	
	var new_state = get_state_by_name(new_state_name)
	if !new_state:
		return
		
	if current_state:
		current_state.queue_free()
	
	current_state = new_state.new()
	current_state_idx = states.find(new_state)
	$"../../PlayerCamera".connect("mouse_position_3d", current_state._on_player_camera_mouse_position_3d)
	add_child(current_state)

func _on_child_transition_by_idx(new_state_idx):
	if new_state_idx == null:
		current_state.queue_free()
		current_state = null
		current_state_idx = null
		return
	
	var new_state = states[new_state_idx]
	if !new_state:
		return
		
	if current_state:
		current_state.queue_free()
		current_state_idx = null
		
	current_state = new_state.new()
	current_state_idx = states.find(new_state)
	$"../../PlayerCamera".connect("mouse_position_3d", current_state._on_player_camera_mouse_position_3d)
	add_child(current_state)

func get_state_by_name(name: String):
	for state in states:
		var state_node = state.new()
		if state_node.name.to_lower() == name.to_lower():
			state_node.queue_free()
			return state
		state_node.queue_free()

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
