extends Area2D

signal gotClicked

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Interact"):
		gotClicked.emit()
