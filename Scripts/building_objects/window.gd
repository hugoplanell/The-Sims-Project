class_name Window3D
extends BuildingObject3D

var body : StaticBody3D
var is_placed = false

var radial_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Window3D"
	body = self.find_children("", "StaticBody3D")[0]
	body.connect("mouse_entered", _on_mouse_entered)
	body.connect("mouse_exited", _on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func _on_mouse_entered():
	is_hovered = true

func _on_mouse_exited():
	is_hovered = false
