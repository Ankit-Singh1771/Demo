extends Node3D

var opening = false
var collecting = false
var ideal = true

@onready var animation_player = $AnimationPlayer


@export var drone: Node3D
# Called when the node enters the scene tree for the first time.

func _ready():
	animation_player.play("ideal ")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if opening and not collecting:
		animation_player.play("opening")
		
	#deppsitimg handle
	elif collecting:
		animation_player.play("collecting")
		collecting = false
	elif ideal:
		animation_player.play("ideal ")
		
	var collecting_animation = animation_player.current_animation
	var animation_time = animation_player.current_animation_position
		

func collect():
	collecting = true
	opening = false
	
func collected():
	opening = false
	collecting = false
	ideal = true
