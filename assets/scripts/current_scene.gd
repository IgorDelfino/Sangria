extends Node

class_name CurrentScene

@export var dialogue_interface : DialogueManager

@export var ambience_stream : AudioStreamPlayer2D
@export var soundtrack_stream : AudioStreamPlayer2D

@export var scene_sound_manager : SceneAudioManager

func _ready():
	GAMEMANAGER.current_scene = self
	
	GAMEMANAGER.state_loaded.connect(load_scene)

func go_to_scene(next_scene_path : String, state : String = ""):
	if state == "":
		load_scene(next_scene_path)
	else:
		GAMEMANAGER.load_new_state.emit(next_scene_path, state)
		load_scene(next_scene_path)

func load_scene(next_scene_path):
	await GAMEMANAGER.scene_transition_manager.replace_current_screen()
	
	GAMEMANAGER.last_scene_path = next_scene_path
	
	self.get_children()[0].queue_free()
	
	var new_scene = load(next_scene_path).instantiate()
	
	self.add_child(new_scene)
	
	if new_scene is Location:
		GAMEMANAGER.new_location.emit(new_scene.ink_file_path)
	
	scene_sound_manager.overwrite_current_soundtrack(new_scene.scene_audio_container)
	
	GAMEMANAGER.scene_transition_manager.play_transition_animation()
	return
