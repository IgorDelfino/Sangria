extends Button

class_name LoadSaveButton

static var current_scene : CurrentScene

var save_resource : SaveResource

func update_button_info(save):
	text = "Save " + save.name + " - " + save.created_at

func _on_load_game_pressed():
	print("<> ", save_resource.ink_state_in_json, " <>")
	GAMEMANAGER.current_scene.go_to_scene(save_resource.last_scene_path, save_resource.ink_state_in_json)
	
