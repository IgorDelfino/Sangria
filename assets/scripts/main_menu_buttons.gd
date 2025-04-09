extends VBoxContainer

class_name MainMenuButtons

@export var load_game_button : Button

@export_file("*.tscn") var game_start_scene
@export_file("*.tscn") var game_load_scene

var save_dir = DirAccess.open("res://saves/")

func _ready():
	var content = save_dir.get_files_at("res://saves/")
	
	if content.size() > 0:
		load_game_button.disabled = false
	
func start_new_game():
	GAMEMANAGER.current_scene.go_to_scene(game_start_scene)
	
func load_game():
	GAMEMANAGER.current_scene.go_to_scene(game_load_scene)
	
func exit_game():
	return
