extends Node

@onready var character_manager = $CharacterManager
@onready var buiding_manager = $BuildingManager

enum {CHARACTER_MODE, BUILDING_MODE}

# Called when the node enters the scene tree for the first time.
func _ready():
	character_manager.transitioned.connect(on_state_transition)
	match get_parent().state:
		CHARACTER_MODE:
			character_manager.enter()
		BUILDING_MODE:
			buiding_manager.enter()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match get_parent().state:
		CHARACTER_MODE:
			character_manager.update(delta)
		BUILDING_MODE:
			buiding_manager.update(delta)

func _physics_process(delta):
	match get_parent().state:
		CHARACTER_MODE:
			character_manager.physics_update(delta)
		BUILDING_MODE:
			buiding_manager.physics_update(delta)

func _input(event):
	pass
	#if Input.is_action_just_pressed()

func on_state_transition(new_state):
	
	match get_parent().state:
		CHARACTER_MODE:
			character_manager.exit()
		BUILDING_MODE:
			buiding_manager.exit()
	
	match new_state:
		CHARACTER_MODE:
			character_manager.enter()
		BUILDING_MODE:
			buiding_manager.enter()
	
	get_parent().state = new_state
