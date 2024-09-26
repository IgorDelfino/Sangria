extends Node

class_name GameManager

var player_file = "user://save.dat"
var ink_state : JSON

var Instance : GameManager

func _ready():
	if !Instance is GameManager:
		Instance = self

func save_player_data():
	print("tried to save player data")
	var file = FileAccess.open(player_file, FileAccess.WRITE)
	var player_data = create_player_data()
	
	file.store_var(player_data)
	
	print("Data saved")

func create_player_data():
	var player_data_dictionary = {
		"INK_STATE": ink_state,
	}
	
	return player_data_dictionary

func load_player_data():
	var file = FileAccess.open(player_file, FileAccess.READ)
	
	if FileAccess.file_exists(player_file):
		var loaded_player_data = file.get_var()
		ink_state = loaded_player_data.INK_STATE

func get_loaded_ink_state():
	print("got loaded ink state")
	return ink_state
