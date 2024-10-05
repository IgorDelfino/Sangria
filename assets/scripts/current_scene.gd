extends Node

class_name CurrentScene

@export var dialogue_interface : DialogueInterface

static var scene_transition : SceneTransition
static var GAMEMANAGER : GameManager

@export var ambience_stream : AudioStreamPlayer2D
@export var soundtrack_stream : AudioStreamPlayer2D

@export var scene_sound_manager : SceneAudioManager

func go_to_scene(next_scene_path : String):
	await scene_transition.replace_current_screen()
	
	GAMEMANAGER.last_scene_path = next_scene_path
	
	self.get_children()[0].queue_free()
	
	var new_scene = load(next_scene_path).instantiate()
	
	self.add_child(new_scene)
	
	scene_sound_manager.overwrite_current_soundtrack(new_scene.scene_audio_container)
	
	scene_transition.play_transition_animation()
	return
