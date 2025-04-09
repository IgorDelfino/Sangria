extends Node2D

class_name Location

static var sound_stream : AudioStreamPlayer2D

static var current_scene : CurrentScene

static var dialogue_manager : DialogueManager

@export_file("*.ink.json") var ink_file_path

@export var scene_audio_container : SceneAudioContainer

func _ready():
	GAMEMANAGER.dialogue_interface.load_story(ink_file_path)
