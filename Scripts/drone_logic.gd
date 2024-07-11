extends Node3D

var in_work = false
var speed = 5
var depositing = false
var deposited = true

@onready var animation_player = $AnimationPlayer
@onready var ray = $RayCast3D
@onready var container = $placeholder

@export var player: CharacterBody3D
@export var main_storage: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("flying")
	container.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var player_loc_x = player.global_transform.origin.x
	var player_loc_y = player.global_transform.origin.y
	var player_loc_z = player.global_transform.origin.z
	
	if in_work:
		var crates = []
		crates = FloatingCrates.items
		
		if crates.size() > 0:
			# Find the nearest crate
			var nearest_crate = crates[0]
			var shortest_distance = global_transform.origin.distance_to(nearest_crate.global_transform.origin)
			
			for crate in crates:
				var distance = global_transform.origin.distance_to(crate.global_transform.origin)
				if distance < shortest_distance:
					shortest_distance = distance
					nearest_crate = crate
					
				# Get the location of the nearest crate
			var loc_x = nearest_crate.global_transform.origin.x
			var loc_y = nearest_crate.global_transform.origin.y
			var loc_z = nearest_crate.global_transform.origin.z
			# Move towards the nearest crate
			
			global_transform.origin = global_transform.origin.lerp(Vector3(loc_x, loc_y+3, loc_z), speed * delta * 0.1)
	elif depositing:
		in_work = false
		depositing = true
		
		var storage_pos_x = main_storage.global_transform.origin.x
		var storage_pos_y = main_storage.global_transform.origin.y
		var storage_pos_z = main_storage.global_transform.origin.z
		
		global_transform.origin = global_transform.origin.lerp(Vector3(storage_pos_x, storage_pos_y + 3, storage_pos_z), speed * delta * 0.1)
		
	else:
		global_transform.origin = global_transform.origin.lerp(Vector3(player_loc_x, player_loc_y +5, player_loc_z +3), speed * delta * 0.1)
	# raycast handling.
	if ray.is_colliding():
		var collider = ray.get_collider().get_parent()
		$Label.text = "colliding: " + str(collider)
		if collider.is_in_group("collectables") and in_work and deposited:
			collider.queue_free()
			
			if FloatingCrates.items.has(collider):
				FloatingCrates.items.erase(collider)
				container.visible = true
				animation_player.play("collecting")
				depositing = true
				in_work = false
				deposited = false
		
		elif collider.is_in_group("main_storage") and depositing and not deposited:
			collider.collect()
			animation_player.play("deposting")
			var timing = animation_player.current_animation_position
			if timing > 4.9:
				depositing = false
				in_work = true
				deposited = true
				container.visible = false
				main_storage.collected()
				animation_player.play("flying")

func work_command():
	in_work = not in_work
		


	
