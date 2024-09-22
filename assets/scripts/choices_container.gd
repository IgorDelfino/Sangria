extends VBoxContainer

class_name ChoicesContainer

const button_path : String = "res://scenes/components/choice_button.tscn"

@export var dialogue_interface : DialogueInterface

func create_options(choices : Array):
	if !self.get_children().is_empty(): return
	var choice_button_scene : PackedScene = preload(button_path);
	
	var choice_id = 0
	
	for choice in choices:
		var choice_button = choice_button_scene.instantiate()
		
		choice_button.choice_id = choice_id
		choice_button.choice_text = choice.text
		choice_button.dialogue_interface = dialogue_interface
		
		if choice.tags:
			var tags_dictionary = dialogue_interface.organize_line_tags(choice.tags)
			
			if tags_dictionary.has("important"):
				choice_button.is_important = tags_dictionary["important"]
		
		add_child(choice_button)
		choice_id += 1w

func clear_options():
	var children = self.get_children()
	for child in children:
		child.queue_free()
