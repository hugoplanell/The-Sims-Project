extends Node

@onready var root = $"../.."
@onready var camera = $"../../PlayerCamera"
@onready var mouse_target = preload("res://Scenes/mouse_target.tscn").instantiate()

signal transitioned(new_state)

enum {CHARACTER_MODE, BUILDING_MODE} #temporal, no deberia de estar

func enter():
	root.add_child.call_deferred(mouse_target)

func exit():
	mouse_target.queue_free()

func update(_delta: float):
	print(mouse_target)
	if Global.character_node != null:
		if Global.character_node.is_picked:
			camera.transform.origin = Global.character_node.transform.origin
		
		if camera.camera_panning == true:
			Global.character_node.is_picked = false

func physics_update(_delta: float):
	pass


func _on_player_camera_mouse_position_3d(position):
	if Global.character_node != null and root.state == CHARACTER_MODE: #mejorar esto
		if !Global.character_node.is_hovered:
			mouse_target.position = position
			
			if Input.is_action_just_pressed("left_click"):
				Global.character_node.nav.target_position = position
