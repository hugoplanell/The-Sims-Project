extends CharacterBody3D

const SPEED = 5.0
const ACCEL = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D

var is_picked = false

func _ready():
	Global.player_node = self
	
	var anim_player : AnimationPlayer = $character_1.get_node("AnimationPlayer")
	anim_player.play("walk")

func _process(delta):
	print(is_picked)

func _physics_process(delta):
	
	var direction = Vector3()
	
	if Input.is_action_just_pressed("left_click") and !is_picked:
		nav.target_position = Global.player_target_pos
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	move_and_slide()

func _on_input_event(camera, event, position, normal, shape_idx):
	
	if Input.is_action_just_pressed("left_click"):
		Global.camera_target = self

func _on_mouse_entered():
	is_picked = true

func _on_mouse_exited():
	is_picked = false



