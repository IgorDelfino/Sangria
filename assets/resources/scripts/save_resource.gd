extends Resource

class_name SaveResource

@export var name: String
@export var created_at: String
@export var last_scene_path: String
@export var ink_state_in_json: String

func timestamp_creation():
	var current_time_dict := Time.get_datetime_dict_from_system()
	
	created_at = str(current_time_dict.month) + "/" + str(current_time_dict.day) + "/" + str(current_time_dict.year) + " " + str(current_time_dict.hour) + ":" + str(current_time_dict.minute)
