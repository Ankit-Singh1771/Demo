extends Node3D

@export var player: CharacterBody3D
var speed: float = 1.0

@onready var in_work = false
@onready var ray = $drone_model/RayCast3D

func _ready():
	pass

func _process(delta):
	var player_loc_x = player.global_transform.origin.x
	var player_loc_y = player.global_transform.origin.y
	var player_loc_z = player.global_transform.origin.z
	
	if not in_work:
		global_transform.origin = global_transform.origin.lerp(Vector3(player_loc_x, player_loc_y + 4.0, player_loc_z + 2), speed * delta * 0.1)
	else:
		pass
		
func work_command():
	in_work = not in_work
