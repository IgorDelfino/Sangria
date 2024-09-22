extends Control

class_name ChoicesButton

var dialogue_interface : DialogueInterface

var choice_id : int
var choice_text : String
var is_important : bool = false

var enabled : bool = true

@export var button_label : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	button_label.text = "[center]" + choice_text + "[/center]"

func _on_button_pressed():
	dialogue_interface._select_choice(choice_id, is_important)
