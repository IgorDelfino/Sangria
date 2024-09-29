extends Control

class_name ChoicesButton

static var dialogue_interface : DialogueInterface

@export var margin_container : MarginContainer

var choice_id : int
var choice_text : String
var is_important : bool = false

var enabled : bool = true

@export var button_label : RichTextLabel

func _on_button_pressed():
	print("pressed")
	dialogue_interface._select_choice(choice_id, is_important)
