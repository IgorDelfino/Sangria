extends Node

class_name SaveManager

var inicial_save_path : String = "res://saves/"

var save_counter_path : String = "res://save_counter.tres"

var save_counter : SaveCounter

func _ready():
	GAMEMANAGER.save_manager = self
	
	save_counter = ResourceLoader.load(save_counter_path)

func get_save_count():
	return save_counter.number_of_saves

func save_game(save_resource):
	save_resource.timestamp_creation()
	
	var save_name_buffer := []
	
	while save_name_buffer.size() < 3 - str(save_counter.number_of_saves).length():
		save_name_buffer.append("0")
	
	save_name_buffer.append(str(save_counter.number_of_saves))
	
	save_resource.name = "".join(save_name_buffer)
	
	print("save_resource.name: ",save_resource.name)
	
	save_counter.number_of_saves += 1
	
	print("current number of saves: ", save_counter.number_of_saves)
	
	ResourceSaver.save(save_counter, save_counter_path)
	
	ResourceSaver.save(save_resource, inicial_save_path + save_resource.name + ".tres" )
