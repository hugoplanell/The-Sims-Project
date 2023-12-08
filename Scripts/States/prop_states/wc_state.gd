class_name WcBuilding
extends PropState


func _ready():
	prop_scene = preload("res://Assets/Models/Props/wc_1/wc_1.tscn")
	super()
	
func _exit_tree():
	super()
	
func _process(delta):
	super(delta)

func _physics_process(delta):
	super(delta)
