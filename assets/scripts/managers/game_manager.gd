extends Node

class_name GameManager

const Interactable := preload("res://assets/scripts/Interactables.gd")
const Scene := preload("res://assets/scripts/current_scene.gd")
const MasterLocation := preload("res://assets/scripts/location.gd")

@export var scene_transition : SceneTransition

@export var dialogue_interface : DialogueInterface
@export var current_scene : CurrentScene

var player_file = "user://save.dat"
var ink_state : JSON

func _ready():
	var interactable = Interactable.new()
	interactable.dialogue_interface = dialogue_interface
	interactable.current_scene = current_scene
	
	print(interactable.dialogue_interface)
	
	Scene.scene_transition = scene_transition
	
	MasterLocation.current_scene = current_scene
	
	

func create_player_data():
	var player_data_dictionary = {
		"INK_STATE": ink_state,
	}
	
	return player_data_dictionary

func save_player_data():
	print("tried to save player data")
	var file = FileAccess.open(player_file, FileAccess.WRITE)
	var player_data = create_player_data()
	
	file.store_var(player_data)
	
	print("Data saved")

func load_player_data():
	var file = FileAccess.open(player_file, FileAccess.READ)
	
	if FileAccess.file_exists(player_file):
		var loaded_player_data = file.get_var()
		ink_state = loaded_player_data.INK_STATE

func get_loaded_ink_state():
	print("got loaded ink state")
	return ink_state
