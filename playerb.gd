extends CharacterBody3D


const SPEED = 2
const JUMP_VELOCITY = 7
const SENSIVITY = 0.3
#customize player
@onready var customize_player_head = $"customize player"
@onready var hat1 = $"customize player/hats/hat1"
@onready var hat2 = $"customize player/hats/hat2"






# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var pivot = $head
@onready var camera = $head/Camera3D
@onready var ball = $"."
@onready var ap = $head/sword/AnimationPlayer2
var attacking = false



func _physics_process(delta):
	if Input.is_action_just_pressed("c"): 
		hat1.visible()
	
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var horizontal_direction = Input.get_axis("left","right") 
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	update_animations(horizontal_direction) 


	move_and_slide()

func update_animations(horizontal_direction):  
	if is_on_floor():
		if horizontal_direction  == 0:
			$AnimationPlayer2.play("idle")
		else: 
			$AnimationPlayer2.play("walk-normal")
		


func _on_area_3d_area_entered(area):
	if area.is_in_group("portal_lvl_1"): 
		get_tree().change_scene_to_file("res://lvl_2.tscn") 
