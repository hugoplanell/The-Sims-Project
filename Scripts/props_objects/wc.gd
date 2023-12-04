class_name WC
extends Prop3D

var b = null

var character_action = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	self.name = "WC"
	$AnimationPlayer.play("open_lid")
	b = Button.new()
	b.text = "cook"
	b.connect("button_down", _on_cook_button_down)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	
	if character_action == true:
		print("do pooping action")
	
	if is_hovered and is_placed:
		if Input.is_action_just_pressed("left_click"):
			b = Button.new()
			b.text = "cook"
			b.connect("button_down", _on_cook_button_down)
			add_child(b)
	else:
		if Input.is_action_just_pressed("left_click") and b != null:
			if !b.is_hovered():
				b.queue_free()

func _on_cook_button_down():
	Global.character_node.nav.target_position = $Area3D.global_position


func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		#body.get_node("CollisionShape3D").disabled = true
		character_action = true
		body.playback.start("poop")
