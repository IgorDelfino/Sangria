extends Control

var current_animation_frame := 0

@export var full_frame : TextureRect
@export var fading_frame : TextureRect
@export var button_animation_container : HBoxContainer

@export var keycap_animation_player : AnimationPlayer
@export var animation_player : AnimationPlayer

@export_dir var frames_dir_path

@export var scene_audio_container : SceneAudioContainer

@export_file("*.tscn") var next_scene_path : String

static var current_scene : CurrentScene

signal hq_animation_finished

var input_pressed_should_go_next_scene := false

var frame_path_array : PackedStringArray

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if input_pressed_should_go_next_scene and Input.is_action_just_pressed("skip_cutscene_frame"):
		current_scene.go_to_scene(next_scene_path)
	if Input.is_action_just_pressed("skip_cutscene_frame"):
		skip_frame_fade()
	pass
	
func is_png(filename : String):
	return filename.ends_with(".png")
	
func _ready():
	current_animation_frame = 0
	var frames_dir = DirAccess.open(frames_dir_path)
	
	if frames_dir:
		for filename in frames_dir.get_files():
			if is_png(filename):
				print("filename: ", filename)
				frame_path_array.append(filename)
	
	full_frame.texture = load(frames_dir_path + "/" + frame_path_array[current_animation_frame])
	animation_player.play("fade_color_rect")
	
func display_next_frame():
	current_animation_frame += 1
	if current_animation_frame == frame_path_array.size():
		print("should have emitted signal")
		hq_animation_finished.emit()
		return
	fading_frame.texture = load(frames_dir_path + "/" + frame_path_array[current_animation_frame])
	
	animation_player.play("fade_new_frame")
	
func show_button_press_animation():
	input_pressed_should_go_next_scene = true
	keycap_animation_player.play("press_button_animation")
	button_animation_container.visible = true
	
func skip_frame_fade():
	animation_player.advance(2)
	
func _on_frame_fader_animation_finished(anim_name):
	if anim_name == "fade_color_rect":
		display_next_frame()
	
	if anim_name == "fade_new_frame":
		full_frame.texture = fading_frame.texture
		
		display_next_frame()
