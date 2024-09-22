extends Control

class_name DialogueInterface

@onready var _ink_player = $InkPlayer

@export var choices_container : ChoicesContainer
@export var ink_file_path = "res://assets/ink files/bar1alterna.ink.json"
@export var dialogue_label : DialogueLabel
@export var name_label : NameLabel
@export var animation_player : AnimationPlayer

@export var typing_speed : float = 0.05

var button_path = "res://scenes/components/choice_button.tscn"

var is_choice_important

var story_in_progress : bool = false
var typing_in_progress : bool = false

func _ready():
	self.hide()
	_ink_player.ink_file = load(ink_file_path)
	_ink_player.loads_in_background = true
	
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
	_ink_player.choose_path("OpenBar")

func organize_line_tags(tags : Array):
	var tag_dictionary : Dictionary = {}
	for tag : String in tags:
		var tag_no_spaces = tag.strip_edges(true,true)
		var key_value_pair = tag_no_spaces.split(":")
		
		if key_value_pair[1] == "true" or key_value_pair[1] == "true":
			var bool_value = key_value_pair[1] == "true" if true else false
			tag_dictionary[key_value_pair[0]] = bool_value
			return tag_dictionary
		
		tag_dictionary[key_value_pair[0]] = key_value_pair[1]
	return tag_dictionary

func _continue_story(ink_file_path : String, knot_address : String):
	if self.hidden: self.show()
	story_in_progress = true
	print(_ink_player.current_path)
	if _ink_player.can_continue and !_ink_player.has_choices:
		var text = _ink_player.continue_story()
		
		if !_ink_player.get_current_tags().is_empty():
			var tags = organize_line_tags(_ink_player.get_current_tags())
			
			if tags.has("char"):
				name_label.change_name_label(tags["char"])
		
		dialogue_label.visible_characters = 0
		
		dialogue_label.text = text
		
		type_out_line(text)
		
	elif _ink_player.has_choices:
		choices_container.create_options(_ink_player.current_choices)
	
	else:
		story_in_progress = false
		self.hide()

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
