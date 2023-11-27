class_name Ground3D
extends BuildingObject3D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = "Ground3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
