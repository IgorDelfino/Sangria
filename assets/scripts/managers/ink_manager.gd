extends Control

class_name DialogueManager

@export var _ink_player : InkPlayer

@export var DialogueLabel : RichTextLabel
@export var NameLabel : RichTextLabel

@export var DialogueBox : TextureRect
@export var choices_container : ChoicesContainer

@export var text_type_time : float = 5.0

@export var timer : Timer

@export var bite_animator : AnimationPlayer

var current_ink_file_json_path : String

var typing_state : bool = false
var can_call_next_sentence : bool = false

var available_objective_keys = []

var ink_state_text : String

signal call_next_sentence
signal finished_typing

var story_has_been_loaded : bool

var is_talking : bool = false
var waiting_for_choice : bool = false

var current_clickable : InteractableArea

var state_to_load : String = ""

func prime_new_state(last_scene_path, state):
	state_to_load = state

func load_story(ink_file_path):
	print("++++ Story is being loaded ++++")
	story_has_been_loaded = false
	_ink_player.ink_file = load(ink_file_path)
	
	
	print("<l> ",state_to_load," <l>")
	
	await _ink_player.create_story()
	

func _ready():
	GAMEMANAGER.dialogue_interface = self
	
	GAMEMANAGER.new_location.connect(load_story)
	GAMEMANAGER.load_new_state.connect(prime_new_state)
	
	_ink_player.connect("loaded", _story_loaded)
	_ink_player.connect("continued", _continued)
	_ink_player.connect("prompt_choices", _prompt_choices)
	_ink_player.connect("ended", _ended)
	
	finished_typing.connect(await_next_sentence_signal)
	

func await_next_sentence_signal():
	typing_state = false
	can_call_next_sentence = true

func _input(event):
	if event.is_action_pressed("skip_typing"):
		if can_call_next_sentence:
			call_next_sentence.emit()
			can_call_next_sentence = false
		elif is_talking:
			#Global.play_sfx.emit("skip_dialogue")
			DialogueLabel.visible_characters = -1
			await_next_sentence_signal()

func change_knot_stitch_gather(override_key: String = ""):
	if override_key != "":
		_ink_player.choose_path(override_key)
	else:
		_ink_player.choose_path(override_key)
	
	is_talking = true
	
	_ink_player.continue_story()

func _select_choice(choice_id : int, important : bool):
	
	_ink_player.choose_choice_index(choice_id)
	
	if important:
		bite_animator.play("bite_animation")
	
	choices_container.clear_options()
	waiting_for_choice = false

	_ink_player.continue_story()

#region Ink Signals

func _story_loaded(success: bool):
	if !success:
		return
	
	story_has_been_loaded = true
	
	print("++++ Story was loaded ++++")

	await _ink_player.set_variable("is_game", true)
	
	if state_to_load != "":
		await _ink_player.set_state(state_to_load)
	
var treated_tags = func (tags):
		var temp_dictionary : Dictionary
		
		for tag in tags:
			var split_tag = tag.split(": ")
			temp_dictionary[split_tag[0]] = split_tag[1]
		
		return temp_dictionary

func _continued(text, tags):
	self.visible = true
	
	typing_state = true
	
	var current_tags = treated_tags.call(tags)
		
	print(current_tags)
	
	if current_tags.has("autosave"):
		
		var state = await _ink_player.get_state()
		
		GAMEMANAGER.save_player_data(state)
	
	DialogueLabel.visible_characters = 0
	DialogueLabel.text = text.replace("\"", "")
	if current_tags.has("char"):
		NameLabel.text = ("[p align=center]" + current_tags["char"])
	
	while DialogueLabel.visible_characters <= text.length() and DialogueLabel.visible_characters != -1:
		DialogueLabel.visible_characters += 1
		await get_tree().create_timer(0.05).timeout
	
	finished_typing.emit()
	
	await call_next_sentence
	
	_ink_player.continue_story()

func _prompt_choices(choices):
	if choices.size() > 0:
		choices_container.create_options(choices)
		
		waiting_for_choice = true

func _ended():
	is_talking = false
	
	self.visible = false
	
	state_to_load = ""
	
	#Global.finished_dialogue.emit()

#endregion
