extends Node

class_name InteractableArea

enum interactableType {
	Dialogue,
	Inventory,
	Prompt
}

@export var InteractableType : interactableType

@export_subgroup("Dialogue")
@export var ink_knot : String

@export var dialogue_interface : DialogueInterface

func _on_area_2d_got_clicked() -> void:
	match InteractableType:
		interactableType.Dialogue:
			print("Isso é para ativar um diálogo")
			dialogue_interface.current_clickable = self
			dialogue_interface._continue_story(ink_knot)
		interactableType.Inventory:
			print("Isso é para guardar um item no inventário")
		interactableType.Prompt:
			print("Isso é para fazer algum prompt")
