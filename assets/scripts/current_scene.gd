extends Node

class_name CurrentScene

@export var scene_transition_manager : SceneTransition
@export var dialogue_interface : DialogueInterface

static var scene_transition : SceneTransition
static var GAMEMANAGER : GameManager

func go_to_scene(next_scene_path : String):
	await scene_transition.replace_current_screen()
	
	GAMEMANAGER.last_scene_path = next_scene_path
	
	self.get_children()[0].queue_free()
	
	var new_scene = load(next_scene_path).instantiate()
	
	self.add_child(new_scene)
	
	scene_transition.play_transition_animation()
	return
