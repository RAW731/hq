extends CharacterBody3D

@onready var timer1 = $"attack1 timer"


func _physics_process(delta):
	$AnimationPlayer.play("attack1")
	$AnimationPlayer.play("attack2")
	
	pass



