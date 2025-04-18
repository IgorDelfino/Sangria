extends Node

class_name InteractableArea

enum interactableType {
	Dialogue,
	Inventory,
	Prompt,
	Transport
}

@export var InteractableType : interactableType

@export var location : Location

@export_subgroup("Dialogue")
@export var ink_knot : String

static var dialogue_interface : DialogueManager

@export_subgroup("Transport")
@export_file("*.ink.json") var ink_file_path
@export_file("*.tscn") var scene_path : String

static var current_scene : CurrentScene
	
func _on_area_2d_got_clicked() -> void:
	match InteractableType:
		interactableType.Dialogue:
			GAMEMANAGER.dialogue_interface.current_clickable = self
			GAMEMANAGER.dialogue_interface.change_knot_stitch_gather(ink_knot)
		interactableType.Inventory:
			print("Isso é para guardar um item no inventário")
		interactableType.Transport:
			GAMEMANAGER.current_scene.go_to_scene(scene_path)
			#dialogue_interface.replace_current_ink_file(ink_file_path)
			#dialogue_interface._ink_player.create_story()
