extends Node

const SAVE_FILE = "user://save_file.save"
var data = {}

func _ready():
	load_data()

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
