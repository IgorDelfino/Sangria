extends Control

@export var current_scene : CurrentScene
@export var dialogue_interface : DialogueManager

var should_restore_dialogue_interface : bool = false

var paused : bool = false

func _ready():
	self.hide()

func toggle_pause():
	should_restore_dialogue_interface = dialogue_interface.is_talking
	
	if paused:
		current_scene.process_mode = Node.PROCESS_MODE_INHERIT
		dialogue_interface.process_mode = Node.PROCESS_MODE_INHERIT
		if should_restore_dialogue_interface:
			dialogue_interface.show()
		
		self.hide()
	else:
		current_scene.process_mode = Node.PROCESS_MODE_DISABLED
		dialogue_interface.process_mode = Node.PROCESS_MODE_DISABLED
		dialogue_interface.hide()
		self.show()
	
	paused = !paused
		
func _input(event):
	if event.is_action_pressed("pause_game"):
		if current_scene.get_child(0) is Location:
			toggle_pause()
		else:
			print("++++++++++ Not Location ++++++++++")
		

func resume_game():
	toggle_pause()

func back_to_main_menu():
	toggle_pause()
	current_scene.go_to_scene("res://scenes/main_menu.tscn")
	
func options():
	pass
	
func quit_game():
	get_tree().quit()
