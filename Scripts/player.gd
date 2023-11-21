extends CharacterBody3D

const SPEED = 2.0
const ACCEL = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D

var anim_player : AnimationPlayer

var is_picked = false

func _ready():
	Global.player_node = self
	
	anim_player = $character_1.get_node("AnimationPlayer")
	anim_player.play("walk")

func _process(delta):
	pass

func _physics_process(delta):
	
	var direction = Vector3()
	
	if Input.is_action_just_pressed("left_click") and !is_picked:
		nav.target_position = Global.player_target_pos
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if velocity.length() > 0: #Ajustar este numero para corregir la transición
		#self.look_at(Vector3(-nav.target_position.x, 2, -nav.target_position.z)) #funciona a medias (este deberia de ser mejor)
		var lookdir = atan2(velocity.x, velocity.z)
		print(rotation.y, lookdir)
		#rotation.y = lerp(rotation.y, lookdir, 0.1)
		if rotation.y != lookdir:
			rotate_y(lookdir - rotation.y)
		anim_player.current_animation = "walk"
	else:
		anim_player.current_animation = "Action_001"
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	move_and_slide()

func _on_input_event(camera, event, position, normal, shape_idx):
	
	if Input.is_action_just_pressed("left_click"):
		Global.camera_target = self

func _on_mouse_entered():
	is_picked = true

func _on_mouse_exited():
	is_picked = false



