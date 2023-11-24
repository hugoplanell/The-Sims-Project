extends Node

@onready var camera = $"../PlayerCamera"
@onready var mouse_target = $"../MouseTarget"

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	if Global.character_node != null:
		if Global.character_node.is_picked:
			camera.transform.origin = Global.character_node.transform.origin
		
		if camera.camera_panning == true:
			Global.character_node.is_picked = false

func physics_update(_delta: float):
	pass


func _on_player_camera_mouse_position_3d(position):
	if Global.character_node != null:
		if !Global.character_node.is_hovered:
			mouse_target.position = position
			
			if Input.is_action_just_pressed("left_click"):
				Global.character_node.nav.target_position = position
