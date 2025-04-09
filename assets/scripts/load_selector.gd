extends Control

class_name LoadSelector

@export_dir var saves_folder
@export var load_card_containers : VBoxContainer

static var current_scene : CurrentScene

@export var scene_audio_container : SceneAudioContainer

static var scene_audio_manager : SceneAudioManager

const load_save_button = preload("res://scenes/load_card.tscn")

var save_resources : Array[SaveResource]

const main_menu_path : String = "res://scenes/main_menu.tscn"

func _ready():
	GAMEMANAGER.scene_audio_manager.overwrite_current_soundtrack(scene_audio_container)
	
	var saves : Array = DirAccess.get_files_at(saves_folder)
	
	if saves.size() == 0:
		return
	
	for save in saves:
		var save_res : SaveResource = ResourceLoader.load(saves_folder + "/" + save)
		
		var new_load_card : LoadSaveButton = load_save_button.instantiate()
		new_load_card.save_resource = save_res
		
		new_load_card.update_button_info(save_res)
		
		load_card_containers.add_child(new_load_card)
		load_card_containers.move_child(new_load_card, 0)
		

func return_to_menu():
	GAMEMANAGER.current_scene.go_to_scene(main_menu_path)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
