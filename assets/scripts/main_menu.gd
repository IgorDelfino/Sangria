extends Control

class_name MainMenu

@export var scene_audio_container : SceneAudioContainer

static var scene_audio_manager : SceneAudioManager

func _ready():
	scene_audio_manager.overwrite_current_soundtrack(scene_audio_container)
