extends Node

enum interactableType {
	Dialogue,
	Inventory,
	Prompt
}
@export var InteractableType : interactableType

func _on_area_2d_got_clicked() -> void:
	match InteractableType:
		interactableType.Dialogue:
			print("Isso é para ativar um diálogo")
		interactableType.Inventory:
			print("Isso é para guardar um item no inventário")
		interactableType.Prompt:
			print("Isso é para fazer algum prompt")
