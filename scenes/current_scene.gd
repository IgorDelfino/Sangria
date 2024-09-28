extends Node

class_name CurrentScene

@export var scene_transition_manager : SceneTransition
@export var dialogue_interface : DialogueInterface

@export var current_location : Location
@export var scene_transition : SceneTransition

func go_to_scene(next_scene_path : String):
	await scene_transition.replace_current_screen()
	
	self.get_children()[0].queue_free()
	
	var new_location : Location = load(next_scene_path).instantiate()
	
	self.add_child(new_location)
	
	current_location = new_location
	scene_transition.play_transition_animation()
	return
