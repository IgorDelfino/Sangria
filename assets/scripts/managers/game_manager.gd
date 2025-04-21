extends Node

class_name GameManager

const Interactable := preload("res://assets/scripts/Interactables.gd")
const Scene := preload("res://assets/scripts/current_scene.gd")
const LocationInstance := preload("res://assets/scripts/location.gd")
const DialogueInterfaceInstance := preload("res://assets/scripts/managers/ink_manager.gd")
const HQCutsceneInstance := preload("res://assets/scripts/hq_cutscene.gd")
const MainMenuButtonsInstance := preload("res://assets/scripts/main_menu_buttons.gd")
const MainMenuInstance := preload("res://assets/scripts/main_menu.gd")
const LoadSelectorInstance := preload("res://assets/scripts/load_selector.gd")
const LoadCardInstance := preload("res://assets/scripts/load_card.gd")
# const SceneAudioContainerInstance := preload("")

const saves_folder_path = "res://saves/"

var dialogue_interface : DialogueManager
var current_scene : CurrentScene
var scene_audio_manager : SceneAudioManager
var save_manager : SaveManager
var scene_transition_manager : SceneTransitionManager

signal load_new_state(next_scene_path, new_state)
signal state_loaded(next_scene_path)
signal hide_dialogue_box()
signal finished_loading()
signal new_location(ink_file_path : String)

var last_scene_path : String
var loaded_ink_state : String

func save_player_data( ink_state : String ):
	var save_resource : SaveResource = SaveResource.new()
	
	save_resource.ink_state_in_json = ink_state
	save_resource.last_scene_path = last_scene_path

	save_manager.save_game(save_resource)
