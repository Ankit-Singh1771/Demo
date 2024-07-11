extends MeshInstance3D

# Physics properties
var water_level = 0.0
var float_height = 1.0
var bounce_damp = 0.3
var water_density = 1.0

# Movement properties
var velocity = Vector3.ZERO
var gravity = Vector3(0, -9.8, 0)
var drag = 0.1

@onready var attached = false

@onready var location_x
@onready var location_y
@onready var location_z

func _ready():
	# Connect the "_process" function to the physics processing
	set_physics_process(true)
	$AnimationPlayer.play("floating")
	

func _physics_process(delta):
	# Calculate the forces acting on the object
	var force = calculate_buoyancy()
	force += gravity
	
	# Update the velocity based on the force
	velocity += force * delta
	
	# Apply drag to the velocity
	velocity *= (1.0 - drag * delta)
	
	# Update the position based on the velocity
	translate(velocity * delta)
	
	# Clamp the position to ensure it doesn't sink below the water level
	if global_transform.origin.y < water_level:
		global_transform.origin.y = water_level
		velocity.y = max(velocity.y, 0)
		
		
	# transporting logic -->
	if attached:
		pass
	
		
		

func calculate_buoyancy():
	var depth = water_level - global_transform.origin.y
	var buoyancy = Vector3.ZERO
	
	if depth > 0:
		# Apply buoyancy force
		buoyancy = Vector3(0, water_density * depth - bounce_damp * velocity.y, 0)
		
	return buoyancy

func attached_to_collider():
	attached = true
