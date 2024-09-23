extends Area2D

signal gotClicked

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		gotClicked.emit()
