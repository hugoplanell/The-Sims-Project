extends Node

@onready var root = $"../.."
@onready var camera = $"../../PlayerCamera"
@onready var mouse_target_scene = preload("res://Scenes/mouse_target.tscn")

var mouse_target = null

signal transitioned(new_state)

var active: bool = false

func enter():
	active = true
	mouse_target = mouse_target_scene.instantiate()
	root.add_child.call_deferred(mouse_target)

func exit():
	mouse_target.queue_free()
	active = false

func update(_delta: float):
	#print(mouse_target)
	if Global.character_node != null:
		if Global.character_node.is_picked:
			camera.transform.origin = Global.character_node.transform.origin
		
		if camera.camera_panning == true:
			Global.character_node.is_picked = false

func physics_update(_delta: float):
	pass


func _on_player_camera_mouse_position_3d(position):
	if Global.character_node != null and active: #mejorar esto
		if !Global.character_node.is_hovered:
			mouse_target.position = position
			
			if Input.is_action_just_pressed("left_click"):
				Global.character_node.nav.target_position = position
