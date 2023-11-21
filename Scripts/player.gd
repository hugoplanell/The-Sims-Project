extends CharacterBody3D

const SPEED = 5.0
const ACCEL = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta):
	
	var direction = Vector3()
	
	if Input.is_action_just_pressed("left_click"):
		nav.target_position = Global.player_target_pos
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	move_and_slide()
