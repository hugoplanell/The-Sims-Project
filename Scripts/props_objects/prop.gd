class_name Prop3D
extends Node3D

var body : StaticBody3D
var is_hovered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Prop3D"
	body = self.find_children("", "StaticBody3D")[0]
	body.connect("mouse_entered", _on_mouse_entered)
	body.connect("mouse_exited", _on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_hovered:
		print("hovered")

func _on_mouse_entered():
	is_hovered = true

func _on_mouse_exited():
	is_hovered = false
