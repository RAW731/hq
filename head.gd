extends Node3D

var player
@onready var cam_col = $Camera3D/RayCast3D
@onready var camera = $Camera3D
@export var sensivity := 5
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	global_position = player.global_position



func _unhandled_input(event):
	if  cam_col.is_colliding(): 
		camera.global_transform.origin = lerp(camera.global_transform.origin,  cam_col.get_collision_point(), 0.2)
	else: 
		if event is InputEventScreenDrag: 
			var tempRot = rotation.x - event.relative.y / 1000 * sensivity
			rotation.y -= event.relative.x / 1000 * sensivity
			tempRot = clamp(tempRot,-1, 0.25)
			$Camera3D.look_at(player.get_node("LookAt").global_position) 
