extends VBoxContainer

class_name MainMenuButtons

static var GAMEMANAGER : GameManager
static var current_scene : CurrentScene

@export_file("*.tscn") var game_start_scene

func start_new_game():
	GAMEMANAGER.save_player_data()
	current_scene.go_to_scene(game_start_scene)
	
func load_game():
	GAMEMANAGER.load_player_data()
	current_scene.go_to_scene(GAMEMANAGER.last_scene_path)
	
func exit_game():
	return
