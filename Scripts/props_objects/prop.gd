class_name Prop3D
extends Node3D

var body : StaticBody3D
var is_hovered = false
var is_placed = false

var radial_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Prop3D"
	body = self.find_children("", "StaticBody3D")[0]
	body.connect("mouse_entered", _on_mouse_entered)
	body.connect("mouse_exited", _on_mouse_exited)
	
	#create_radial_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	is_hovered = true

func _on_mouse_exited():
	is_hovered = false

#func create_radial_menu():
	#radial_menu = RadialMenu.new()
	#radial_menu.size = Vector2(200,200)
	#radial_menu.visible = false
	#
	#var button1 = Button.new()
	#button1.text = "POOP"
	#
	#radial_menu.add_button(button1)
	#add_child(radial_menu)
