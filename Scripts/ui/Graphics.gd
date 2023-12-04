extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	match index:
		0:
			Graphics.set_low_graphics()
		1:
			print("1")
		2:
			Graphics.set_high_graphics()


func _on_check_button_toggled(toggled_on):
	if toggled_on: # Disabled (default)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else: # Enabled
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
