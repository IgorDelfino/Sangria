extends Control

class_name DialogueInterface

@onready var _ink_player = $InkPlayer

@export var choices_container : ChoicesContainer
@export_file("*.json") var ink_file_path = "res://assets/ink files/bar1alterna.ink.json"
@export var dialogue_label : DialogueLabel
@export var name_label : NameLabel
@export var animation_player : AnimationPlayer
@export var character_portrait : Sprite2D

@export var typing_speed : float = 0.05

@export_dir var portraits

var button_path = "res://scenes/components/choice_button.tscn"

var is_choice_important

var story_in_progress : bool = false
var typing_in_progress : bool = false

var current_char : String

var current_clickable : InteractableArea

func _ready():
	self.hide()
	_ink_player.ink_file = load(ink_file_path)
	_ink_player.loads_in_background = true
	
	__GameManager.load_player_data()
	
	await _ink_player.create_story()

func _process(_delta):
	if typing_in_progress and Input.is_action_just_pressed("skip_typing"):
		_skip_text_typing()
	elif story_in_progress and Input.is_action_just_pressed("next_dialogue"):
		_continue_story()
	return

func _story_loaded(success : bool):
	if !success:
		return
		
	if __GameManager.get_loaded_ink_state():
		_ink_player.set_state(__GameManager.get_loaded_ink_state())
	
func organize_line_tags(tags : Array):
	var tag_dictionary : Dictionary = {}
	
	for tag : String in tags:
		var tag_no_spaces = tag.strip_edges(true,true)
		var key_value_pair = tag_no_spaces.split(":")
		
		if key_value_pair[1] == "true" or key_value_pair[1] == "false":
			var bool_value = key_value_pair[1] == "true" if true else false
			tag_dictionary[key_value_pair[0]] = bool_value
			return tag_dictionary
		
		tag_dictionary[key_value_pair[0]] = key_value_pair[1]
	
	return tag_dictionary

func _continue_story(knot_address : String = ""):
	if knot_address.length() > 0:
		_ink_player.choose_path(knot_address)
	
	#current_clickable.hide()
	
	if self.hidden: self.show()
	
	story_in_progress = true
	
	if _ink_player.can_continue and !_ink_player.has_choices:
		var text = _ink_player.continue_story()
		
		if !_ink_player.get_current_tags().is_empty():
			var tags = organize_line_tags(_ink_player.get_current_tags())
			if tags.has("char"):
				name_label.change_name_label(tags["char"])
				current_char = tags["char"].strip_edges(true,true).to_lower()
				
				if tags.has("mood"):
					character_portrait.texture = load(portraits + "/" + current_char + "/" + tags["mood"] + ".png")
				else:
					character_portrait.texture = load(portraits + "/" + current_char + "/neutral.png")
				
		
		dialogue_label.visible_characters = 0
		
		dialogue_label.text = text
		
		type_out_line(text)
		
	elif _ink_player.has_choices:
		choices_container.create_options(_ink_player.current_choices)
		__GameManager.save_player_data()
	
	else:
		story_in_progress = false
		self.hide()
		#current_clickable.show()
		

func _skip_text_typing():
	dialogue_label.visible_characters = -1
	
func type_out_line(text : String):
	typing_in_progress = true
	
	while dialogue_label.visible_characters != -1 or dialogue_label.visible_characters > text.length():
		dialogue_label.visible_characters += 1
		await get_tree().create_timer(0.05).timeout
		pass
		
	typing_in_progress = false

func _select_choice(choice_id : int, important : bool):
	_ink_player.choose_choice_index(choice_id)
	
	if important:
		animation_player.play("bite_animation")
	
	choices_container.clear_options()
	self._continue_story()
