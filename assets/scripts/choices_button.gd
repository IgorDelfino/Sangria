extends Control

class_name ChoicesButton

static var dialogue_interface : DialogueManager

@export var margin_container : MarginContainer

var choice_id : int
var choice_text : String
var is_important : bool = false

@export var upper_texture : TextureRect
@export var lower_texture : TextureRect
@export var animation_player : AnimationPlayer

var normal_sprites = ["res://assets/sprites/ui/choice_box/normal/up.png", "res://assets/sprites/ui/choice_box/normal/down.png"]
var hover_sprites = ["res://assets/sprites/ui/choice_box/selected/up.png", "res://assets/sprites/ui/choice_box/selected/down.png"]

var enabled : bool = true

@export var button_label : RichTextLabel

func _on_button_pressed():
	print("pressed")
	dialogue_interface._select_choice(choice_id, is_important)
	
func _on_mouse_entered():
	upper_texture.texture = load(hover_sprites[0])
	lower_texture.texture = load(hover_sprites[1])
	
func _on_mouse_exited():
	upper_texture.texture = load(normal_sprites[0])
	lower_texture.texture = load(normal_sprites[1])
