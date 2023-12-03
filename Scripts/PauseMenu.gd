extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		self.visible = false if self.visible else true

func _on_close_button_pressed():
	self.visible = false


func _on_exit_game_button_pressed():
	get_tree().quit()
