extends VBoxContainer

class_name ChoicesContainer

const button_path : String = "res://scenes/components/choice_button.tscn"

@export var dialogue_interface : DialogueManager

func create_options(choices : Array):
	if !self.get_children().is_empty(): return
	var choice_button_scene : PackedScene = preload(button_path);
	
	var choice_id = 0
	
	for choice in choices:
		var choice_button = choice_button_scene.instantiate()
		
		choice_button.choice_id = choice_id
		choice_button.button_label.text = "[center]" + choice.text + "[/center]"
		choice_button.dialogue_interface = dialogue_interface
		
		if choice.tags:
			var current_tags = dialogue_interface.treated_tags.call(choice.tags)
			
			if current_tags.has("important"):
				choice_button.is_important = current_tags["important"]
		
		add_child(choice_button)
		choice_id += 1

func clear_options():
	var children = self.get_children()
	for child in children:
		child.queue_free()
