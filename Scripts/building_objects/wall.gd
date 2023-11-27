class_name Wall3D
extends BuildingObject3D

@onready var outline_material = preload("res://Assets/Materials/pixel_perfect_outline.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Wall3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _hovered(remove):
	self.material_overlay = outline_material
	
	if remove and Input.is_action_just_pressed("left_click"):
		self.queue_free()
