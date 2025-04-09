extends Control

class_name MainMenu

@export var scene_audio_container : SceneAudioContainer

func _ready():
	GAMEMANAGER.scene_audio_manager.overwrite_current_soundtrack(scene_audio_container)
