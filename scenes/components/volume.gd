extends VBoxContainer

class_name VolumeController

@export var main_slider : HSlider
@export var bgm_slider : HSlider
@export var sfx_slider : HSlider

var audio_manager : SceneAudioManager

static var main_volume : float
static var bgm_volume : float
static var sfx_volume : float

var volume_resource_path : String = "res://volume_keeper.tres"

func _ready():
	var volume : SoundConfigKeeper = ResourceLoader.load(volume_resource_path)
	
	if volume is not SoundConfigKeeper:
		print("volume is keeper")
		var sound_config_keeper := SoundConfigKeeper.new()
		
		sound_config_keeper.main = 0.5
		sound_config_keeper.bgm = 1
		sound_config_keeper.sfx = 1
		
		ResourceSaver.save(sound_config_keeper, volume_resource_path)
		
		_update_main_volume(sound_config_keeper.main)
		_update_bgm_volume(sound_config_keeper.bgm)
		_update_sfx_volume(sound_config_keeper.sfx)
		return
	
	_update_main_volume(volume.main)
	_update_bgm_volume(volume.bgm)
	_update_sfx_volume(volume.sfx)

func _change_bus_volume(bus_name_array : Array[String], new_value: float):
	for bus in bus_name_array:
		var bus_index = AudioServer.get_bus_index(bus)
		
		print("+++ bus ", bus, " entered change vol function with index ", bus_index, "+++")
		
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
	
	var new_sound_keeper : SoundConfigKeeper = SoundConfigKeeper.new()
	
	new_sound_keeper.main = main_volume
	new_sound_keeper.bgm = bgm_volume
	new_sound_keeper.sfx = sfx_volume
	
	ResourceSaver.save(new_sound_keeper, volume_resource_path)

func _update_main_volume(new_value : float):
	main_volume = new_value
	main_slider.set_value_no_signal(new_value)
	_change_bus_volume(["Master"], new_value)
	pass

func _update_bgm_volume(new_value : float):
	bgm_volume = new_value
	bgm_slider.set_value_no_signal(new_value)
	_change_bus_volume(["Soundtrack"], bgm_volume)
	pass
	
func _update_sfx_volume(new_value : float):
	sfx_volume = new_value
	sfx_slider.set_value_no_signal(new_value)
	_change_bus_volume(["Ambience", "MuffledAmbience"], sfx_volume)
	
	pass
