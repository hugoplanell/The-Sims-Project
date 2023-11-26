extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

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

func physics_update(_delta: float):
	if current_state:
		current_state.physics_update(_delta)

func _on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
