extends Node3D

const water_level = 0
const gravity = 9.8

func _ready():
	$AnimationPlayer.play("floating ")

func _physics_process(delta):
	if global_transform.origin.y > 0 or global_transform.origin.y <0:
		
		var loc_x = global_transform.origin.x
		var loc_z = global_transform.origin.z
		
		global_transform.origin = global_transform.origin.lerp(Vector3(loc_x, 0, loc_z), gravity * delta)
		
	else:
		pass
