class_name WC
extends Prop3D

var character_action = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	self.name = "WC"
	$AnimationPlayer.play("open_lid")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	
	if character_action == true:
		if Global.character_node.velocity.length() == 0:
			var a = Quaternion(Global.character_node.transform.basis)
			var b = Quaternion(self.transform.basis)
			#if !is_equal_approx(a,b):
			Global.character_node.transform.basis = Basis(a.slerp(b,0.1))
			Global.character_node.playback.start("poop")
			print("do pooping action")
	
	if Input.is_action_just_pressed("left_click"):
			if is_hovered and is_placed and radial_menu == null:
				create_radial_menu()
			elif radial_menu != null:
				radial_menu.queue_free()

func _on_cook_button_pressed():
	Global.character_node.nav.target_position = $Area3D.global_position

func _on_flush_button_pressed():
	$AnimationPlayer.play("flush")

func _on_open_lid_button_pressed():
	if $AnimationPlayer.assigned_animation != "open_lid": $AnimationPlayer.play("open_lid")

func _on_close_lid_button_pressed():
	if $AnimationPlayer.assigned_animation != "close_lid": $AnimationPlayer.play("close_lid")

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		#body.get_node("CollisionShape3D").disabled = true
		character_action = true

func create_radial_menu():
	radial_menu = RadialMenu.new()
	radial_menu.size = Vector2(200,200)
	radial_menu.position = get_viewport().get_mouse_position() - radial_menu.size/2
	
	var buttons: Array
	
	var button1 = Button.new()
	button1.text = "Poop"
	button1.connect("button_down", _on_cook_button_pressed)
	buttons.append(button1)
	
	var button2 = Button.new()
	button2.text = "Flush"
	button2.connect("button_down", _on_flush_button_pressed)
	buttons.append(button2)
	
	var button3 = Button.new()
	button3.text = "Open Lid"
	button3.connect("button_down", _on_open_lid_button_pressed)
	buttons.append(button3)
	
	var button4 = Button.new()
	button4.text = "Close Lid"
	button4.connect("button_down", _on_close_lid_button_pressed)
	buttons.append(button4)
	
	for b in buttons:
		radial_menu.add_button(b)
	
	add_child(radial_menu)
