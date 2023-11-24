extends Node3D

@onready var character_manager = $CharacterManager
@onready var buiding_manager = $BuildingManager

enum {CHARACTER_MODE, BUILDING_MODE}

var state = CHARACTER_MODE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		CHARACTER_MODE:
			character_manager.update(delta)
		BUILDING_MODE:
			buiding_manager.update(delta)

func _physics_process(delta):
	match state:
		CHARACTER_MODE:
			character_manager.physics_update(delta)
		BUILDING_MODE:
			buiding_manager.physics_update(delta)

func _input(event):
	pass
	#if Input.is_action_just_pressed()
