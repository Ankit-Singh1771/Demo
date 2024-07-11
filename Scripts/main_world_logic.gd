extends Node3D

const SAVE_FILE = "user://save_file.save"
var data = {}

@onready var animation_player = $"day-night/cycle"
@onready var button = $icons/Button
@onready var drone = $item_collecter
var collectables = preload("res://Scenes/container.tscn")


func _ready():
	var new_collactable = collectables.instantiate()
	var collectables_loc = Vector3(10,1,20)
	new_collactable.transform.origin = collectables_loc
	FloatingCrates.items.append(new_collactable)
	add_child(new_collactable)
	new_collecatbles()
	#new_collecatbles()
	animation_player.play("time")
	reset_data()
	load_data()
	
	
func _process(delta):
	var size = FloatingCrates.items.size()
	$icons/distance.text = str(size)
	var drone_loc_x = drone.global_transform.origin.x
	var drone_loc_y = drone.global_transform.origin.y
	var drone_loc_z = drone.global_transform.origin.z
	var final_loc = Vector3(drone_loc_x,drone_loc_y,drone_loc_z)
	
	$icons/Label2.text = str(final_loc)

func _on_button_pressed():
	# Save the current animation time
	data["time"] = animation_player.current_animation_position
	save_data()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file:
		file.store_var(data)
		file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		data = {"time": 0}
		save_data()
	else:
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file:
			data = file.get_var()
			file.close()
	# Optionally, you can use the saved time to seek the animation player to that position
	animation_player.seek(data["time"], true)
	animation_player.play("time")
func reset_data():
	data = {"time": 0}
	save_data()

func _on_button_2_pressed():
	load_data()

func new_collecatbles():
	var new_collactable = collectables.instantiate()
	var collectables_loc = Vector3(10,1,10)
	new_collactable.transform.origin = collectables_loc
	FloatingCrates.items.append(new_collactable)
	add_child(new_collactable)
