class_name Wall3D
extends BuildingObject3D

@onready var outline_material = preload("res://Assets/Materials/pixel_perfect_outline.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Wall3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_hovered:
		if self.material_overlay != outline_material: self.material_overlay = outline_material
		if Input.is_action_just_pressed("left_click"): queue_free()
	else:
		if self.material_overlay != null: self.material_overlay = null
