class_name DefaultWindow
extends Prop3D

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	self.name = "Window3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
