extends CharacterBody3D

"""
TODO:
	-Reorganizacion de codigo:
		Lo que esta relacionado con el movimiento de este script que vaya a un Node hijo que sea MovementManager
		de esta manera el Nodo Player solo gestiona el estado de control actual (en movimiento o construyendo) y
		con una pequeña maquina de estados o directamente con una variable que se cambie de estado.
	
	- En el modo construccion hacer que cada vez que construyes se recalcula el navigation map
"""

const ACCEL = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree : AnimationTree = $AnimationTree
@onready var playback : AnimationNodeStateMachinePlayback = anim_tree.get("parameters/playback")

var anim_player : AnimationPlayer

var SPEED = 2.0

var is_picked = false
var is_running = false

func _ready():
	Global.character_node = self
	
	anim_player = $character_1.get_node("AnimationPlayer")
	anim_player.play("walk")

func _process(delta):
	"""
	anim_tree.set("parameters/conditions/idle", velocity.length() < 0.25)
	anim_tree.set("parameters/conditions/walk", (velocity.length() > 0.25) and SPEED <= 2.0)
	anim_tree.set("parameters/conditions/run", SPEED > 2.0)
	"""
		
func _physics_process(delta):
	
	player_movement(delta)
	state_machine()

func state_machine() -> void:
	match playback.get_current_node():
		"idle":
			print("idling")
		"walk":
			print("walking")
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
		#self.look_at(Vector3(-nav.target_position.x, 2, -nav.target_position.z)) # va raro
		var lookdir = atan2(velocity.x, velocity.z)
		rotation.y = lerp(rotation.y, lookdir, 0.1) #al usar angulos se rompe por limitacion
		#esto sigue teniendo la limitacion del anterior porque resto lookdir - rotation.y
		#if rotation.y != lookdir:
			#rotate_y((lookdir - rotation.y) / 10)
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	
	move_and_slide()

func _on_input_event(camera, event, position, normal, shape_idx):
	
	if Input.is_action_just_pressed("left_click"):
		Global.camera_target = self

func _on_mouse_entered():
	is_picked = true

func _on_mouse_exited():
	is_picked = false



