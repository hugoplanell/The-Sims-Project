extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if self.visible:
			self.visible = false
			#get_tree().paused = false
		else:
			self.visible = true
			#get_tree().paused = true

func _on_close_button_pressed():
	self.visible = false
	#get_tree().paused = false


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_game_options_button_pressed():
	#self.visible = false
	$"../GameOptions".visible = true
