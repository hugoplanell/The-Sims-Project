extends CharacterBody3D

const ACCEL = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree : AnimationTree = $AnimationTree
@onready var playback : AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")

var current_action_object : Prop3D

var SPEED = 2.0

var is_picked = false
var is_running = false

func _ready():
	#Global.character_node = self # esto se deberia de quitar si hay mas de un character
	pass
	
func _process(delta):
	"""
	anim_tree.set("parameters/conditions/idle", velocity.length() < 0.25)
	anim_tree.set("parameters/conditions/walk", (velocity.length() > 0.25) and SPEED <= 2.0)
	anim_tree.set("parameters/conditions/run", SPEED > 2.0)
	"""
	pass
		
func _physics_process(delta):
	#print(is_picked, Global.character_node)
	player_movement(delta)
	state_machine()

func state_machine() -> void:
	match playback.get_current_node():
		"idle":
			pass
			#print("idling")
		"walk":
			#print("walking")
			if((nav.target_position - self.global_position).length() > 20):
				SPEED = 4.0
		"run":
			if((nav.target_position - self.global_position).length() < 5):
				SPEED = 2.0

func player_movement(delta: float):
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	if velocity.length() > 0: #Ajustar este numero para corregir la transición
		var lookdir = atan2(velocity.x, velocity.z)
		
		var character_basis = self.transform.basis.get_rotation_quaternion()
		var rotate_basis = Basis(Vector3(0, 1, 0), lookdir).get_rotation_quaternion()
		
		var new_character_basis = character_basis.slerp(rotate_basis, 0.1)
		
		transform.basis = Basis(new_character_basis)
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	move_and_slide()

func _on_input_event(camera, event, position, normal, shape_idx):
	
	if Input.is_action_just_pressed("left_click"):
		if Global.character_node != self:
			Global.character_node = self
		else:
			is_picked = true
