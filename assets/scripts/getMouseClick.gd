extends Area2D

signal gotClicked

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("interact"):
		get_viewport().set_input_as_handled()
		gotClicked.emit()
